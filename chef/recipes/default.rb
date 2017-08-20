node.default['chef-client']['log_file'] = '/var/log/chef/client.log'

# default_recipes includes apt to cause `apt-get update` to be run
default_recipes = %w(
  apt
  ntp
)

default_recipes.each do |r|
  include_recipe r
end

our_packages = %w(
  curl
  dstat
  git
  htop
  iproute2
  jq
  lsof
  mtr
  python-pip
  strace
  sysstat
  telnet
  tmux
  traceroute
  vim
  zip
)

package our_packages do
  action :install
end

# make sure that the kernel used is the very latest when building the AMI
package 'linux-image-virtual' do
  action :upgrade
end

# upgrade other packages
execute 'update-packages' do
  command 'DEBIAN_FRONTEND=noninteractive apt-get -fuy -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade'
end

# turn on unattended-upgrades
file '/etc/apt/apt.conf.d/50unattended-upgrades' do
  content %q(Unattended-Upgrade::Allowed-Origins {
    "${distro_id} stable";
    "${distro_id} ${distro_codename}-security";
  };
    )
  notifies :run, 'execute[dpkg-reconfigure-unattended-upgrades]', :immediately
end

execute 'dpkg-reconfigure-unattended-upgrades' do
  command 'dpkg-reconfigure --frontend noninteractive unattended-upgrades'
  action :nothing
end

# enable systat on ubuntu
file '/etc/default/sysstat' do
  content 'ENABLED="true"'
  mode 0644
  owner 'root'
  group 'root'
  action :create
end

easy_install_package 'awscli'

# set up sysadmin users
users_manage "sysadmin" do
  action [ :remove, :create ]
end

# from dev-sec.io, harden SSH configuration
include_recipe "ssh-hardening"
include_recipe "os-hardening"
