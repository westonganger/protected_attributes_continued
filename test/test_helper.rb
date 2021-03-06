require 'bundler/setup'
require 'minitest/autorun'
require 'mocha/api'
require 'rails'

Rails.backtrace_cleaner.remove_silencers!

if ActiveSupport.respond_to?(:test_order)
  #ActiveSupport.test_order = :random ### :random causes occasional ActiveRecord::RecordNotUnique on primary key
end 
