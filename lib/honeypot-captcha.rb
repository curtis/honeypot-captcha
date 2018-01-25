require 'honeypot-captcha/form_tag_helper'

module HoneypotCaptcha
  module SpamProtection
    def honeypot_fields
      { a_comment_body: 'Do not fill in this field' }
    end

    def honeypot_string
      'hp'
    end

    def protect_from_spam
      head :ok if honeypot_fields.any? { |f, l| !params[f].blank? }
    end

    def self.included(base) # :nodoc:
      base.send :helper_method, :honeypot_fields
      base.send :helper_method, :honeypot_string

      if base.respond_to? :before_action
        base.send :prepend_before_action, :protect_from_spam, only: %i[create update]
      end
    end
  end

  module Honeypot
    def form_tag_html(options)
      honeypot = options.delete(:honeypot) || options.delete('honeypot')
      html = super(options)
      if honeypot
        captcha = "".respond_to?(:html_safe) ? honey_pot_captcha.html_safe : honey_pot_captcha
        if block_given?
          html.insert(html.index('</form>'), captcha)
        else
          html += captcha
        end
      end
      html
    end

    private

    def honey_pot_captcha
      html_ids = []
      honeypot_fields.collect do |f, l|
        html_ids << (html_id = "#{f}_#{honeypot_string}_#{Time.now.to_i}")
        content_tag :div, id: html_id do
          content_tag(:style, type: 'text/css', media: 'screen', scoped: 'scoped') do
            "#{html_ids.map { |i| "##{i}" }.join(', ')} { display:none; }"
          end +
            label_tag(f, l) +
            send(%i[text_field_tag text_area_tag][rand(2)], f)
        end
      end.join
    end
  end
end

if defined?(ActionController::Base)
  ActionController::Base.send(:include, HoneypotCaptcha::SpamProtection)
end
