name "collectd"
maintainer "jeff.r.dutton@gmail.com"
homepage "https://github.com/jdutton/omnibus-collectd"

replaces        "collectd"
install_path    "/opt/collectd"
build_version   "5.2.1"  # Make sure this matches the config/software/collectd.rb
build_iteration 1

# creates required build directories
dependency "preparation"

# collectd dependencies/components
dependency "collectd"

exclude "\.git*"
exclude "bundler\/git"
