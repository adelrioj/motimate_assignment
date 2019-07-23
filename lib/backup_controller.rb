require 'etl/dto/backup'
require 'etl/adapter/backup_adapter'
require 'etl/dto/response'
require 'etl/parser'
require 'etl/backup_remover'
require 'etl/responses_writer'

class BackupController
  class << self
    def remove_backups(input_filepath:)
      responses = Etl::Parser.
        from_file(filepath: input_filepath).
        map(&method(:backup_from)).
        select { |backup| backup.is_older?(days: 30) }.
        map(&method(:check_backup_status))

      Etl::ResponsesWriter.export(responses: responses)
    end

    private

    def backup_from(row)
      Etl::Adapter::BackupAdapter.build_from(backup_row: row)
    end

    def base_url
      'https://example.com/remove-backup?backup_id='
    end

    def check_backup_status(backup)
      @checker ||= Etl::BackupRemover.new(url_str: base_url)
      @checker.remove(backup: backup)
    end
  end
end
