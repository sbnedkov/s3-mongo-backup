require "s3-mongo-backup"
require "rr"
require 'fakefs/spec_helpers'
require 'coveralls'
Coveralls.wear!

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
  config.mock_framework = :rr
end
