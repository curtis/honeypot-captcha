require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Honeypot Captcha" do
  include RSpecHtmlMatchers

  before do
    @view = TestView.new
  end

  it 'inserts honeypot tags' do
    options = {:honeypot => true}
    html = @view.form_tag_html(options)

    hp_string = @view.honeypot_string
    hp_style_class = @view.honeypot_style_class
    @view.honeypot_fields.each_pair do |hp_field_name, hp_field_content|

      # <div id="a_comment_body_hp_1549802622">
      # <div id="a_comment_body_hp_1549802622" class="classname">
      if hp_style_class.blank?
        expect(html).to have_tag("div[id^='#{hp_field_name.to_s}_#{hp_string}']")
        expect(html).to_not have_tag("div[class]")
      else
        expect(html).to have_tag("div[id^='#{hp_field_name.to_s}_#{hp_string}'][class='#{hp_style_class}']")
      end

      # <style type="text/css" media="screen" scoped="scoped">[id='a_comment_body_hp_1549802622'] { display:none; }</style>
      expect(html).to have_tag('style', :text => /#{hp_field_name.to_s}_#{hp_string}.*display.*none/) if hp_style_class.blank?

      # <label for="a_comment_body">Do not fill in this field</label>
      expect(html).to have_tag('label', :with => { :for => hp_field_name.to_s }, :text => hp_field_content)

      # <textarea name="a_comment_body" id="a_comment_body">
      # <input type="text" name="a_comment_body" id="a_comment_body" />
      textarea_tag = have_tag('textarea')
      random_tag = textarea_tag.matches?(html) ? 'textarea' : 'input'  # gem chooses tag type at random
      expect(html).to have_tag(random_tag)
      expect(html).to have_tag(random_tag, :with => { :name => hp_field_name.to_s, :id => hp_field_name.to_s })
    end

  end
end

