class PlacesController < ApplicationController

  before_action :set_place, only: [:show]

  def set_place
    @place = BeermappingApi.place_id(params[:id])
  end

  def index
  end

  def show
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    @weather = WeatherApi.weather_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end
end
