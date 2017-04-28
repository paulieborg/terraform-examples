require 'awspec'

  describe vpc('kitchen-terraform') do
    it { should exist }
    it { should be_available }
    its(:vpc_id) { should eq 'vpc-82e36ae6' }
    its(:cidr_block) { should eq '172.16.0.0/16' }
    it { should have_route_table('rtb-af3767cb') }
    it { should have_network_acl('acl-99bdf0fd') }
  end
