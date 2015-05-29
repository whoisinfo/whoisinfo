class UpdateDomainInfo
  def initialize(domain)
    @domain = domain
  end

  def run
    domain.expires_on = lookup.expires_on
    domain.status = lookup.status

    domain.save
  end

  private

  attr_reader :domain

  def lookup
    @lookup ||= whois.lookup(domain.name)
  end

  def whois
    @whois ||= Whois::Client.new
  end
end
