class Api::V1::DomainsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def show
    @domain = Domain.find_or_create(params[:name])
  end
end
