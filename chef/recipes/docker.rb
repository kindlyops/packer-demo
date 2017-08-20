node.default['chef-client']['log_file'] = '/var/log/chef/client.log'

# default_recipes
# we don't run the AWS recipe by default so that these recipes
# can be tested in test-kitchen more easily.
default_recipes = %w(
  yum
)

default_recipes.each do |r|
  include_recipe r
end

# set up sysadmin users
users_manage "sysadmin" do
  action [ :remove, :create ]
end

# enable EPEL
yum_repository 'epel' do
  mirrorlist 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-7&arch=$basearch'
  description 'Extra Packages for Enterprise Linux 7 - $basearch'
  enabled true
  gpgcheck true
  gpgkey 'https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7'
end

our_packages = %w(
  vim-enhanced
  jq
  bzip2
  python-pip
  python-devel
  libpng-devel
  openssl-devel
  freetype-devel
  zlib-devel
  libcurl
  libcurl-devel
)

# "Development Tools" group
dev_tools = %w(
  bison
  byacc
  cscope
  ctags
  cvs
  diffstat
  doxygen
  flex
  gcc
  gcc-c++
  gcc-gfortran
  gettext
  git
  indent
  intltool
  libtool
  patch
  patchutils
  rcs
  redhat-rpm-config
  rpm-build
  subversion
  swig
  systemtap
)
package our_packages do
  action :install
end

package dev_tools do
  action :install
end

python_packages = [
  ['numpy', '1.9.3'],
  ['matplotlib', '1.4.3'],
  ['pandas', '0.16.2'],
  ['future', '0.15.2'],
]

python_runtime 'standard' do
  version '2.7'
  provider :system
  pip_version true
end

python_package 'pip' do
  action :upgrade
end

python_packages.each do |p, v|
  python_package p do
    action :install
    version v
  end
end

