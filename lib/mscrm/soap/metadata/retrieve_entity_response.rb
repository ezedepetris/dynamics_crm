module Mscrm
  module Soap
    module Metadata

      class RetrieveEntityResponse < Mscrm::Soap::Model::ExecuteResult
        attr_reader :entity, :attributes

        def initialize(xml)
          super

          # Single KeyValuePair containing 1 value type of EntityMetadata
          @entity = EntityMetadata.new(self["EntityMetadata"])
        end

      end
    end
  end
end