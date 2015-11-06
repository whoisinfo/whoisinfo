class UpdateDomainInfo
  def initialize(domain)
    @domain = domain
  end

  def run
    if whois_details.valid?
      domain.expires_on = expires_on
      domain.status = status
      domain.properties = properties.to_json
      domain.save
    end
  end

  private

  attr_reader :domain

  def status
    whois_details.status
  end

  def expires_on
    whois_details.expires_on
  end

  def properties
    whois_details.properties
  end

  def whois_details
    @whois_details ||= WhoisDetails.new(
      domain.name
    )
  end
end
