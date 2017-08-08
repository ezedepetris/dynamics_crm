require 'spec_helper'

describe DynamicsCRM::XML::EntityChanges do

  describe 'initialization' do

    context "parse attributes according to their type"  do
      subject {
        document = REXML::Document.new(fixture('request_entity_changes_response'))
        entity_changes = REXML::Document.new(document.get_elements("//c:value"))
        DynamicsCRM::XML::EntityChanges.new(entity_changes)
      }

      context "generate ColumnSet XML" do
        it { puts subject.inspect }
      end
    end

  end

end
