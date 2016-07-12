require('spec_helper')

describe(Specialty) do

  describe('#save') do
    it("will save a new specialty") do
      new_spec = Specialty.new({:id => nil, :specialty => 'Gynecologist'})
      new_spec.save()
      expect(Specialty.all()).to(eq([new_spec]))
    end
  end

  describe('.all') do
    it('returns a list of all specialties') do
      new_spec = Specialty.new({:id => nil, :specialty => 'Gynecologist'})
      new_spec.save()
      expect(Specialty.all()).to(eq([new_spec]))
    end
  end

  

end
