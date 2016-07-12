require('sinatra')
require('sinatra/reloader')
require('./lib/specialties')
require('./lib/doctors')
require('./lib/patients')
require('pg')
also_reload('lib/**/*.rb')
DB = PG.connect({:dbname => 'office'})


get('/') do
  @page_title = "home"
  erb(:index)
end

get('/patients') do
  @page_title = "patients"
  @specs = Specialty.all()
  erb(:patients)
end
