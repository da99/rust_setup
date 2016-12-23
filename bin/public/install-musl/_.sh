
# === {{CMD}}
install-musl () {

  mkdir -p  /progs/musl
  cd /progs/musl

  cd /tmp
  mkdir -p musl-src-install
  cd musl-src-install
  rm   -f musl.latest.tar.gz
  curl -o musl.latest.tar.gz "http://www.musl-libc.org/releases/musl-latest.tar.gz"
  tar -xvzf "musl.latest.tar.gz"

  rm -rf    /progs/musl/src
  mv musl-* /progs/musl/src -i
  cd /progs/musl/src
  ./configure --disable-shared --prefix="$PREFIX"
  make
  make install
  echo "=== Installed musl to $PREFIX"
} # === end function
