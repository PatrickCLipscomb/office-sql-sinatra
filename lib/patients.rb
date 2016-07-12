class Patient
  attr_reader(:name, :id, :birthday, :doctor_id)
  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
    @birthday = attributes.fetch(:birthday)
    @doctor_id = attributes.fetch(:doctor_id)
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO patients (name, birthday, doctor_id) VALUES ('#{@name}', '#{@birthday}', #{@doctor_id}) RETURNING id;")
    @id = result.first().fetch('id').to_i
  end

  define_singleton_method(:all) do
    returned_items = DB.exec("SELECT * FROM patients;")
    patients = []
    returned_items.each() do |patient|
      patients.push(Patient.new({:name => patient.fetch('name'), :id => patient.fetch('id').to_i, :birthday => patient.fetch('birthday'), :doctor_id => patient.fetch('doctor_id').to_i}))
    end
    patients
  end

  define_singleton_method(:find_patients_by_doc) do |doctor_id|
    patients = DB.exec("SELECT * FROM patients WHERE doctor_id = #{doctor_id}")
    found_patients = []
    patients.each() do |patient|
      found_patients.push(Patient.new({:name => patient.fetch('name'), :id => patient.fetch('id').to_i, :birthday => patient.fetch('birthday'), :doctor_id => patient.fetch('doctor_id').to_i}))
    end
    found_patients
  end

  define_singleton_method(:count) do |doctor_id|
    count_of_patients = DB.exec("SELECT COUNT (id) FROM patients WHERE doctor_id = #{doctor_id};")
    count_of_patients.getvalue(0,0).to_i
  end

  define_method(:==) do | another_patient |
    self.name() == another_patient.name() && self.birthday == another_patient.birthday && self.doctor_id == another_patient.doctor_id && self.id == another_patient.id
  end

  define_singleton_method(:clear) do
    DB.exec("DELETE FROM patients;")
  end
end
