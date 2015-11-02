require('spec_helper')

describe('.all') do
  it('starts as an empty array') do
    expect(Patient.all()).to(eq([]))
  end
  
  it('returns all patients') do
    patient1 = Patient.new({:name => "Bob", :birthdate => "1998-07-19"})
    patient1.save()
    patient2 = Patient.new({:name => "Bob", :birthdate => "1998-07-19"})
    patient2.save()
    expect(Patient.all()).to(eq([patient1, patient2]))
  end
end

describe('#save') do
  it('adds a patient') do
  end
end

describe('#==') do
  it('compares patients by their name and birthdate') do
    patient1 = Patient.new({:name => "Bob", :birthdate => "1998-07-19"})
    patient2 = Patient.new({:name => "Bob", :birthdate => "1998-07-19"})
    expect(patient1 == patient2).to(eq(true))
  end
end