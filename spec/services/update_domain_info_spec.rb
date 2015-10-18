require "rails_helper"

describe UpdateDomainInfo do
  describe "run" do
    it "updates domain information based on whois data" do
      expected_expires_on = Date.today + 1.year
      lookup = double(
        "Lookup",
        expires_on: expected_expires_on,
        registered?: true,
        properties: { foo: :bar }
      )
      whois_client = double("WhoisClient", lookup: lookup)
      allow(Whois::Client).to receive(:new).and_return(whois_client)

      domain = create(:domain)

      UpdateDomainInfo.new(domain).run

      expect(domain.expires_on).to eq(expected_expires_on)
      expect(domain.registered?).to be
      expect(domain.properties).to eq("foo" => "bar")
      expect(whois_client).to have_received(:lookup).with(domain.name)
    end

    it "will set domain as available when it's available?" do
      lookup = double(
        "Lookup",
        expires_on: Date.today - 1.year,
        registered?: false,
        available?: true,
        properties: {}
      )
      whois_client = double("WhoisClient", lookup: lookup)
      allow(Whois::Client).to receive(:new).and_return(whois_client)

      domain = create(:domain)

      UpdateDomainInfo.new(domain).run

      expect(domain.available?).to be
      expect(whois_client).to have_received(:lookup).with(domain.name)
    end
  end
end
