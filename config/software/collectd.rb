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
default_version "5.4.0"

# write_riemann plugin
dependency "protobuf-c"
# write_redis plugin
dependency "credis"

# Curl JSON and XML plugins
# alose used by apache plugin
dependency "libyajl"
dependency "curl"
dependency "openssl"
dependency "libxml2"

# Ping plugin
dependency "liboping"

# DNS plugin
dependency "libpcap"

# libcollectdclient.so depends on libgcrypt
dependency "libgcrypt"

# AMQP plugin
dependency "rabbitmq-c"

# MySQL plugin
dependency "percona-dev"

source :url => "http://collectd.org/files/collectd-#{version}.tar.gz",
       :md5 => "d4176b3066f3b85d85343d3648ea43f6"

relative_path "collectd-#{version}"

configure_env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include -L/lib -L/usr/lib",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CXXFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CPPFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
  "PATH" => "#{install_dir}/embedded/bin:#{ENV["PATH"]}",
}

plugin_opts = [
  "--enable-curl",
  "--enable-curl_json",
  "--enable-curl_xml",
  "--enable-dns",
  "--enable-ping --with-liboping=#{install_dir}/embedded",
  "--enable-write_riemann",
  "--enable-write_http",
  "--enable-write_graphite",
  "--enable-write_redis",
  "--without-perl-bindings"
]

build do
  # patch-aa: fix libxml2 detection without pkg-config
  patch :source => 'patch-aa', :plevel => 0
  command "./configure --prefix=#{install_dir}/embedded #{plugin_opts.join(' ')}", :env => configure_env
  command "make", :env => configure_env
  command "make install", :env => configure_env
  command "mkdir #{install_dir}/sbin #{install_dir}/etc"
  [ "sbin/collectd", "sbin/collectdmon" ].each do |bin|
    command "ln -sf #{install_dir}/embedded/#{bin} #{install_dir}/sbin/"
  end
  [ "bin/collectdctl", "bin/collectd-nagios", "bin/collectd-tg" ].each do |bin|
    command "ln -sf #{install_dir}/embedded/#{bin} #{install_dir}/bin/"
  end
  # move the config to a .dist file
  command "mv #{install_dir}/embedded/etc/collectd.conf #{install_dir}/etc/collectd.conf.dist"
  # this is cleanup.
  # the cmake binaries are effing huge.
  # at this point collectd is built and we don't need them anymore
  %w{ccmake cmake cpack ctest}.each do |bigbin|
    command "rm #{install_dir}/embedded/bin/#{bigbin}"
  end
end
