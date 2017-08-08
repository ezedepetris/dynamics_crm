module DynamicsCRM
  module XML

    class EntityChanges

      attr_accessor :data_token, :more_records, :paging_cookie, :entities

      def initialize(xml_document)
        @entities = []
        @deleted_entities = []

        if xml_document
          xml_document.each_element do |node|
            attr_name = ::DynamicsCRM::StringUtil.underscore(node.name).to_sym

            if node.name == "Changes"
              new_entitiy_elements = node.get_elements("//d:NewOrUpdatedEntity")
              new_entitiy_elements.each do |entity_xml|
                @entities << XML::Entity.from_xml(entity_xml)
              end

              deleted_entitiy_elements = node.get_elements("//d:RemovedOrDeletedItem")
              deleted_entitiy_elements.each do |entity_xml|
                @deleted_entities << XML::EntityReference.from_xml(entity_xml)
              end
            elsif self.respond_to?(attr_name)
              value = node.text ? ::DynamicsCRM::StringUtil.valueOf(node.text.strip) : nil
              self.send("#{attr_name}=", value)
            end
          end
        end

      end

      def to_hash
        {
          :entity_name => entity_name,
          :min_active_row_version => min_active_row_version,
          :more_records => more_records,
          :paging_cookie => paging_cookie,
          :total_record_count => total_record_count,
          :total_record_count_limit_exceeded => total_record_count_limit_exceeded,
          :entities => entities
        }
      end

      def to_xml(options={})
        options[:exclude_root] = true
        namespace = options[:namespace] ? "#{options[:namespace]}:" : ''

        entities_xml = entities.inject("") { |result,entity|
          result << %Q{<#{namespace}Entity>#{entity.to_xml(options)}</#{namespace}Entity>}
        }
        %Q{<#{namespace}Entities>#{entities_xml}</#{namespace}Entities>}
      end

    end
    # EntityChanges
  end
end
