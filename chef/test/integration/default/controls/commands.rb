# encoding: utf-8
# copyright: 2015, The Authors

title 'Verify functioning commands'

control "Example command 1.1" do
  impact 1.0
  title "1.1 Verify that a command is functioning by checking the output"
  desc "Python should load and print correct version information"
  describe command('python -V') do
   its('stderr') { should match /Python 2.7.12/}
  end
end
