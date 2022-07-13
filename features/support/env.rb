require 'page-object'
require 'selenium-webdriver'
require 'cucumber'
require 'rspec/expectations'
require 'rspec/matchers'
require 'page-object/page_factory'
require 'webdrivers'
require 'allure-cucumber'
require 'rake'
require_relative 'test_context'
require_relative '../pages/base_page'

World(PageObject::PageFactory)
$tc = TestContext.new

module Cucumber
  module Glue
    module ProtoWorld
      def puts(*messages)
        # in Cucumber 4 and higher puts() is deprecated, log() must be used
        if Cucumber::VERSION[0].to_i >= 4
          log(*messages)
        else
          super
        end
      end
    end
  end
end

Before do |scenario|
  $tc.data = Hash.new
  @browser = $tc.browser
  @browser.manage.delete_all_cookies
end

After do |scenario|
  @browser = $tc.browser
  messages = ["-------------------------------------------------------"]
  messages << "Scenario: #{scenario.name}"
  messages << ["-------------------------------------------------------"]
  messages << "Environment: #{$tc.environment}"
  messages << "Application version: #{$tc.app_version}"
  messages << "Chrome version: #{@browser.capabilities.version}"

  $tc.data.keys.each do |key|
    messages << "#{key}: #{$tc.data[key]}"
  end

  message = messages.join("\n")
  log message
end