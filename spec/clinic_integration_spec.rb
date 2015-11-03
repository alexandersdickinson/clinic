require('spec_helper')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('the doctor addition path', :type => :feature) do
  it('creates a new doctor') do
    visit('/')
    fill_in('name', :with => "Bob")
    fill_in('specialty', :with => "Cardiology")
    click_button('New Doctor')
    expect(page).to(have_content("Bob, Cardiology"))
  end
end

describe('the doctor path', :type => :feature) do
  it('creates a new patient') do
    doctor = Doctor.new({:name => "Bob", :specialty => "Cardiology", :id => nil})
    doctor.save()
    visit('/')
    click_link('Bob')
    fill_in('name', :with => "Jane")
    fill_in('birthdate', :with => "1999-08-16")
    click_button('Add Patient')
    expect(page).to(have_content("Jane, born 1999-08-16"))
  end
  
  it('shows only patients of one doctor') do
    patient1 = Patient.new({:name => "Ralph", :birthdate => "1998-07-19", :id => nil, :doctor_id => 0})
    patient1.save()
    patient2 = Patient.new({:name => "Josh", :birthdate => "1998-07-19", :id => nil, :doctor_id => 0})
    patient2.save()
    doctor = Doctor.new({:name => "Bob", :specialty => "Cardiology", :id => nil})
    doctor.save()
    visit('/')
    click_link('Bob')
    expect(page).not_to(have_content("Josh"))
    expect(page).not_to(have_content("Ralph"))
  end
end