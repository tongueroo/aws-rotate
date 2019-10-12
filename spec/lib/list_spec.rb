describe AwsRotate::List do
  let(:list) do
    AwsRotate::List.new
  end

  context "list" do
    it "only profiles with credentials" do
      profiles = list.run
      expect(profiles).to eq %w[parent-account iam-account]
    end
  end
end