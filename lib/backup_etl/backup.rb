require 'time'

module BackupEtl
  class Backup
    attr_reader :id, :created_at

    def initialize(id:,
                   created_at_str:)
      @id = id
      @created_at = Time.parse(created_at_str)
    end

    def is_older?(days:)
      ((Time.now - @created_at) / day).round > days
    end

    def day
      (24 * 60 * 60)
    end
  end
end
