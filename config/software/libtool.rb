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

name "libtool"
default_version "2.4.4"

source :url => "http://ftpmirror.gnu.org/libtool/libtool-2.4.4.tar.gz",
       :md5 => "353ed373fd3c6d7e47a1f4a8728d966b"

relative_path "libtool-#{version}"

build do
  command "./configure --prefix=#{install_dir}/embedded"
  command "make"
  command "make install"
end
