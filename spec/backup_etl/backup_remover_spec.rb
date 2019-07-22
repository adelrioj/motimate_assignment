require "spec_helper"

RSpec.describe BackupEtl::BackupRemover do
  let(:checker) do
    BackupEtl::BackupRemover.new(url_str: 'fake_url_str')
  end

  let(:backup) { BackupEtl::Backup.new(
    id: 'an_id',
    created_at_str: '2019-07-10 00:08:02 +0000'
  ) }

  context 'remove' do
    it 'should be error if check do not return status 200' do
      http = double
      allow(Net::HTTP).to receive(:start).and_yield http
      allow(http).to receive(:head)
                       .and_return(Net::HTTPNotFound.new('a_httpv', '404', 'an_error_message'))

      response = checker.remove(backup: backup)

      expect(response.is_a?(BackupEtl::Result)).to be true
      expect(response.id).to eq(backup.id)
      expect(response.created_at).to eq(backup.created_at)
      expect(response.status).to eq('Error')
      expect(response.code).to eq('404')
      expect(response.error_description).to eq('{error: an_error_message}')
    end

    it 'should be ok if check do not return status 200' do
      http = double
      allow(Net::HTTP).to receive(:start).and_yield http
      allow(http).to receive(:head)
                       .and_return(Net::HTTPOK.new('a_httpv', '200', 'a_ok_message'))

      response = checker.remove(backup: backup)

      expect(response.is_a?(BackupEtl::Result)).to be true
      expect(response.id).to eq(backup.id)
      expect(response.created_at).to eq(backup.created_at)
      expect(response.status).to eq('Removed')
      expect(response.code).to eq('200')
      expect(response.error_description).to eq('')
    end
  end
end
