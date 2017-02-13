require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if multible is returned by the API, they appear at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1),
       Place.new( name:"Herkkuhaarukka", id: 2)]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Herkkuhaarukka"
  end

  it "if none is returned by the API shown message 'No locations in'" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
        []
    )
    visit places_path
    fill_in('city',with: 'kumpula')
    click_button "Search"
    save_and_open_page
    expect(page).to have_content "No locations in kumpula"
  end
end

#jos API palauttaa useita olutpaikkoja, kaikki näistä näytetään sivulla
#jos API ei löydä paikkakunnalta yhtään olutpaikkaa (eli paluuarvo on tyhjä taulukko), sivulla näytetään ilmoitus "No locations in etsitty paikka"
