class UpdateDomainsJob < ActiveJob::Base
  queue_as :default

  def perform
    Domain.find_each do |domain|
      UpdateDomainInfo.new(domain).run
    end
  end
end
