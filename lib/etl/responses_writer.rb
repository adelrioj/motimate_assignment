require 'csv'

module Etl
  class ResponsesWriter
    class << self
      def export(responses:,
                 filepath: 'responses.csv',
                 config: { col_sep: '  ' })
        CSV.open(filepath, 'wb', config) do |csv|
          csv << headers
          responses.each { |response| csv << response.to_a }
          csv
        end
      end

      def headers
        ['ID', 'Created at', 'Status', 'Code', 'ErrorDescription']
      end
    end
  end
end