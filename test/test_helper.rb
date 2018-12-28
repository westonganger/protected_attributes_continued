require 'bundler/setup'
require 'minitest/autorun'
require 'mocha/api'
require 'rails'

Rails.backtrace_cleaner.remove_silencers!

ActiveSupport.test_order = :random if ActiveSupport.respond_to?(:test_order)
