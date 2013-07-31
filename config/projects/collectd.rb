#
# Copyright:: Copyright (c) 2013 Stratus Technologies
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

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
