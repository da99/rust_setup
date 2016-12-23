
# === {{CMD}}
install-src () {

  if ( ! type cmake || ! type gcc || ! type curl || ! type git ) &>/dev/null ; then
    echo "=== Installing packages:"
    sudo xbps-install -S cmake make gcc curl git || {
      local +x STAT="$?"
      if [[ "$STAT" != "6" ]]; then
        exit 1
      fi
    }
  fi

  mkdir -p /progs/rust
  cd /progs/rust

  if [[ -d "src" ]]; then
    cd src
    git pull
  else
    git clone https://github.com/rust-lang/rust/ src
    cd src
  fi

  ./configure \
    --prefix="$PREFIX" \
    --target=x86_64-unknown-linux-musl \
    --host=x86_64-unknown-linux-musl \
    --musl-root-x86_64="$PREFIX"
  make
  make install
} # === end function
