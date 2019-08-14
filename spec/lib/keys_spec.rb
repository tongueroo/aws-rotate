describe AwsRotate::Key do
  let(:keys) do
    AwsRotate::Keys.new(options)
  end
  let(:options) { {select: select, reject: reject } }
  let(:select)  { nil }
  let(:reject)  { nil }

  context "no filters" do
    it "always returns true" do
      result = keys.filter_match?("my-account")
      expect(result).to be true
      result = keys.filter_match?("whatever")
      expect(result).to be true
    end
  end

  context "select filter string match" do
    let(:select) { ["my"] }
    it "test" do
      result = keys.filter_match?("my-account")
      expect(result).to be true
      result = keys.filter_match?("whatever")
      expect(result).to be false
    end
  end

  context "select filter regexp match" do
    let(:select) { ["^my"] }
    it "test" do
      result = keys.filter_match?("my-account")
      expect(result).to be true
      result = keys.filter_match?("test-my-test")
      expect(result).to be false
    end
  end

  context "reject filter" do
    let(:reject) { ["my"] }
    it "test" do
      result = keys.filter_match?("my-account")
      expect(result).to be false
      result = keys.filter_match?("whatever")
      expect(result).to be true
    end
  end

  context "both select and reject filters" do
    let(:select) { ["my"] }
    let(:reject) { ["test"] }
    it "test" do
      result = keys.filter_match?("my-account")
      expect(result).to be true
      result = keys.filter_match?("my-test-account")
      expect(result).to be false
      result = keys.filter_match?("whatever")
      expect(result).to be false
    end
  end
end
