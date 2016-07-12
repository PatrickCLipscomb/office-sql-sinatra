class Specialty
  attr_reader(:specialty, :id)
  define_method(:initialize) do |attributes|
    @specialty = attributes.fetch(:specialty)
    @id = attributes.fetch(:id)
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO specialties (specialty) VALUES ('#{@specialty}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  define_singleton_method(:all) do
    specialties = DB.exec("SELECT * FROM specialties;")
    spec_list = []
    specialties.each() do |specialty|
      spec_list.push(Specialty.new({:id => specialty.fetch("id").to_i, :specialty => specialty.fetch("specialty")}))
    end
    spec_list
  end

  define_method(:==) do | another_spec |
    self.specialty() == another_spec.specialty() && self.id() == another_spec.id()
  end

  define_singleton_method(:clear) do
    DB.exec("DELETE FROM specialties;")
  end

  define_singleton_method(:find_by_specialty_id) do |id|
    specialty = DB.exec("SELECT * FROM specialties WHERE id = #{id};")
    found_specialty = nil
    specialty.each() do |spec|
      found_specialty = Specialty.new({
        :id => spec.fetch("id").to_i,
        :specialty => spec.fetch("specialty")
        })
    end
    found_specialty
  end
end
