# Override the form_tag helper to add honeypot spam protection to forms.
module ActionView
  module Helpers
    module FormTagHelper
      def form_tag_html_with_honeypot(options)
        honeypot = options.delete(:honeypot) || options.delete('honeypot')
        html     = form_tag_html_without_honeypot(options)

        if honeypot
          captcha = honey_pot_captcha

          if block_given?
            html.insert(html.index('</form>'), captcha)
          else
            html += captcha
          end
        end

        html
      end
      alias_method :form_tag_html_without_honeypot, :form_tag_html
      alias_method :form_tag_html, :form_tag_html_with_honeypot

    private

      def honey_pot_captcha
        html_ids = []

        honeypot_fields.collect do |key, value|
          html_ids << (html_id = sanitize_html_id("#{key}_#{honeypot_string}_#{Time.now.to_i}"))

          content_tag :div, { :id => html_id }.merge(style_attributes) do
            style_tag(html_ids).html_safe +
            label_tag(key, value) +
            send([:text_field_tag, :text_area_tag][rand(2)], key)
          end

        end.join
      end

      def sanitize_html_id(html_id)
        html_id.gsub(/\]\[|[^-a-zA-Z0-9:.]/, "_")
      end

      def style_attributes
        return {} if honeypot_style_class.blank?
        { :class => honeypot_style_class }
      end

      def style_tag(html_ids)
        return '' if honeypot_style_class.present?
        content_tag(:style, :type => 'text/css', :media => 'screen', :scoped => "scoped") do
          "#{html_ids.map { |i| "[id='#{i}']" }.join(', ')} { display:none; }".html_safe
        end
      end
    end
  end
end
