module DynamicsCRM
  module Response
    # Retrieve Multiple returns a list of Entities.
    class RetrieveEntityChangesResult < Result

      protected

      def response_element
        class_name = "ExecuteResult"
      end

      # Invoked by Result constructor
      def parse_result_response(result)
        h = {}
        attributes = XML::MessageParser.parse_key_value_pairs(result.elements["b:Results"])
        h.merge(attributes)
      end

    end
    # RetrieveMultipleResult
  end
end
