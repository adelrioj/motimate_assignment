require "spec_helper"

RSpec.describe BackupEtl::Backup do
  context 'is_older?' do
    before(:example) do
      allow(Time).to receive(:now).and_return(Time.parse('2019-07-20 00:00:00 +0000'))
    end

    let(:backup) do
      BackupEtl::Backup.new(
        id: 'an_id',
        created_at_str: '2019-07-10 00:08:02 +0000'
      )
    end

    it 'should return false if created_at is below or equal, true otherwise' do
      expect(backup.is_older?(days: 11)).to be false
      expect(backup.is_older?(days: 10)).to be false
      expect(backup.is_older?(days: 9)).to be true
    end
  end
end