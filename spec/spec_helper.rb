RSpec.configure do |config|
  # 「headless_chromeのno-sandboxオプション」を追加する
  config.before(:each) do |example|
    driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400], options: { args: ['no-sandbox'] } if example.metadata[:type] == :system
  end
  config.before(:each, type: :system) do
    driven_by(:selenium_chrome)
  end
end