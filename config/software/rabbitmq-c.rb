name "rabbitmq-c"
version "rabbitmq-c-v0.3.0"

dependencies ["autoconf", "automake", "libtool"]

source :git => "https://github.com/alanxz/rabbitmq-c.git"

reconf_env = {"PATH" => "#{install_dir}/embedded/bin:#{ENV["PATH"]}"}

configure_env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include -L/lib -L/usr/lib",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
  "PATH" => "#{install_dir}/embedded/bin:#{ENV["PATH"]}",
}

build do
  # autoreconf
  command "autoreconf -i -f", :env => reconf_env
  command "libtoolize", :env => reconf_env

  # configure and build
  command "./configure --prefix=#{install_dir}/embedded", :env => configure_env
  command "make"
  command "make install"
end
