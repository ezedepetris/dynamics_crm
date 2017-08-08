module DynamicsCRM
  module XML

    class ColumnSet < Array

      def initialize(column_names=[])
        super(column_names || [])
      end

      def to_xml(options={})
        namespace = options[:namespace] ? options[:namespace] + ":" : ""

        column_set = ''
        if self.any?
          column_set = "<a:Columns xmlns:c=\"http://schemas.microsoft.com/2003/10/Serialization/Arrays\">"
          self.each do |name|
            column_set << "\n<c:string>#{name}</c:string>"
          end
          column_set << "\n</a:Columns>"
        end

        # Really annoying that Retrieve uses columnSet
        # while QueryExpression uses ColumnSet.
        tag_name = options[:camel_case] ? "ColumnSet" : "columnSet"
        if options[:exclude_root]
          %Q{
              <a:AllColumns>#{self.empty?}</a:AllColumns>
              #{column_set}
            }
        else
          %Q{<#{namespace}#{tag_name} xmlns:b="http://schemas.microsoft.com/xrm/2011/Contracts" xmlns:i="http://www.w3.org/2001/XMLSchema-instance">
              <b:AllColumns>#{self.empty?}</b:AllColumns>
              #{column_set}
            </#{namespace}#{tag_name}>}
        end
      end
    end
    # ColumnSet
  end

end
