require 'rest_client'
require 'time'
require 'json'
require "parature/version"
Dir[File.expand_path("../parature/utils/**/*.rb", __FILE__)].each {|f| require f}

class Parature
  autoload :Article, 'parature/article'
  autoload :Folder, 'parature/folder'
  autoload :Connection, 'parature/connection'

  attr_reader :connection

  def initialize(options = load_options_from_config_file)
    @connection = Connection.new(options)
  end

  def folders
    Parature::Folder.all(@connection)
  end

  def load_options_from_config_file
    filename = "config/parature.yml"
    config_file = if Object.const_defined?("Rails")
      Rails.root.join(filename)
    else
      File.expand_path(filename)
    end
    YAML.load_file(config_file)
  end
end
