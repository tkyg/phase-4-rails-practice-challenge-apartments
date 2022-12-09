class LeasesController < ApplicationController
  wrap_parameters format: []

  def index
    render json: Lease.all, status: :ok
  end

  def create
    lease = Lease.new(lease_params)
    if lease.save
      render json: lease, status: :created
    else 
      render json: { errors: lease.errors.full_messages }, status: :unprocessable_entity
    end    
  end

  def destroy
    lease = Lease.find_by(id:params[:id])
    if lease
      lease.destroy
      head :no_content
    else
      render json: {error: "Lease not found"}, status: :not_found
    end
  end

  private
  
  def lease_params
    params.permit(:apartment_id, :tenant_id, :rent)
  end

end
