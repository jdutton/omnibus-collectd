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

name "cmake"
version "2.8.12"

dependency "ncurses"

source :url => "http://www.cmake.org/files/v2.8/cmake-#{version}.tar.gz",
       :md5 => "105bc6d21cc2e9b6aff901e43c53afea"

# We don't care. This is used for building yajl (and libmysqlclient)
whitelist_file "bin/ccmake"
relative_path "cmake-#{version}"

configure_env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include -L/lib -L/usr/lib",
  "CPPFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
}

build do
  command "./configure --prefix=#{install_dir}/embedded", :env => configure_env
  command "make"
  command "make install"
  [ "cmake", "cpack", "ctest" ].each do |bin|
    command "ln -sf #{install_dir}/embedded/#{bin} #{install_dir}/bin/"
  end
end
