module BackupEtl
  class Result
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
  end
end
