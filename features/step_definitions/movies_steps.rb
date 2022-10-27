
Given /the following dresses exist/ do |dresses_table|
  dresses_table.hashes.each do |dress|
    Dress.create dress
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body.index(e1) < page.body.index(e2))
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(', ').each do |rating|
    step %{I #{uncheck.nil? ? '' : 'un'}check "ratings_#{rating}"}
  end
end

Then /I should see all the dresses/ do
  # Make sure that all the dresses in the app are visible in the table
  Dress.all.each do |dress|
    step %{I should see "#{dress.title}"}
  end
end