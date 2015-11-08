require "rails_helper"

describe UpdateDomainsJob, type: :job do
  describe "#perform" do
    it "will run UpdateDomainsJob for domains" do
      domain = create(:domain)
      update = double("UpdateDomainInfo", run: true)
      allow(UpdateDomainInfo).to receive(:new).and_return(update)

      UpdateDomainsJob.new.perform

      expect(UpdateDomainInfo).to have_received(:new).with(domain)
      expect(update).to have_received(:run)
    end
  end
end
