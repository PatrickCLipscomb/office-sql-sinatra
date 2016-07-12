require('spec_helper')

describe(Doctor) do
  describe('#save') do
    it("add the doctor object to the doctors table") do
      new_doc = Doctor.new({:name => "Steve", :specialty_id => 1, :id => nil})
      new_doc.save()
      expect(Doctor.all()).to(eq([new_doc]))
    end
  end
  describe('.all') do
    it("return all of the doctors stored in the doctors table") do
      new_doc = Doctor.new({:name => "Ateve", :specialty_id => 1, :id => nil})
      new_doc2 = Doctor.new({:name => "Steveo", :specialty_id => 1, :id => nil})
      new_doc3 = Doctor.new({:name => "Zteveo", :specialty_id => 1, :id => nil})
      new_doc.save()
      new_doc2.save()
      new_doc3.save()
      expect(Doctor.all()).to(eq([new_doc, new_doc2, new_doc3]))
    end
  end
  describe('.find') do
    it('will return a doctor object by the id provided') do
      new_doc = Doctor.new({:name => "Steve", :specialty_id => 1, :id => nil})
      new_doc2 = Doctor.new({:name => "Steveo", :specialty_id => 2, :id => nil})
      new_doc.save()
      new_doc2.save()
      expect(Doctor.find(new_doc.id)).to(eq(new_doc))
    end
  end

  describe('.find_by_specialty') do
    it("returns a list of doctors by a specific specialty_id") do
      new_spec = Specialty.new({:id => nil, :specialty => 'Gynecologist'})
      new_spec.save()
      new_doc = Doctor.new({:name => "Steve", :specialty_id => new_spec.id, :id => nil})
      new_doc.save()
      expect(Doctor.find_by_specialty(new_spec.id)).to(eq([new_doc]))

    end
  end
end
