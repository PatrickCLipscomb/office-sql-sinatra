require('spec_helper')

describe(Patient) do
  describe('#save') do
    it("add the patient object to the patients table") do
      new_patient = Patient.new({:name => "Steve", :doctor_id => 1, :id => nil, :birthday => '12/23/1992'})
      new_patient.save()
      expect(Patient.all()).to(eq([new_patient]))
    end
  end
  describe('.all') do
    it("return all of the patients stored in the patients table") do
      new_doc = Patient.new({:name => "Steve", :doctor_id => 1, :id => nil, :birthday => '12/23/1992'})
      new_doc2 = Patient.new({:name => "Steveo", :doctor_id => 2, :id => nil, :birthday => '12/23/1982'})
      new_doc.save()
      new_doc2.save()
      expect(Patient.all()).to(eq([new_doc, new_doc2]))
    end
  end
  describe('.find_patients_by_doc') do
    it("returns a list of patients by a specific doctor_id") do
      new_doc = Doctor.new({:name => "Steve", :specialty_id => 1, :id => nil})
      new_doc.save()
      new_spec = Patient.new({:name => "Steve", :doctor_id => new_doc.id, :id => nil, :birthday => '12/23/1992'})
      new_spec.save()
      expect(Patient.find_patients_by_doc(new_doc.id)).to(eq([new_spec]))
    end
  end
  describe('.count') do
    it("returns the number of patients who have a given doctor") do
      new_doc = Doctor.new({:name => "Steve", :specialty_id => 1, :id => nil})
      new_doc.save()
      new_spec = Patient.new({:name => "Steve", :doctor_id => new_doc.id, :id => nil, :birthday => '12/23/1992'})
      new_spec.save()
      new_spec2 = Patient.new({:name => "Steve", :doctor_id => new_doc.id, :id => nil, :birthday => '12/23/1992'})
      new_spec2.save()
      new_spec3 = Patient.new({:name => "Steve", :doctor_id => new_doc.id, :id => nil, :birthday => '12/23/1992'})
      new_spec3.save()
      new_spec4 = Patient.new({:name => "Steve", :doctor_id => new_doc.id, :id => nil, :birthday => '12/23/1992'})
      new_spec4.save()
      expect(Patient.count(new_doc.id)).to(eq(4))
    end
  end
end
