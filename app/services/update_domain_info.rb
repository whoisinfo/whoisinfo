class UpdateDomainInfo
  def initialize(domain)
    @domain = domain
  end

  def run
    domain.expires_on = expires_on
    domain.status = status

    domain.save
  end

  private

  attr_reader :domain

  def status
    if lookup.registered?
      :registered
    elsif lookup.available?
      :available
    end
  end

  def expires_on
    lookup.expires_on
  end

  def lookup
    @lookup ||= whois.lookup(domain.name)
  end

  def whois
    @whois ||= Whois::Client.new
  end
end
