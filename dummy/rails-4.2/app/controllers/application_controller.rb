class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def honeypot_fields
    {
      :my_custom_comment_body => 'Custom field name',
      42 => 'Number field name',
      "post[title]" => 'Complex field name'
    }
  end

  # def honeypot_style_class
  #   "hidden"
  # end

end
