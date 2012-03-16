require 'rspec'
require 'webmock/rspec'
require 'parature'
Dir[File.expand_path("../support/**/*.rb", __FILE__)].each {|f| require f}
include Parature::Webmocks

RSpec.configure do |c|
  c.mock_with :rspec
end
