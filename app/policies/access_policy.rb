class AccessPolicy
  include AccessGranted::Policy

  def configure
    # Example policy for AccessGranted.
    # For more details check the README at
    #
    # https://github.com/chaps-io/access-granted/blob/master/README.md
    #
    # Roles inherit from less important roles, so:
    # - :admin has permissions defined in :member, :guest and himself
    # - :member has permissions from :guest and himself
    # - :guest has only its own permissions since it's the first role.
    #
    # The most important role should be at the top.
    # In this case an administrator.
    #
    role :admin, proc { |user| user.admin? } do
      can :manage, User
      can :manage, UserBook
      can :manage, Book
      can :manage, Event
      can :manage, Note
    end

    # More privileged role, applies to registered users.
    #
    role :member do
      can [:create, :read, :update], User
      can :manage, UserBook do |user_book, user|
        user_book.user_id == user.id
      end
      can [:create, :read], Book
      can [:update, :destroy], Book do |book, user|
        book.library_book(user, book).first.user_id == user.id && book.edittable?
      end
      can :manage, Event do |event, user|
        event.user_id == user.id
      end
      can :manage, Note do |note, user|
        note.user_id == user.id
      end
    end

    # The base role with no additional conditions.
    # Applies to every user.
    #
    # role :guest do
    #  can :read, Post
    #  can :read, Comment
    # end
  end
end
