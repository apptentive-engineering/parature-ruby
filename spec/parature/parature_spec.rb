require 'spec_helper'

describe Parature do
  let(:connection_params) { {:host => "h", :account_id => 1, :department_id => 2, :token => "abc"} }

  describe "initializing" do
    after do
      Object.send(:remove_const, :Rails) if Object.const_defined?(:Rails)
      FileUtils.rm_rf(File.join(root_dir, "config"))
    end
    let(:root_dir) { File.expand_path("../../..", __FILE__) }

    it "inits from given params" do
      parature = Parature.new(connection_params)
      parature.connection.host.should == "h"
    end

    it "inits from a config file using Rails.root when Rails is defined" do
      class Rails; def self.root; Pathname.new(File.expand_path("../../..", __FILE__)); end; end
      config_dir = File.join(root_dir, "config")
      FileUtils.mkdir_p(config_dir)
      File.open(File.join(config_dir, "parature.yml"), 'w') do |f|
        f.write(YAML.dump(connection_params.merge(:host => "h1")))
      end
      parature = Parature.new
      parature.connection.host.should == "h1"
    end

    it "inits from a config file from the root dir" do
      config_dir = File.join(root_dir, "config")
      FileUtils.mkdir_p(config_dir)
      File.open(File.join(config_dir, "parature.yml"), 'w') do |f|
        f.write(YAML.dump(connection_params.merge(:host => "h2")))
      end
      parature = Parature.new
      parature.connection.host.should == "h2"
    end
  end

  describe "folders" do
    subject { Parature.new(connection_params) }

    it "returns list of all folders" do
      stub_folder_request(subject, [{:id => 1, :name => "One"}, {:id => 2, :name => "Two"}])
      subject.folders.map(&:name).should == %w{One Two}
    end
  end

end
