require('sinatra')
require('sinatra/reloader')
require('pg')
require('./lib/patient')
require('./lib/doctor')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "clinic"})

get('/') do
  @doctors = Doctor.all()
  @header = "Doctors"
  erb(:index)
end

post('/new') do
  name = params.fetch('name')
  specialty = params.fetch('specialty')
  @doctor = Doctor.new({:name => name, :specialty => specialty, :id => nil})
  @doctor.save()
  @patients = @doctor.patients()
  @header = "#{@doctor.name()}, #{@doctor.specialty()}"
  erb(:doctor)
end

get('/:id') do
  @doctor = Doctor.find(params.fetch('id').to_i())
  @header = "#{@doctor.name()}, #{@doctor.specialty()}"
  @patients = @doctor.patients()
  erb(:doctor)
end

post('/:id') do
  @doctor = Doctor.find(params.fetch('id').to_i())
  @header = "#{@doctor.name()}, #{@doctor.specialty()}"
  name = params.fetch('name')
  birthdate = params.fetch('birthdate')
  @patient = Patient.new(:name => name, :birthdate => birthdate, :id => nil, :doctor_id => @doctor.id())
  @patient.save()
  @patients = @doctor.patients()
  erb(:doctor)
end