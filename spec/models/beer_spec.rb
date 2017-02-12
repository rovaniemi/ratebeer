require 'rails_helper'

RSpec.describe Beer, type: :model do
  #oluen luonti ei onnistu (eli creatella ei synny validia oliota), jos sille ei anneta nimeä
  it "is not saved without name" do
    beer = Beer.create style:"lager"
    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  #oluen luonti ei onnistu, jos sille ei määritellä tyyliä
  it "is not saved without style" do
    beer = Beer.create name:"koff"
    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  #oluen luonti onnistuu ja olut tallettuu kantaan jos oluella on nimi ja tyyli asetettuna
  it "is saved with name and style" do
    beer = Beer.create name:"koff", style:"lager"
    expect(Beer.count).to eq(1)
  end
end
