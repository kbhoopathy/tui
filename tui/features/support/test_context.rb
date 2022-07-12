class TestContext

  attr_reader :environment, :browser, :timeout, :long_timeout, :config, :app_version

  attr_accessor :data

  def initialize
    @config = YAML.load_file(Dir.pwd + '/features/support/config.yml')
    @app_version = @config['app_version']
    @environment = @config['environment']
    @timeout = @config['timeout']
    @long_timeout = @config['long_timeout']
    set_browser(@config['browser'], @config['headless']) if @browser.nil?
    @data = Hash.new
  end

  def set_browser(browser_name, headless)
    case browser_name
    when 'chrome'
      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument("--start-maximized")
      options.add_argument("--disable-cache")
      options.add_argument("--disable-dev-shm-usage")
      options.add_argument("--ignore-certificate-errors")
      options.add_argument("--disable-popup-blocking")
      options.add_argument("--test-type")
      options.add_argument("--disable-download-notification")
      options.add_argument("--disable-popup-blocking")
      options.add_argument("--disable-translate")
      options.add_argument("--no-sandbox")
      options.add_argument("--disable-extensions")
      options.add_argument("--disable-gpu")
      options.add_argument("--remote-debugging-port=9222")
      if headless
        options.add_argument('--headless')
        options.add_argument('--window-size=1920, 1080')
      end
      @browser = Selenium::WebDriver.for :chrome, options: options
    else
      raise "Not supported browser: #{browser_name}!"
    end
  end

end