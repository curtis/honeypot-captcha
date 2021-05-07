require 'honeypot-captcha/form_tag_helper'

module HoneypotCaptcha
  module SpamProtection
    def honeypot_fields
      { :a_comment_body => 'Do not fill in this field' }
    end

    def honeypot_string
      'hp'
    end

    def honeypot_style_class
      nil
    end

    def protect_from_spam
      head :ok if honeypot_fields.any? { |f,l| !params[f].blank? || params[f].to_s.length > 0 }
    end

    def self.included(base) # :nodoc:
      base.send :helper_method, :honeypot_fields
      base.send :helper_method, :honeypot_string
      base.send :helper_method, :honeypot_style_class

      if base.respond_to? :before_action
        base.send :prepend_before_action, :protect_from_spam, :only => [:create, :update]
      elsif base.respond_to? :before_filter
        base.send :prepend_before_filter, :protect_from_spam, :only => [:create, :update]
      end
    end
  end
end

ActionController::Base.send(:include, HoneypotCaptcha::SpamProtection) if defined?(ActionController::Base)
