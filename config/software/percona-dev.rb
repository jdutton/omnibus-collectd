name "percona-dev"
version "5.5.33-rel31.1-566-static-openssl-1.0.1e"
dependency "rsync"
dependency "ncurses"

source :url => "http://www.percona.com/downloads/Percona-Server-5.5/Percona-Server-5.5.33-31.1/binary/linux/x86_64/Percona-Server-5.5.33-rel31.1-566-static-openssl-1.0.1e.Linux.x86_64.tar.gz",
:md5 => "1fe2c6596d9a1f0fb6f70e348edb89fc"

relative_path "Percona-Server-5.5.33-rel31.1-566-static-openssl-1.0.1e.Linux.x86_64"

build do
  command "#{install_dir}/embedded/bin/rsync -a lib/libmysql* #{install_dir}/embedded/lib/"
  command "#{install_dir}/embedded/bin/rsync -a include/ #{install_dir}/embedded/include/"
  command "#{install_dir}/embedded/bin/rsync -a bin/mysql_config #{install_dir}/embedded/bin/"
end
