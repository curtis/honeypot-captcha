require 'honeypot-captcha/honeypot_core'

module ActionView
  module Helpers
    module FormTagHelper
      prepend ::HoneypotCaptcha::Honeypot
    end
  end
end

if defined?(ActionController::Base)
  ActionController::Base.send(:include, HoneypotCaptcha::SpamProtection)
end
