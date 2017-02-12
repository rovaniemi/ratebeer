require 'rails_helper'

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    visit singin_path
    fill_in('username', with:'Pekka')
    fill_in('password', with:'Foobar1')
    click_button('Log in')
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  describe "user ratings" do
    before :each do
      sign_in(username:"Pekka", password:"Foobar1")
      brewery = FactoryGirl.create :brewery, name:"Koffin panimo"
      beer = FactoryGirl.create :beer, name:"Koff", brewery:brewery
      FactoryGirl.create(:rating, score:23, beer:beer, user:user)
      FactoryGirl.create(:rating, score:12, beer:beer2, user:user)
    end

    it "has right amount of ratings" do
      visit user_path(user)
      expect(page).to have_content "Has made 2 ratings, average 17.5"
    end

    it "can also remove rating" do
      visit user_path(user)
      expect{
        page.find('li',:text => 'Karhu').click_link('delete')
      }.to change{user.ratings.count}.from(2).to(1)
      expect(page).not_to have_content "Karhu"
    end

    it "user has own favourite brewery and style" do
      visit user_path(user)
      expect(page).to have_content "Brewery: Koffin panimo"
      expect(page).to have_content "Style: Lager"
    end
  end
end
