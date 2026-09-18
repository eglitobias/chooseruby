# frozen_string_literal: true

ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

require "bundler/setup" # Set up gems listed in the Gemfile.
require "bootsnap/setup" # Speed up boot time by caching expensive operations.

# `bin/rails test` boots the application before it loads test_helper.rb, so
# starting SimpleCov there misses everything loaded during boot. Only for an
# actual test run: other test-env tasks (db:seed:replant) would trip the
# coverage minimums. Configuration lives in .simplecov.
if ENV["RAILS_ENV"] == "test" && ARGV.grep(/\Atest(:|\z)/).any?
  require "simplecov"
  SimpleCov.start
end
