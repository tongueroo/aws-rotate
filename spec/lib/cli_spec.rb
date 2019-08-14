describe AwsRotate::CLI do
  before(:all) do
    @args = ""
  end

  describe "aws-rotate" do
    it "list" do
      out = execute("exe/aws-rotate list #{@args}")
      expect(out).to include("AWS Profiles:")
    end
  end
end
