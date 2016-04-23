class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from "AccessGranted::AccessDenied" do |exception|
    redirect_to root_path, notice: "You don't have permission to do that."
  end

  before_filter :configure_permitted_parameters, if: :devise_controller?

  before_filter :set_week_start, if: :user_signed_in?

  private

    def set_week_start
      Date.beginning_of_week = :sunday
    end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

end
