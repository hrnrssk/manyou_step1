RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by(:selenium_chrome)
  end
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end
end