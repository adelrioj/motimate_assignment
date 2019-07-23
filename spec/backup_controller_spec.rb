require "spec_helper"
require 'fixture_helper'
require 'csv'

RSpec.describe BackupController do
  context 'INTEGRATION_TEST: remove_backups' do
    before(:example) do
      expect(CSV).to receive(:open).with('responses.csv', 'wb', anything)
    end

    it 'should create a response file with the result of the remove operation' do
      extend FixtureHelper

      BackupController.remove_backups(input_filepath: fixture_file('backup_controller.csv'))
    end
  end
end
