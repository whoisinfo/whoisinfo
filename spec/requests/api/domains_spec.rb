require "rails_helper"

describe "Domains" do
  describe "show" do
    it "will render domain JSON" do
      create(:domain, name: "google.com")

      get "/api/google.com"

      data = JSON.parse(response.body)
      expect(data["name"]).to eq("google.com")
    end
  end
end
