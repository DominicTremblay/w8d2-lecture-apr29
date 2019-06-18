require 'rails_helper'
require 'support/database_cleaner'

RSpec.feature "Cars", type: :feature, js:true do

  before :each do 

    @car1 = Car.create!(
      make: Make.create!(make: 'Toyota'),
      model: Model.create!(model: 'Prius'),
      style: Style.create!(body_style: 'Extended Cab Pickup'),
      trim: Trim.create!(trim_level: 'XL'),
      year: 1985,
      colour: 'Coriander'
    )

    @car2 = Car.create!(
      make: Make.create!(make: 'Toyota'),
      model: Model.create!(model: 'Prius'),
      style: Style.create!(body_style: 'Extended Cab Pickup'),
      trim: Trim.create!(trim_level: 'Esi'),
      year: 2000,
      colour: 'Lavender'
    )

  end


  context "when visiting cars pages" do

    it 'shows the list of cars' do
      visit cars_path

      expect(page).to have_text("All My Cars!")
      expect(page).to have_css('.car', count: 2)
      expect(page).to have_text('Toyota Prius Extended Cab Pickup XL 1985')
      expect(page).to have_text('Toyota Prius Extended Cab Pickup Esi 2000')
      
      save_screenshot('cars_list.png')


    end

  end
  
end
