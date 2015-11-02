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