require 'spec_helper'

describe DynamicsCRM::Response::RetrieveMultipleResult do

  describe 'initialization' do
    subject {
      xml = fixture("request_entity_changes_response")
      DynamicsCRM::Response::RetrieveEntityChangesResult.new(xml)["EntityChanges"]
    }

    context "parse attributes according to their type" do
      it { expect(subject.data_token).to eq("1225692!08/07/2017 05:16:05") }
      it { expect(subject.more_records).to eq(false) }
      it { expect(subject.paging_cookie).to eq(nil) }

      it { expect(subject.entities.first.to_hash).to eq({
              :attributes => {"organizationid"=>"a2e85b8c-d4da-468f-a639-0eaee51b017a"},
              :entity_state => nil,
              :formatted_values => nil,
              :id => "a2e85b8c-d4da-468f-a639-0eaee51b017a",
              :logical_name => "organization",
              :related_entities => nil})
         }
    end

  end

end
