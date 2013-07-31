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
version "5.2.1"

dependency "libgcrypt"  # Used by ???

# Curl JSON and XML plugins
dependency "curl"
dependency "openssl"
dependency "libxml2"

# AMQP plugin
dependency "rabbitmq-c"

source :url => "http://collectd.org/files/collectd-#{version}.tar.bz2",
       :md5 => "350934cfea62d37e10191816744f0eb7"

relative_path "collectd-#{version}"

configure_env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include -L/lib -L/usr/lib",
  "CPPFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
}

build do
  command "./configure --prefix=#{install_dir}/embedded", :env => configure_env
  command "make"
  command "make install"
  [ "sbin/collectd", "sbin/collectdmon", "bin/collectdctl" ].each do |bin|
    command "ln -sf #{install_dir}/embedded/#{bin} #{install_dir}/bin/"
  end
end
