module BackupEtl
  class Interval
    attr_accessor :start_time, :end_time

    def initialize(start_time:,
                   end_time:)
      @start_time = start_time
      @end_time = end_time

      validate
    end

    private

    def validate
      fail ArgumentError.new("Invalid interval") if @start_time > @end_time
    end
  end
end
