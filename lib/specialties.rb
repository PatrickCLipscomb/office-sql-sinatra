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
end
