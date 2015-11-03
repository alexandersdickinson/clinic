require('spec_helper')

describe('#all') do
  it('starts as an empty array') do
    expect(Doctor.all()).to(eq([]))
  end
  
  it('returns a list of doctors') do
    doctor1 = Doctor.new({:name => "Bob", :specialty => "Cardiology", :id => nil})
    doctor1.save()
    doctor2 = Doctor.new({:name => "Bob", :specialty => "Cardiology", :id => nil})
    doctor2.save()
    expect(Doctor.all()).to(eq([doctor1, doctor2]))
  end
end

describe('#==') do
  it('compares doctors based on their name') do
    doctor1 = Doctor.new({:name => "Bob", :specialty => "Cardiology", :id => nil})
    doctor1.save()
    doctor2 = Doctor.new({:name => "Bob", :specialty => "Cardiology", :id => nil})
    doctor2.save()
    expect(doctor1 == doctor2).to(eq(true))
  end
end

describe('#patients') do
  it('returns patients associated with this doctor') do
    doctor = Doctor.new({:name => "Bob", :specialty => "Cardiology", :id => nil})
    doctor.save()
    patient1 = Patient.new({:name => "Bob", :birthdate => "1998-07-19", :id => nil, :doctor_id => 0})
    patient1.save()
    patient2 = Patient.new({:name => "Bob", :birthdate => "1998-07-19", :id => nil, :doctor_id => doctor.id()})
    patient2.save()
    expect(doctor.patients()).to(eq([patient2]))
  end
end

describe('.find') do
  it('finds a doctor based on their id') do
    doctor1 = Doctor.new({:name => "Bob", :specialty => "Cardiology", :id => nil})
    doctor1.save()
    doctor2 = Doctor.new({:name => "Marley", :specialty => "Cardiology", :id => nil})
    doctor2.save()
    doctor3 = Doctor.new({:name => "Ziggy", :specialty => "Cardiology", :id => nil})
    doctor3.save()
    expect(Doctor.find(doctor3.id())).to(eq(doctor3))
  end
end