require 'spec_helper'

describe Parature::Folder do
  let(:connection_params) { {:host => "h", :account_id => 1, :department_id => 2, :token => "abc"} }

  describe "articles" do
    subject { Parature.new(connection_params) }

    it "returns list of articles of a given folder" do
      stub_folder_request(subject, [{:id => 1, :name => "One"}, {:id => 2, :name => "Two"}])
      stub_article_request(subject, 2, [
        {:id => 1, :question => "Foo", :answer => "Bar"},
        {:id => 2, :question => "Bla", :answer => "Blabla"}
      ])

      subject.folders.detect { |f| f.name == "Two" }.articles.map(&:question).should == %w{Foo Bla}
    end
  end

end

