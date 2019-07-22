module Etl
  module Adapter
    class BackupAdapter
      class << self
        def build_from(backup_row:)
          Etl::Dto::Backup.new(
            id: backup_row['ID'],
            created_at: Time.parse(backup_row['Created at'])
          )
        end
      end
    end
  end
end
