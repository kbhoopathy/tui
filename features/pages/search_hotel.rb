class SearchHotel < BasePage

  # Query Section Elements
  element(:search_input_field, xpath: "//input[contains(@id,'search-text-input-field')]")
  element(:suggested_location, xpath: "//div[@class='suggestion-dialog destination-search__dialog']/div[@class='suggestion-dialog__wrapper']")

  element(:calendar_icon, xpath: "//button[@data-qa='date_selection_button']")
  element(:apply_date_selection_button, xpath: "//button[@data-qa='date_selection_button_apply']")

  element(:pax_icon, xpath: "//button[@data-qa='guest_selection_button']")
  element(:adult_pax_decrement, xpath: "//button[@data-qa='guest_selection_menu_adults_spin_button_decrement_action']")
  element(:adult_pax_increment, xpath: "//button[@data-qa='guest_selection_menu_adults_spin_button_increment_action']")
  element(:child_pax_decrement, xpath: "//button[@data-qa='guest_selection_menu_children_spin_button_decrement_action']")
  element(:child_pax_increment, xpath: "//button[@data-qa='guest_selection_menu_children_spin_button_increment_action']")
  element(:child_age_dropdown, xpath: "//select[@data-qa='guest_selection_menu_child_native_select']")
  element(:apply_pax_selection_button, xpath: "//button[@data-qa='guest_selection_menu_button_apply']")

  element(:search_button, xpath: "//a[@data-qa='search_submit_button']")

  def select_date(value)
    element(:button, xpath: "//button[@id='date-#{value}']")
  end

  # Result Section Elements
  element(:result_destination, xpath: "//div[@data-qa='quick_search']//search-start")
  element(:result_date_range, xpath: "//span[@data-qa='mobile_summary_date_picker_trigger_button_caption']")
  element(:result_pax_count, xpath: "//span[@data-qa='mobile_summary_guest_picker_trigger_button_caption']")
  element(:hotel_names, xpath: "//h2[@data-qa='offer_tile_title']")
  elements(:reservation_button, xpath: "//button[@data-qa='button']")
  elements(:room_price, xapth: "//p[@class='room-offer__price room-offer__price--desktop']/font//font")
end