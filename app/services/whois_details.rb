class WhoisDetails
  def initialize(name)
    @name = name
  end

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

  def properties
    lookup.properties
  end

  def valid?
    lookup.present?
  end

  private

  attr_reader :name

  def lookup
    @lookup ||= whois.lookup(name)
  rescue Timeout::Error, Whois::ServerNotFound
    false
  end

  def whois
    @whois ||= Whois::Client.new
  end
end
