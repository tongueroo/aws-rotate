describe AwsRotate::Key do
  let(:rotater) do
    rotater = AwsRotate::Key.new
    # The methods that are commented out have stubs at lower-levels.
    # allow(rotater).to receive(:get_iam_user).and_return('tung')
    allow(rotater).to receive(:check_max_keys_limit).and_return(null)
    allow(rotater).to receive(:cache_access_key).and_return(cache_access_key)
    # allow(rotater).to receive(:create_access_key).and_return(create_access_key)
    allow(rotater).to receive(:update_aws_credentials_file).and_return(null)
    # allow(rotater).to receive(:delete_old_access_key).and_return(null)

    # stub out aws configure calls
    allow(rotater).to receive(:aws_configure_get).and_return(null)
    allow(rotater).to receive(:aws_configure_set).and_return(null)

    # stub out aws clients
    allow(rotater).to receive(:sts).and_return(sts)
    allow(rotater).to receive(:iam).and_return(iam)

    rotater
  end
  let(:null)              { double(:null).as_null_object }
  let(:cache_access_key)  { nil }
  let(:create_access_key) { null }

  let(:iam) do
    iam = double(:null).as_null_object
    resp = OpenStruct.new(
        access_key: OpenStruct.new(
          access_key_id: "FAKE-KEY-ID",
          secret_access_key: "FAKE-SECRET-ACCESS-KEY",
        )
      )

    allow(iam).to receive(:create_access_key).and_return(resp)
    iam
  end

  let(:sts) do
    sts = double(:null).as_null_object
    resp = OpenStruct.new(arn: 'arn:aws:iam::112233445566:user/tung')
    allow(sts).to receive(:get_caller_identity).and_return(resp)
    sts
  end

  describe "rotater" do
    it "run" do
      completed = rotater.run
      expect(completed).to be true
    end
  end
end
