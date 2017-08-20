# encoding: utf-8
# copyright: 2015, The Authors

title 'Example controls'

# you can also use plain tests
describe file('/tmp') do
  it { should be_directory }
end

# you add controls like this
control 'tmp-1.0' do                        # A unique ID for this control
  impact 0.7                                # The criticality, if this control fails.
  title 'Create /tmp directory'             # A human-readable title
  desc 'An optional description...'
  describe file('/tmp') do                  # The actual test
    it { should be_directory }
  end
end

# We are including the ssh-baseline profile and all it's controls,
# but explicitly saying that we are ok with SSH listening on port 2222
include_controls 'ssh-baseline-supermarket' do
  skip_control 'sshd-07'
  skip_control 'ssh-03'
end
