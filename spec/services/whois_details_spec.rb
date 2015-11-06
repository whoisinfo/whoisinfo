require "rails_helper"

describe WhoisDetails do
  describe "#status" do
    it "returns 'registered' when registered" do
      name = "test"
      lookup = double(
        "Lookup",
        registered?: true,
        available?: false,
      )
      whois_client = double("WhoisClient", lookup: lookup)
      allow(Whois::Client).to receive(:new).and_return(whois_client)

      whois_details = WhoisDetails.new(name)

      expect(whois_details.status).to eq(:registered)
      expect(whois_client).to have_received(:lookup).with(name)
    end

    it "returns 'available' when available" do
      name = "test"
      lookup = double(
        "Lookup",
        registered?: false,
        available?: true,
      )
      whois_client = double("WhoisClient", lookup: lookup)
      allow(Whois::Client).to receive(:new).and_return(whois_client)

      whois_details = WhoisDetails.new(name)

      expect(whois_details.status).to eq(:available)
      expect(whois_client).to have_received(:lookup).with(name)
    end
  end

  describe "#expires_on" do
    it "returns expires_on for name" do
      name = "test"
      expected_expires_on = Date.today + 1.year
      lookup = double(
        "Lookup",
        expires_on: expected_expires_on,
      )
      whois_client = double("WhoisClient", lookup: lookup)
      allow(Whois::Client).to receive(:new).and_return(whois_client)

      whois_details = WhoisDetails.new(name)

      expect(whois_details.expires_on).to eq(expected_expires_on)
      expect(whois_client).to have_received(:lookup).with(name)
    end
  end

  describe "#properties" do
    it "returns properties for name" do
      name = "test"
      expected_properties = { foo: :bar }
      lookup = double(
        "Lookup",
        properties: expected_properties,
      )
      whois_client = double("WhoisClient", lookup: lookup)
      allow(Whois::Client).to receive(:new).and_return(whois_client)

      whois_details = WhoisDetails.new(name)

      expect(whois_details.properties).to eq(expected_properties)
      expect(whois_client).to have_received(:lookup).with(name)
    end
  end

  describe "#valid?" do
    context "when lookup present" do
      it "returns true" do
        name = "test"
        lookup = double(
          "Lookup"
        )
        whois_client = double("WhoisClient", lookup: lookup)
        allow(Whois::Client).to receive(:new).and_return(whois_client)

        whois_details = WhoisDetails.new(name)

        expect(whois_details.valid?).to be
      end
    end

    context "when server not found error" do
      it "returns false" do
        name = "test"
        whois_client = double("WhoisClient")
        allow(whois_client).to receive(:lookup).and_raise(Whois::ServerNotFound)
        allow(Whois::Client).to receive(:new).and_return(whois_client)

        whois_details = WhoisDetails.new(name)

        expect(whois_details.valid?).to eq(false)
      end
    end

    context "when whois timesout" do
      it "returns false" do
        name = "test"
        whois_client = double("WhoisClient")
        allow(whois_client).to receive(:lookup).and_raise(Timeout::Error)
        allow(Whois::Client).to receive(:new).and_return(whois_client)

        whois_details = WhoisDetails.new(name)

        expect(whois_details.valid?).to eq(false)
      end
    end
  end
end
