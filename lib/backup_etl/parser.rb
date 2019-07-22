require 'csv'

module BackupEtl
  class Parser
    class << self
      def from_file(filepath:,
                    config: { col_sep: '  ' })
        file = File.open(filepath, 'r')
        csv = CSV.new(file, config.merge(headers: true))
        new(csv)
      end
    end

    def initialize(file)
      @file = file
    end

    def each
      reset_file if current_line_number > 0

      @file.each do |line|
        yield(line.to_h) if block_given?
      end
    end

    def map
      reset_file if current_line_number > 0

      result = []
      @file.each do |line|
        result << yield(line.to_h) if block_given?
      end

      result
    end

    def headers
      @file.readline
      @file.headers
    end

    private

    def current_line_number
      @file.lineno
    end

    def reset_file
      @file.rewind
    end
  end
end
