require "spec_helper"

RSpec.describe Etl::ResponsesWriter do
  context 'export' do
    before(:example) do
      allow(CSV).to receive(:open).and_yield([])
    end

    it 'should export to a csv file' do
      input = Etl::Dto::Response.new(
        id: 'an_id',
        created_at: Time.now,
        status: 'a_status',
        code: 'a_code',
        error_description: 'an_error_desc'
      )

      output = Etl::ResponsesWriter.export(responses: [input])

      expect(output.length).to eq(2)
      expect(output.first).to eq(['ID', 'Created at', 'Status', 'Code', 'ErrorDescription'])
      expect(output[1]).
        to eq([
                input.id,
                input.created_at.to_s,
                input.status,
                input.code,
                input.error_description
              ])
    end
  end
end