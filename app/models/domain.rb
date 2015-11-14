class Domain < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  enum status: [:registered, :available]

  def self.find_or_create(name)
    domain = Domain.find_by(name: name)

    unless domain
      domain = Domain.create(name: name)
      whois_details = WhoisDetails.new(name)

      if whois_details.valid?
        UpdateDomainInfo.new(domain, whois_details).run
      end
    end

    domain
  end
end
