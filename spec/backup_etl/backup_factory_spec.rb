require "spec_helper"

RSpec.describe BackupEtl::Backup do
  context 'build_from backup_row' do
    it 'should create a backup from a row hash' do
      row = {
        'ID' => 'an_id',
        'Created at' => '2019-07-10 00:08:02 +0000'
      }

      result = BackupEtl::BackupFactory.build_from(backup_row: row)

      expect(result.id).to eq 'an_id'
      expect(result.created_at.to_s).to eq '2019-07-10 00:08:02 +0000'
    end
  end
end