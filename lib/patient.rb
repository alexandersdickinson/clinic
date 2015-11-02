class Patient
  attr_reader(:name, :birthdate)
  
  def initialize(attributes)
    @name = attributes.fetch(:name)
    @birthdate = attributes.fetch(:birthdate)
  end
  
  def self.all()
    returned_patients = DB.exec("SELECT * FROM patients;")
    patients = []
    returned_patients.each() do |patient|
      name = patient.fetch('name')
      birthdate = patient.fetch('birthdate')
      id = patient.fetch('id')
      patients.push(Patient.new({:name => name, :birthdate => birthdate, :id => id}))
    end
    patients
  end
  
  def save()
    result = DB.exec("INSERT INTO patients (name, birthdate) VALUES ('#{@name}', '#{@birthdate}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end
  
  def ==(comparison)
    self.name() == comparison.name() && self.birthdate() == comparison.birthdate()
  end
end