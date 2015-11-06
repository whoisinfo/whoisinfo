require "rails_helper"

describe UpdateDomainInfo do
  describe "run" do
    context "when whois details are valid" do
      it "updates domain information based on whois data" do
        expected_expires_on = Date.today + 1.year
        whois_details = double(
          "WhoisDetails",
          valid?: true,
          expires_on: expected_expires_on,
          status: :registered,
          properties: { foo: :bar },
        )
        allow(WhoisDetails).to receive(:new).and_return(whois_details)

        domain = create(:domain)

        UpdateDomainInfo.new(domain).run

        expect(domain.expires_on).to eq(expected_expires_on)
        expect(domain.registered?).to be
        expect(domain.properties).to eq("foo" => "bar")
        expect(WhoisDetails).to have_received(:new).with(domain.name)
      end
    end

    context "when whois details are not valid" do
      it "does not update information for domain" do
        whois_details = double(
          "WhoisDetails",
          valid?: false
        )
        allow(WhoisDetails).to receive(:new).and_return(whois_details)

        domain = create(:domain)

        UpdateDomainInfo.new(domain).run

        expect(domain.expires_on).to eq(domain.expires_on)
        expect(domain.properties).to eq(domain.properties)
        expect(WhoisDetails).to have_received(:new).with(domain.name)
      end
    end
  end
end
