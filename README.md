Base templates for building Vagrant boxes, AMIs, docker images.

Customize list of users.
Customize list of packages.
Fork to add non-general customizations.

Specify automated compliance checks by writing InSpec control libraries.

To test with Chef Test-Kitchen and InSpec, make sure you install ChefDK then:

    $ cd chef
    $ kitchen create   # provisions a vagrant VM
    $ kitchen converge # runs chef recipe
    $ kitchen verify   # runs InSpec controls
    $ kitchen destroy  # cleans up
    # To run all steps together in CI
    $ kitchen test     # create/converge/verify/destroy

