class CarsController < ApplicationController
  def index
    @cars = Car.all

    #filtering cars according to make if there is a param
    @cars = Car.where(make: params[:make]) if (params[:make]).present?
    @cars = Car.where(model: params[:model]) if (params[:model]).present?
    @cars = Car.where(style: params[:style]) if (params[:style]).present?
    @cars = Car.where(trim: params[:trim]) if (params[:trim]).present?
    @cars = Car.where(year: params[:year]) if (params[:year]).present?

  end
end
