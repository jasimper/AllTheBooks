module ApplicationHelper

  def assign_current(path)
    "current" if request.url.end_with?("#{path}")
  end
end
