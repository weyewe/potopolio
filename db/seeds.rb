standard_role = Role.create :name => ROLE_NAME[:standard]
premium_role = Role.create :name => ROLE_NAME[:premium]

rajakuraemas = User.create :email => "rajakuraemas@gmail.com", :password => "willy1234",
  :password_confirmation => "willy1234"