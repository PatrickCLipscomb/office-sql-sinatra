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

get('/admins') do
  @patients = Patient.all()
  @specialties = Specialty.all()
  @doctors = Doctor.all()
  erb(:admins)
end

post('/new_patient') do
  name = params.fetch('name')
  birthday = params.fetch('patient_birthday')
  doctor_id = params.fetch('doctor_id')
  @new_patient = Patient.new({:name => name, :birthday => birthday, :id => nil, :doctor_id => doctor_id})
  @new_patient.save()
  @patients = Patient.all()
  @doctors = Doctor.all()
  @specialties = Specialty.all()
  erb(:admins)
end

post('/new_doctor') do
  name = params.fetch('doctor_name')
  specialty_id = params.fetch('specialty_id')
  @new_doctor = Doctor.new({:name => name, :id => nil, :specialty_id => specialty_id})
  @new_doctor.save()
  @doctors = Doctor.all()
  @specialties = Specialty.all()
  @patients = Patient.all()
  erb(:admins)
end

post('/new_specialty') do
  specialty = params.fetch('specialty_name')
  @new_specialty = Specialty.new({:specialty => specialty, :id => nil})
  @new_specialty.save()
  @specialties = Specialty.all()
  @patients = Patient.all()
  @doctors = Doctor.all()
  erb(:admins)
end

get('/clear_database') do
  Patient.clear()
  Doctor.clear()
  Specialty.clear()
  erb(:admins)
end
