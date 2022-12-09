class TenantsController < ApplicationController
  wrap_parameters format: []

  def index
    render json: Tenant.all, status: :ok
  end

  def show
    tenant = Tenant.find_by(id:params[:id])
    if tenant
      render json: tenant, status: :ok
    else 
      render json: {error: "Tenant not found"}, status: :not_found
    end
  end

  def create
    tenant = Tenant.new(apartment_params)
    if tenant.save
      render json: tenant, status: :created
    else 
      render json: { errors: tenant.errors.full_messages }, status: :unprocessable_entity
    end    
  end

  def update
    tenant = Tenant.find_by(id:params[:id])
    if tenant
      tenant.update(tenant_params)
      render json: tenant, status: :accepted
    else
      render json: {error: "Tenant not found"}, status: :not_found
    end
  end

  def destroy
    tenant = Tenant.find_by(id:params[:id])
    if tenant
      tenant.destroy
      head :no_content
    else
      render json: {error: "Tenant not found"}, status: :not_found
    end
  end

  private
  
  def tenant_params
    params.permit(:name, :age)
  end
end
