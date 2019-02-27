require 'simplecov'

module SimpleCov::Configuration
  def clean_filters
    @filters = []
  end
end

SimpleCov.configure do
  clean_filters
  load_adapter 'test_frameworks'
end

ENV["COVERAGE"] && SimpleCov.start do
  add_filter "/.rvm/"
end
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rspec'
require 'rspec-html-matchers'
require 'action_view'
require 'honeypot-captcha'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|

end

# Inspired by https://github.com/lwe/page_title_helper/blob/master/test/test_helper.rb
class TestView < ActionView::Base

  def initialize(controller_path = nil, action = nil)
    @controller = ActionView::TestCase::TestController.new
  end

  def protect_against_forgery?
    false
  end

  def honeypot_fields
    { :a_comment_body => 'Do not fill in this field' }
  end

  def honeypot_string
    'hp'
  end

  def honeypot_style_class
    'classname'
  end

end

