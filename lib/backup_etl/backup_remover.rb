require 'net/http'

module BackupEtl
  class BackupRemover
    def initialize(url_str:)
      @url = url_str
    end

    def remove(backup:)
      status = fetch_status(backup.id)
      return generate_ok_result(backup, status) if status.is_a?(Net::HTTPOK)
      generate_error_result(backup, status)
    end

    private

    def fetch_status(id)
      url = URI("#{@url}#{id}")
      Net::HTTP.start(url.host,
                      url.port,
                      use_ssl: true
      ) do |http|
        return http.head(url.path)
      end
    end

    def generate_error_result(backup, status)
      BackupEtl::Result.new(
        id: backup.id,
        created_at: backup.created_at,
        status: 'Error',
        code: status.code,
        error_description: "{error: #{status.message}}"
      )
    end

    def generate_ok_result(backup, status)
      BackupEtl::Result.new(
        id: backup.id,
        created_at: backup.created_at,
        status: 'Removed',
        code: status.code
      )
    end
  end
end
