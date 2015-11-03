class Patient
  attr_reader(:name, :birthdate, :id, :doctor_id)
  
  def initialize(attributes)
    @name = attributes.fetch(:name)
    @birthdate = attributes.fetch(:birthdate)
    @id = attributes.fetch(:id)
    @doctor_id = attributes.fetch(:doctor_id)
  end
  
  def self.all()
    returned_patients = DB.exec("SELECT * FROM patients;")
    patients = []
    returned_patients.each() do |patient|
      name = patient.fetch('name')
      birthdate = patient.fetch('birthdate')
      id = patient.fetch('id').to_i()
      doctor_id = patient.fetch('doctor_id').to_i()
      patients.push(Patient.new({:name => name, :birthdate => birthdate, :id => id, :doctor_id => doctor_id}))
    end
    patients
  end
  
  def save()
    result = DB.exec("INSERT INTO patients (name, birthdate, doctor_id) VALUES ('#{@name}', '#{@birthdate}', #{@doctor_id}) RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end
  
  def ==(comparison)
    self.name() == comparison.name() && self.birthdate() == comparison.birthdate()
  end
end