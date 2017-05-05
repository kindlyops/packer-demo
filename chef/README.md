kindlyops base cookbook
===============================

TODO: figure out how to use ssh-hardening in a way that allows logins in test-kitchen

## Editing encrypted data bag

```sh
knife data bag edit common shared_secrets --secret-file .encrypted_data_bag_secret --local-mode --editor=vim
```

## To run test-kitchen

```sh
brew install libxml2
bundle install
kitchen create
kitchen converge
kitchen list
kitchen login base-ubuntu-1604
exit
kitchen destroy
```

You can see the test suites and other settings defined in .kitchen.yml
