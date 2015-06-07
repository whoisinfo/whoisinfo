require "rails_helper"

describe "Domains" do
  describe "show" do
    it "Will render domain JSON" do
      create(:domain, name: "google.com")

      get "/api/v1/domains/google.com"

      data = JSON.parse(response.body)
      expect(data["name"]).to eq("google.com")
    end
  end

  describe "create" do
    it "will create a domain entery if not exists" do
      post "/api/v1/domains", domain: { name: "google.com" }

      data = JSON.parse(response.body)
      expect(data["name"]).to eq("google.com")
      expect(Domain.count).to eq(1)
    end

    it "will return domain name if already exists in database" do
      create(:domain, name: "google.com")

      post "/api/v1/domains", domain: { name: "google.com" }

      data = JSON.parse(response.body)
      expect(data["name"]).to eq("google.com")
      expect(Domain.count).to eq(1)
    end
  end
end
