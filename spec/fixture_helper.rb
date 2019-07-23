module FixtureHelper
  def fixture_file(name)
    File.dirname(__FILE__) + "/fixtures/#{name}"
  end
end
