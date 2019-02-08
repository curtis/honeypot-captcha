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
require 'active_support/concern'
require 'action_view/helpers/capture_helper'
require 'action_view/helpers/output_safety_helper'
require 'action_view/helpers/sanitize_helper'
require 'action_view/helpers/tag_helper'
require 'action_view/helpers/text_helper'
require 'action_view/helpers/url_helper'
require 'action_view/helpers/form_tag_helper'
require 'honeypot-captcha'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|

end
