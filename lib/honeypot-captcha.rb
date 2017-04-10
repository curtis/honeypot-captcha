require 'honeypot-captcha/form_tag_helper'

module HoneypotCaptcha
  module SpamProtection
    def honeypot_fields
      { :a_comment_body => 'Do not fill in this field' }
    end

    def honeypot_string
      'hp'
    end

    def protect_from_spam
      head :ok if honeypot_fields.any? { |f,l| !params[f].blank? }
    end

    def self.included(base) # :nodoc:
      base.send :helper_method, :honeypot_fields
      base.send :helper_method, :honeypot_string

      callback_to_add = if base.respond_to?(:before_action)
                          :prepend_before_action
                        elsif base.respond_to?(:before_filter)
                          :prepend_before_filter
                        end

      if callback_to_add
        base.send callback_to_add, :protect_from_spam, :only => [:create, :update]
      end
    end
  end
end

ActionController::Base.send(:include, HoneypotCaptcha::SpamProtection) if defined?(ActionController::Base)
