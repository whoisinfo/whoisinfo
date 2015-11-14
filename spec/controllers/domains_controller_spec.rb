require "rails_helper"

describe DomainsController, type: :controller do
  describe "#show" do
    context "when domain exists in database" do
      it "response to success with existing domain" do
        name = "google.com"
        domain = create(:domain, name: name)

        get :show, name: name

        expect(response).to be_success
        expect(assigns(:domain)).to eq(domain)
      end
    end

    context "when domain not exists in database" do
      it "will create a domain entry in database" do
        name = "google.com"

        get :show, name: name

        expect(response).to be_success
        expect(assigns(:domain).name).to eq(name)
      end

      context "when whois details are valid for name" do
        it "will update whois details for new domain" do
          name = "google.com"
          properties = { "foo" => "bar" }
          whois_details = double(
            "WhoisDetails",
            valid?: true,
            expires_on: Date.today,
            status: :registered,
            properties: properties,
          )
          allow(WhoisDetails).
            to receive(:new).with(name).and_return(whois_details)

          get :show, name: name

          expect(response).to be_success
          expect(assigns(:domain).name).to eq(name)
          expect(assigns(:domain).expires_on).to eq(Date.today)
          expect(assigns(:domain).status).to eq("registered")
          expect(assigns(:domain).properties).to eq(properties)
        end
      end

      context "when whois details are not valid" do
        it "will not update the domain info" do
          name = "google.com"
          whois_details = double(
            "WhoisDetails",
            valid?: false,
          )
          allow(WhoisDetails).
            to receive(:new).with(name).and_return(whois_details)

          get :show, name: name

          expect(response).to be_success
          expect(assigns(:domain).name).to eq(name)
          expect(assigns(:domain).expires_on).to eq(nil)
          expect(assigns(:domain).status).to eq(nil)
          expect(assigns(:domain).properties).to eq({})
        end
      end
    end
  end
end
