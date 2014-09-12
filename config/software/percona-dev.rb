name "percona-dev"
default_version "Percona-Server-5.6.16-rel64.2-569.Linux.x86_64.tar.gz"
dependency "rsync"
dependency "ncurses"

source :url => "http://www.percona.com/downloads/Percona-Server-5.6/Percona-Server-5.6.16-64.2/binary/tarball/Percona-Server-5.6.16-rel64.2-569.Linux.x86_64.tar.gz",
       :md5 => "01ffd58c77c55b02b7f05b1ceea4d7ac"

relative_path "Percona-Server-5.6.16-rel64.2-569.Linux.x86_64"

build do
  command "#{install_dir}/embedded/bin/rsync -a lib/libmysql* #{install_dir}/embedded/lib/"
  command "#{install_dir}/embedded/bin/rsync -a include/ #{install_dir}/embedded/include/"
  command "#{install_dir}/embedded/bin/rsync -a bin/mysql_config #{install_dir}/embedded/bin/"
end