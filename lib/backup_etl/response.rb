module BackupEtl
  class Response
    attr_reader :id, :created_at, :status, :code, :error_description

    def initialize(id:,
                   created_at:,
                   status:,
                   code:,
                   error_description: '')
      @id = id
      @created_at = created_at
      @status = status
      @code = code
      @error_description = error_description
    end

    def between?(interval:)
      @created_at > interval.start_time &&
        @created_at < interval.end_time
    end

    def to_a
      [@id, @created_at.to_s, @status, @code, @error_description]
    end
  end
end
