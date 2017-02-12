require 'rails_helper'

include Helpers

describe "Beer" do
  let!(:user) { FactoryGirl.create :user }

  before :each do
    FactoryGirl.create :brewery
    visit singin_path
    fill_in('username', with:'Pekka')
    fill_in('password', with:'Foobar1')
    click_button('Log in')
  end

  describe "New beer" do

    it "is redirected back to new beer form if wrong credentials given" do
      visit new_beer_path
      click_button "Create Beer"
      expect(Beer.count).to be(0)
      expect(current_path).to eq(beers_path)
      expect(page).to have_content "Name can't be blank"
    end

    it "can make new beer with right credentials" do
      visit new_beer_path
      fill_in('beer_name', with:'Jotain')
      select('Porter', from:'beer[style]')
      select('anonymous', from:'beer[brewery_id]')

      expect{
         click_button "Create Beer"
      }.to change{Beer.count}.from(0).to(1)
    end
  end
end
