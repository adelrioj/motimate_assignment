module BackupEtl
  class BackupFactory
    class << self
      def build_from(backup_row:)
        BackupEtl::Backup.new(
          id: backup_row['ID'],
          created_at_str: backup_row['Created at']
        )
      end
    end
  end
end
