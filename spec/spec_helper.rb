require('rspec')
require('pg')
require('patient')
require('doctor')
require('capybara/rspec')

DB = PG.connect({:dbname => "clinic_test"})

RSpec.configure() do |config|
  config.after(:each) do
    DB.exec("DELETE FROM patients *;")
    DB.exec("DELETE FROM doctors *;")
  end
end