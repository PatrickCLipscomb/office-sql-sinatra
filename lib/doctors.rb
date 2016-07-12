class Doctor
  attr_reader(:name, :specialty_id, :id)
  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @specialty_id = attributes.fetch(:specialty_id)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:find) do |identification|
    docs = DB.exec("SELECT * FROM doctors WHERE id = #{identification} LIMIT 1;")
    found_doc = nil
    docs.each() do |doctor|
      found_doc = (Doctor.new({
        :id => doctor.fetch("id").to_i(),
        :name => doctor.fetch("name"),
        :specialty_id => doctor.fetch("specialty_id").to_i
        }))
    end
    found_doc
  end
  define_singleton_method(:all) do
    returned_items = DB.exec("SELECT * FROM doctors ORDER BY name ASC;")
    doctors = []
    returned_items.each() do |doctor|
      name = doctor.fetch('name')
      specialty_id = doctor.fetch('specialty_id').to_i
      id = doctor.fetch('id').to_i
      doctors.push(Doctor.new({:name => name, :specialty_id => specialty_id, :id => id}))
    end
    doctors
  end
  define_method(:save) do
    result = DB.exec("INSERT INTO doctors (name, specialty_id) VALUES ('#{@name}', #{@specialty_id}) RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end
  define_method(:==) do | another_doctor |
    (self.name() == another_doctor.name()) && (self.specialty_id() == another_doctor.specialty_id())
  end

  define_singleton_method(:find_by_specialty) do |specialty|
    doc_by_spec = DB.exec("SELECT doctors.name, doctors.id, doctors.specialty_id FROM doctors LEFT JOIN specialties ON doctors.specialty_id = specialties.id WHERE specialties.id = #{specialty} ")
    doctors = []
    doc_by_spec.each() do |doctor|
      name = doctor.fetch('name')
      specialty_id = doctor.fetch('specialty_id').to_i
      id = doctor.fetch('id').to_i
      doctors.push(Doctor.new(:id => id, :name => name, :specialty_id => specialty_id))
    end
    doctors
  end

end
