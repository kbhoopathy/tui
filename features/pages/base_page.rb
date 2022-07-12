class BasePage
  include PageObject
  include RSpec::Matchers

  # -----------------------------------------------------------
  #Common Method
  # -----------------------------------------------------------
  # Method Generates URL
  def open_url(env)
    $tc.data['url'] = case env
                      when 'production'
                        "https://stay.tui.com/"
                      when 'qa'
                        #TODO: URL NOT AVAILABLE
                      end
    get($tc.data['url'])
  end

  #Method Return Location Abbreviation
  def location_abbreviation(country)
    location = case country
               when 'Espain'
                 'es'
               when 'Portugal'
                 'pt'
               when 'Brasil'
                 'br'
               end
    location
  end

  #Method for JavaScript Click
  def js_click(element)
    begin
      element.click
    rescue => e
      puts "Exception! Click doesn't work. #{e} Trying JS click!"
      self.execute_script("arguments[0].click();", element)
    end
  end

  #Method to Wait for an Element to Present
  def wait_until_element_present(element, timeout)
    element.wait_until(timeout) do |element|
      break if element.present?
    end
  end

  #Method to Handle Windows
  def switch_window(window)
    if window == 'first'
      switch_to.window(window_handles.first)
    elsif window == 'last'
      switch_to.window(window_handles.last)
    else
      switch_to.window(window)
    end
  end

  # -----------------------------------------------------------
  # Common Locators
  # -----------------------------------------------------------
  #Cookies Setting Element
  element(:allow_cookies, css: '#cookies-content #AcceptReload')
  element(:preferences, css: '#cookies-content #ChangeReload')

  #Select Country Element
  def select_country(location)
    element(:button, xpath: "//button[@data-locale='#{location}']")
  end

end