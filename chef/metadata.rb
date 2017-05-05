name             'kindlyops-base'
maintainer       'kindlyops'
maintainer_email 'support@kindlyops.com'
license          'Apache2'
description      'Useful base images to build from'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

# unpinned dependencies
depends 'apt'
depends 'cron'
depends 'datadog'
depends 'fail2ban'
depends 'motd'
depends 'nodejs'
depends 'ntp'
depends 'ohai'
depends 'os-hardening'
depends 'python'
depends 'rbenv'
depends 'ssh-hardening'
depends 'sudo'
depends 'users'
depends 'yum'