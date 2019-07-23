require 'etl/parser'
require 'etl/adapter/response_adapter'

class ResponseController
  class << self
    def check_responses(filepath:, interval:)
      Etl::Parser.
        from_file(filepath: filepath).
        map(&method(:response_from)).
        select { |response| response.between?(interval: interval) }.
        each_with_object(Hash.new(0), &method(:select_response_type))
    end

    private

    def response_from(row)
      Etl::Adapter::ResponseAdapter.build_from(response_row: row)
    end

    def select_response_type(response, counter)
      if response.error?
        counter[:error] += 1
      else
        counter[:ok] += 1
      end
    end
  end
end
