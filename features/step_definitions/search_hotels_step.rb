require 'date'

Given(/^I navigate to TUI home page$/) do
  on BasePage do |page|
    page.open_url($tc.environment)
  end
end

And(/^I click on allow cookies button$/) do
  on BasePage do |page|
    page.allow_cookies_element.click
  end
end

When(/^I select "(Espain|Portugal|Brasil)" from the location$/) do |country|
  on BasePage do |page|
    page.allow_cookies_element.when_not_present
    location = page.location_abbreviation(country)
    page.select_country(location).when_present.click
  end
end

Then(/^I verify that user is redirected to respective "(Espain|Portugal|Brasil)" site$/) do |location|
  on BasePage do |page|
    location = page.location_abbreviation(location)
    actual_url = page.current_url
    expected_url = "#{$tc.data['url']}#{location}"
    expect(actual_url).to eq(expected_url)
  end
end

And(/^I verify that default search page is displayed$/) do
  on SearchHotel do |page|
    element = page.search_input_field_element
    page.wait_until_element_present(element, $tc.timeout)
    expect(element.present?).to be(true)
  end
end

And(/^I enter destination as "([^"]*)" in search field$/) do |destination|
  on SearchHotel do |page|
    page.search_input_field_element.send_keys(destination)
    $tc.data['destination'] = "#{destination}, Italia"
  end
end

When(/^I select the location from the suggestion list$/) do
  on SearchHotel do |page|
    page.suggested_location_element.when_present
    page.search_input_field_element.send_keys(:enter)
  end
end

And(/^I collect the current date$/) do
  on SearchHotel do |page|
    current_date = DateTime.now
    future_date = current_date.next_month
    $tc.data['start_date'] = future_date
    $tc.data['end_date'] = future_date.next_day
  end
end

And(/^I select future date range one month from the current date$/) do
  on SearchHotel do |page|
    page.calendar_icon_element.click
    page.apply_date_selection_button_element.when_present

    page.select_date($tc.data['start_date'].strftime("%Y-%m-%d")).when_present.click
    page.select_date($tc.data['end_date'].strftime("%Y-%m-%d")).when_present.click
    page.apply_date_selection_button_element.click
  end
end

And(/^I click on pax icon$/) do
  on SearchHotel do |page|
    page.pax_icon_element.click
  end
end

When(/^I select "([^"]*)" from the pax$/) do |pax_details|
  on SearchHotel do |page|
    pax_details = pax_details.split(' ')
    pax_count = pax_details.first.to_i
    pax_type = pax_details.last

    initial_pax_count = pax_type == 'adults' ? 2 : 0
    while (initial_pax_count < pax_count)
      element = pax_type == 'adults' ? page.adult_pax_increment_element : page.child_pax_increment_element
      element.when_present.click
      initial_pax_count = initial_pax_count + 1
    end

    if pax_type == 'adults'
      $tc.data['adult_count'] = pax_count
    else
      $tc.data['child_count'] = pax_count
    end
  end
end

When(/^I click on apply button from pax selection$/) do
  on SearchHotel do |page|
    page.apply_pax_selection_button_element.click
  end
end

And(/^I click on search button$/) do
  on SearchHotel do |page|
    page.search_button_element.click
  end
end

When(/^I select child age$/) do
  on SearchHotel do |page|
    page.child_age_dropdown_element.click
    page.child_age_dropdown_element.send_keys(2)
    page.child_age_dropdown_element.send_keys(:enter)
  end
end

Then(/^I verify that hotels listed for the selected date and pax range$/) do
  on SearchHotel do |page|
    page.result_destination_element.when_present
    actual_date_range = page.result_date_range_element.text
    expected_date_range = "#{$tc.data['start_date'].strftime("%d/%m/%Y")} — #{$tc.data['end_date'].strftime("%d/%m/%Y")}"
    expect(actual_date_range).to eq(expected_date_range)

    actual_pax_details = page.result_pax_count_element.text.split(',')
    actual_adult_count = actual_pax_details[0].split().first
    expect(actual_adult_count.to_i).to eq($tc.data['adult_count'])

    actual_child_count = actual_pax_details[1].split().first
    expect(actual_child_count.to_i).to eq($tc.data['child_count'])
  end
end

Then(/^I verify that user is redirected to available hotels page$/) do
  on SearchHotel do |page|
    page.result_destination_element.when_present
    expect(page.title).to eq('Roma, Italia: Reserva tu hotel ahora | TUI')
  end
end

When(/^I click on reservation button on the first hotel$/) do
  on SearchHotel do |page|
    $tc.data['selected_hotel'] = page.hotel_names_element.when_present.text
    page.reservation_button_elements.first.click
  end
end

When(/^I switch to the "([^"]*)" tab$/) do |tab|
  on SearchHotel do |page|
    tab = tab == 'parent' ? 'first' : 'last'
    page.switch_window(tab)
  end
end

Then(/^I verify that selected hotel reservation page opened$/) do
  on SearchHotel do |page|
    expect(page.title).to eq("#{$tc.data['selected_hotel']} (Rome - Italia) | TUI")
  end
end

And(/^I verify the price displayed for the selected hotel$/) do
  on SearchHotel do |page|
    price = page.room_price_elements.map { |element| element.text }
  end
end