require('rspec')
require('doctors')
require('pg')
require('patients')
require('specialties')

DB = PG.connect({:dbname => 'office_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM doctors *;")
    DB.exec("DELETE FROM patients *;")
    DB.exec("DELETE FROM specialties *;")
  end
end
