require_relative 'lib/backup_controller'
require_relative 'lib/response_controller'
require_relative 'lib/etl/dto/interval'

input_filepath = 'sample_input.csv'

p "Importing file: #{input_filepath} and removing backups..."

BackupController.remove_backups(input_filepath: input_filepath)

p 'Done. Checking results...'

start_time = Time.parse('2019-04-08 00:06:19 +0000')
end_time = Time.parse('2019-04-10 00:08:02 +0000')
interval = Etl::Dto::Interval.new(start_time: start_time, end_time: end_time)
counter = ResponseController.check_responses(filepath: 'responses.csv', interval: interval)

p 'Results:'
p "With ok status: #{counter[:ok]}"
p "With error status: #{counter[:error]}"
