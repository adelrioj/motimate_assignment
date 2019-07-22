require 'csv'

module BackupEtl
  class ResultsWriter
    class << self
      def export(results:,
                 filepath: 'results.csv',
                 config: { col_sep: '  ' })
        CSV.open(filepath, 'wb', config) do |csv|
          csv << headers
          results.each { |result| csv << result.to_a }
          csv
        end
      end

      def headers
        ['ID', 'Created at', 'Status', 'Code', 'ErrorDescription']
      end
    end
  end
end