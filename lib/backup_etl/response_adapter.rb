module BackupEtl
  class ResponseAdapter
    class << self
      def build_from(response_row:)
        BackupEtl::Response.new(
          id: response_row['ID'],
          created_at: Time.parse(response_row['Created at']),
          status: response_row['Status'],
          code: response_row['Code'],
          error_description: response_row['ErrorDescription']
        )
      end
    end
  end
end