require 'time'

module BackupEtl
  class Backup
    attr_reader :id, :created_at

    def initialize(id:,
                   created_at:)
      @id = id
      @created_at = created_at
    end

    def is_older?(days:)
      ((Time.now - @created_at) / day).round > days
    end

    def day
      (24 * 60 * 60)
    end
  end
end
