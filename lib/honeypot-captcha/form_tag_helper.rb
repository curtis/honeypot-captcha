# Override the form_tag helper to add honeypot spam protection to forms.
module ActionView
  module Helpers
    module FormTagHelper
      prepend ::HoneypotCaptcha::Honeypot
    end
  end
end
