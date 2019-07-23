require "spec_helper"
require 'fixture_helper'
require 'etl/dto/interval'

RSpec.describe ResponseController do
  context 'INTEGRATION_TEST: check_responses' do
    it 'should return a responses counter from the contents of the file' do
      extend FixtureHelper

      start_time = Time.parse('2019-04-08 00:06:19 +0000')
      end_time = Time.parse('2019-04-10 00:08:02 +0000')
      interval = Etl::Dto::Interval.new(start_time: start_time, end_time: end_time)

      counter = ResponseController.check_responses(
        filepath: fixture_file('response_controller.csv'),
        interval: interval
        )

      expect(counter[:ok]).to eq 0
      expect(counter[:error]).to eq 1
    end
  end
end

