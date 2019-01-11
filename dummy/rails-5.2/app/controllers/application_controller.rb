class ApplicationController < ActionController::Base
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
