class UpdateDomainJob < ActiveJob::Base
  queue_as :default

  def perform(domain)
    UpdateDomainInfo.new(domain).run
  end
end
