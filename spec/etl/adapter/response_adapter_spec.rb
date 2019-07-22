require "spec_helper"

RSpec.describe Etl::Adapter::ResponseAdapter do
  context 'build_from backup_row' do
    it 'should create a backup from a row hash' do
      row = {
        'ID' => 'an_id',
        'Created at' => '2019-07-10 00:08:02 +0000',
        'Status' => 'a_status',
        'Code' => 'a_code',
        'ErrorDescription' => 'an_error'
      }

      result = Etl::Adapter::ResponseAdapter.build_from(response_row: row)

      expect(result.is_a?(Etl::Dto::Response)).to be true
      expect(result.id).to eq 'an_id'
      expect(result.created_at.to_s).to eq '2019-07-10 00:08:02 +0000'
      expect(result.status).to eq 'a_status'
      expect(result.code).to eq 'a_code'
      expect(result.error_description).to eq 'an_error'
    end
  end
end
