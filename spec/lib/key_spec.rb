describe AwsRotate::Key do
  let(:rotater) do
    rotater = AwsRotate::Key.new
    allow(rotater).to receive(:get_iam_user).and_return('tung')
    allow(rotater).to receive(:check_max_keys_limit).and_return(null)
    allow(rotater).to receive(:cache_access_key).and_return(cache_access_key)
    allow(rotater).to receive(:create_access_key).and_return(create_access_key)
    allow(rotater).to receive(:update_aws_credentials_file).and_return(null)
    allow(rotater).to receive(:delete_old_access_key).and_return(null)
    rotater
  end
  let(:null)              { double(:null).as_null_object }
  let(:cache_access_key)  { null }
  let(:create_access_key) { null }

  describe "rotater" do
    it "run" do
      rotater.run
    end
  end
end
