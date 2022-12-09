class ApartmentsController < ApplicationController
wrap_parameters format: []

  def index
    render json: Apartment.all, status: :ok
  end

  def show
    apartment = Apartment.find_by(id:params[:id])
    if apartment
      render json: apartment, status: :ok
    else 
      render json: {error: "Apartment not found"}, status: :not_found
    end
  end

  def create
    apartment = Apartment.create(apartment_params)
    render json: apartment, status: :created
  end

  def update
    apartment = Apartment.find_by(id:params[:id])
    if apartment
      apartment.update(apartment_params)
      render json: apartment, status: :accepted
    else
      render json: {error: "Apartment not found"}, status: :not_found
    end
  end

  def destroy
    apartment = Apartment.find_by(id:params[:id])
    if apartment
      apartment.destroy
      head :no_content
    else
      render json: {error: "Apartment not found"}, status: :not_found
    end
  end

  private
  
  def apartment_params
    params.permit(:number)
  end

end
