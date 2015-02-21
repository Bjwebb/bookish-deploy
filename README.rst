Bookish Salt Deployment Files
=============================

These are the salt files needed to deploy Bookish. For more information about Bookish itself, please see https://github.com/Bjwebb/Bookish

Currently a demo instance can be deployed to digital ocean (our copy is at http://bookish.bjwebb.co.uk/).

This salt config uses relative paths, so the salt master must be run in the root of the git repository, like this (all salt commands must be run as root):

.. code::

   salt-master -c salt-config

.. code:: bash

   cp -r secret.example secret
   # And then edit the values in secret to match your credentials for digitalocean and sentry

To create a VPS called bookishdemo on Digitalocean: 

.. code:: bash

    salt-cloud --profile digitalocean-ubuntu-small bookishdemo

To update this VPS with the latest docker image (this should be included in the above command by the `start_action` setting in the `cloud` configuration file):

.. code:: bash

    salt bookishdemo state.highstate

To delete the VPS later:

.. code:: bash

    salt-cloud -d -y bookishdemo
