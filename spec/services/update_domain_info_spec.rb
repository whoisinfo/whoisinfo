require "rails_helper"

describe UpdateDomainInfo do
  describe "run" do
    it "updates domain information based on whois data" do
      expected_expires_on = Date.today + 1.year
      expected_status = "registered"
      lookup = double(
        "Lookup",
        expires_on: expected_expires_on,
        status: expected_status
      )
      whois_client = double("WhoisClient", lookup: lookup)
      allow(Whois::Client).to receive(:new).and_return(whois_client)

      domain = create(:domain)

      UpdateDomainInfo.new(domain).run

      expect(domain.expires_on).to eq(expected_expires_on)
      expect(domain.status).to eq(expected_status)
      expect(whois_client).to have_received(:lookup).with(domain.name)
    end
  end
end
