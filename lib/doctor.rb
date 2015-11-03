class Doctor
  attr_reader(:name, :specialty, :id)
  
  def initialize(attributes)
    @name = attributes.fetch(:name)
    @specialty = attributes.fetch(:specialty)
    @id = attributes.fetch(:id)
  end
  
  def self.all()
    returned_doctors = DB.exec("SELECT * FROM doctors;")
    doctors = []
    returned_doctors.each() do |doctor|
      name = doctor.fetch('name')
      specialty = doctor.fetch('specialty')
      id = doctor.fetch('id').to_i()
      doctors.push(Doctor.new({:name => name, :specialty => specialty, :id => id}))
    end
    doctors
  end
  
  def self.find(id)
    Doctor.all().each() do |doctor|
      return doctor if doctor.id() == id
    end
  end
  
  def save()
    result = DB.exec("INSERT INTO doctors (name, specialty) VALUES ('#{@name}', '#{@specialty}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end
  
  def patients()
    all_patients = DB.exec("SELECT * FROM patients WHERE doctor_id = #{self.id()}")
    patients = []
    all_patients.each() do |patient|
      name = patient.fetch('name')
      birthdate = patient.fetch('birthdate')
      id = patient.fetch('id').to_i()
      doctor_id = patient.fetch('doctor_id').to_i()
      patients.push(Patient.new({:name => name, :birthdate => birthdate, :id => id, :doctor_id => doctor_id}))
    end
    patients
  end
  
  def ==(comparison)
    self.name() == comparison.name()
  end
end