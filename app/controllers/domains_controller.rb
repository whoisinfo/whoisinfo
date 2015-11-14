class DomainsController < ApplicationController
  def show
    @domain = Domain.find_or_create(params[:name])
  end
end
