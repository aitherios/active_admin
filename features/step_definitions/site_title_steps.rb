Then /^I should see the site title "([^"]*)"$/ do |title|
  page.should have_css('.brand', :text => title)
end

Then /^I should not see the site title "([^"]*)"$/ do |title|
  page.should_not have_css('.brand', :text => title)
end

Then /^I should see the site title image "([^"]*)"$/ do |image|
  page.should have_css('.brand img', :src => image)
end

Then /^I should see the site title image linked to "([^"]*)"$/ do |url|
  page.should have_css('.brand', :href => url)
end