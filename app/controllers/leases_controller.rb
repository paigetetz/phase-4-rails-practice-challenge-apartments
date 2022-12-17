class LeasesController < ApplicationController
    def index
        leases = Lease.all
        render json: leases
    end

    def create
        lease = Lease.create(lease_params)
        if lease.valid?
            render json: lease, status: :created
        else
            render json: {'errors': lease.errors.full_messages}, status: :unprocessable_entity
        end   
    end

    def destroy
        lease = Lease.find_by_id(params[:id])
        if lease
            lease.destroy
            head :no_content
        else
            render json: {'errors': "Lease not found"}, status: :not_found
            
        end

    end

    private
    def lease_params
        params.permit(:rent, :tenant_id, :apartment_id)
    end
end

