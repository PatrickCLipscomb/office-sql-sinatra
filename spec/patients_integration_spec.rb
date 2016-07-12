require('int_spec_helper')

describe('patients path', {:type => :feature}) do
  it('provides a list of specialties to choose from') do
    visit('/')
    click_button('Patients')
    expect(page).to have_content("Find a doctor by specialty")
  end

  it('provides a list of doctors of a given specialty') do
    visit('/patients')
    click_link('specialties')
    expect(page).to have_content("Here is a list of doctors with the chosen specialty:")
  end


end
