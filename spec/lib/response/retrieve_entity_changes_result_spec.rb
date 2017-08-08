require 'spec_helper'

describe DynamicsCRM::Response::RetrieveMultipleResult do

  describe 'initialization' do
    subject {
      xml = fixture("request_entity_changes_response")
      DynamicsCRM::Response::RetrieveEntityChangesResult.new(xml)
    }

    context "parse attributes according to their type" do

      it "xx" do
        puts subject["EntityChanges"].entities.first.inspect
      end

    end

  end

end
