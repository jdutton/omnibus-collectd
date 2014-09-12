#
# Copyright:: Copyright (c) 2013 Robby Dyer
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
name "credis"
default_version "0.2.3"

source :url => "https://credis.googlecode.com/files/credis-#{version}.tar.gz",
       :md5 => "338c21667ece272d9ab669738e27b191"

dependency "rsync"

relative_path "credis-#{version}"

env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
  "PATH" => "#{install_dir}/embedded/bin:#{ENV['PATH']}",
}

build do
  command "make"
  command "#{install_dir}/embedded/bin/rsync -a libcredis.so #{install_dir}/embedded/lib/"
  command "#{install_dir}/embedded/bin/rsync -a libcredis.a #{install_dir}/embedded/lib/"
  command "#{install_dir}/embedded/bin/rsync -a credis.h #{install_dir}/embedded/include/"
end