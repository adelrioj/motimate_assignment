require "spec_helper"

RSpec.describe BackupEtl::Parser do
  context 'headers' do
    it 'should return file headers' do
      parser = BackupEtl::Parser.from_file(filepath: fixture_file('parser.csv'))
      expect(['ID', 'Created at', 'Status', 'Size', 'Database']).to eq(parser.headers)
    end
  end

  context 'each' do
    it 'should iterate on each row , served as a hash' do
      parser = BackupEtl::Parser.from_file(filepath: fixture_file('parser.csv'))

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

  context 'map' do
    it 'should iterate on each row , served as a hash, and return transformed data' do
      parser = BackupEtl::Parser.from_file(filepath: fixture_file('parser.csv'))

      result = parser.map do |row|
        expect(row.is_a?(Hash)).to be true
        expect(row['ID']).to eq('a810')
        expect(row['Created at']).to eq('2019-07-10 00:08:02 +0000')
        expect(row['Status']).to eq('Completed 2019-07-10 00:18:53 +0000')
        expect(row['Size']).to eq('482.43MB')
        expect(row['Database']).to eq('DATABASE')

        row['ID']
      end

      expect(result.length).to eq 1
      expect(result.first).to eq 'a810'
    end
  end

  def fixture_file(name)
    File.dirname(__FILE__) + "/fixtures/#{name}"
  end
end