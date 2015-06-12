class Api::V1::DomainsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def show
    @domain = Domain.find_by_name!(params[:name])
  end

  def create
    @domain = Domain.find_or_create_by(name: domain_params[:name])

    if @domain.save
      render :show, status: :created
    else
      render json: @domain.errors, status: :unprocessable_entity
    end
  end

  private

  def domain_params
    params.require(:domain).permit(:name)
  end
end
