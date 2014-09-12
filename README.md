collectd Omnibus project
========================
This project creates full-stack platform-specific packages for
`collectd`!

Kitchen-based Build Environment
-------------------------------
Every Omnibus project ships will a project-specific
[Berksfile](http://berkshelf.com/) that will allow you to build your omnibus projects on all of the projects listed
in the `.kitchen.yml`. You can add/remove additional platforms as needed by
changing the list found in the `.kitchen.yml` `platforms` YAML stanza.

This build environment is designed to get you up-and-running quickly. However,
there is nothing that restricts you to building on other platforms. Simply use
the [omnibus cookbook](https://github.com/opscode-cookbooks/omnibus) to setup
your desired platform and execute the build steps listed above.

The default build environment requires Test Kitchen and VirtualBox for local
development. Test Kitchen also exposes the ability to provision instances using
various cloud providers like AWS, DigitalOcean, or OpenStack. For more
information, please see the [Test Kitchen documentation](http://kitchen.ci).

Once you have tweaked your `.kitchen.yml` (or `.kitchen.local.yml`) to your
liking, you can bring up an individual build environment using the `kitchen`
command.

```shell
$ bundle install
$ berks install
$ bundle exec kitchen converge default-centos-65
```

Then login to the instance and build the project as described in the Usage
section:

```shell
$ bundle exec kitchen login default-centos-65
[vagrant@default-centos-65] $ cd collectd
[vagrant@default-centos-65] $ bundle install
[vagrant@default-centos-65] $ bundle exec omnibus build collectd --log-level=debug
```

rpm and/or debs appears in pkg directory.

For a complete list of all commands and platforms, run `kitchen list` or
`kitchen help`.
