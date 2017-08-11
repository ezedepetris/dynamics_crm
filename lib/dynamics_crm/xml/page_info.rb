module DynamicsCRM
  module XML
    class PageInfo
      attr_accessor :count, :page_number, :paging_cookie, :return_total_record_count

      def initialize(count: 20, page_number: 1, paging_cookie: nil, return_total_record_count: false)
        @count = count
        @page_number = page_number
        @paging_cookie = paging_cookie
        @return_total_record_count = return_total_record_count
      end

      # Using Entity vs entity causes the error: Value cannot be null.
      def to_xml(options={})
        cookie = if paging_cookie.nil?
          '<a:PagingCookie nil="true" />'
        else
          %(<a:PagingCookie>#{CGI.escapeHTML(paging_cookie)}</a:PagingCookie>)
        end

        if options[:exclude_root]
          %(
            <a:Count>#{count}</a:Count>
            <a:PageNumber>#{page_number}</a:PageNumber>
            #{cookie}
            <a:ReturnTotalRecordCount>#{return_total_record_count}</a:ReturnTotalRecordCount>
          )
        else
          %(
          <PageInfo>
            <Count>#{count}</Count>
            <PageNumber>#{page_number}</PageNumber>
            #{cookie}
            <ReturnTotalRecordCount>#{return_total_record_count}</ReturnTotalRecordCount>
          </PageInfo>
          )
        end
      end

      def self.from_xml(xml_document)
        page_info = PageInfo.new

        if xml_document
          xml_document.elements.each do |node|

            attr_name = DynamicsCRM::StringUtil.underscore(node.name).to_sym
            if entity.respond_to?(attr_name)
              entity.send("#{attr_name}=", node.text ? node.text.strip : nil)
            end
          end
        end

        return entity
      end


      def to_hash
        {
          :count => count,
          :page_number => page_number,
          :paging_cookie => paging_cookie,
          :return_total_record_count => return_total_record_count
        }
      end
    end
    # PageInfo
  end
end
