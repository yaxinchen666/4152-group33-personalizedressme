Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create_user(user["user_name"], user["password"])
  end
end