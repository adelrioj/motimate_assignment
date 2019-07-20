require "spec_helper"

RSpec.describe Parser do
  describe 'headers' do
    it 'should return file headers' do
      parser = Parser.from_file(filepath: fixture_file('parser.csv'))
      expect(['ID', 'Created at', 'Status', 'Size', 'Database']).to eq(parser.headers)
    end
  end

  describe 'each' do
    it 'should return an iterator with each row as a hash' do
      parser = Parser.from_file(filepath: fixture_file('parser.csv'))

      parser.each do |row|
        expect(row.is_a?(Hash)).to be true
        expect(row['ID']).to eq('a810')
        expect(row['Created at']).to eq('2019-07-10 00:08:02 +0000')
        expect(row['Status']).to eq('Completed 2019-07-10 00:18:53 +0000')
        expect(row['Size']).to eq('482.43MB')
        expect(row['Database']).to eq('DATABASE')
      end
    end
  end

  def fixture_file(name)
    File.dirname(__FILE__) + "/fixtures/#{name}"
  end
end