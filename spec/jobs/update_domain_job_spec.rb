require "rails_helper"

describe UpdateDomainJob, type: :job do
  describe "#perform" do
    it "will run UpdateDomainJob for domain" do
      domain = create(:domain)
      update = double("UpdateDomainInfo", run: true)
      allow(UpdateDomainInfo).to receive(:new).and_return(update)

      UpdateDomainJob.new.perform(domain)

      expect(UpdateDomainInfo).to have_received(:new).with(domain)
      expect(update).to have_received(:run)
    end
  end
end
