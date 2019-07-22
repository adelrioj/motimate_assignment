require "spec_helper"
require 'etl/dto/interval'

RSpec.describe Etl::Dto::Response do
  let(:response) do
    Etl::Dto::Response.new(
      id: 'an_id',
      created_at: Time.parse('2019-04-09 00:06:19 +0000'),
      code: 'a_code',
      status: 'a_status'
    )
  end

  context 'between?' do
    it 'should return true if created_at is between interval' do
      interval = Etl::Dto::Interval.new(
        start_time: Time.parse('2019-04-08 00:06:19 +0000'),
        end_time: Time.parse('2019-04-10 00:08:02 +0000')
      )
      expect(response.between?(interval: interval)).to be true
    end

    it 'should return false if created_at is below interval' do
      interval = Etl::Dto::Interval.new(
        start_time: Time.parse('2019-04-10 00:06:19 +0000'),
        end_time: Time.parse('2019-04-10 00:08:02 +0000')
      )
      expect(response.between?(interval: interval)).to be false
    end

    it 'should return false if created_at is above interval' do
      interval = Etl::Dto::Interval.new(
        start_time: Time.parse('2019-04-08 00:06:19 +0000'),
        end_time: Time.parse('2019-04-8 00:08:02 +0000')
      )
      expect(response.between?(interval: interval)).to be false
    end
  end
end
