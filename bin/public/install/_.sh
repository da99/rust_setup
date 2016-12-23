
# === {{CMD}}
install () {
  if [[ "$(lsb_release -d | tr -d '\t' | cut -d':' -f2)" == "Void Linux" ]]; then
    if (! type rustc || ! type cargo) &>/dev/null; then
      echo "=== Installing packages:"
      sudo xbps-install -S rust cargo
    else
      echo "=== Already installed: "
      rustc --version
      cargo --version
    fi
    return 0
  fi

  local +x URL="$(curl -s "https://www.rust-lang.org/en-US/downloads.html" \
    | grep -Pzo "(?s) href=\"\K(https://[^\"]+dist/rust-[0-9\.]+[^\"]+x86_64[^\"]+linux-gnu.tar.gz)(?=\")" \
  )"

  local +x FILENAME="$(basename "$URL")"
  local +x DIR="$(basename "$URL" .tar.gz)"

  if [[ -d "/progs/$DIR" ]]; then
    echo "!!! Already exists: /progs/$DIR" >&2
    exit 1
  fi

  cd /tmp
  rm -f rust-*.tar.gz

  echo "=== Downloading: $URL"
  curl -o "$FILENAME" "$URL"
  tar -xvzf "$FILENAME"

  mkdir -p /progs/rust
  rm -rf /progs/rust/$DIR
  mv -i "$DIR" /progs/rust/

  cd $PREFIX/$DIR
  ./install.sh --prefix="$PREFIX"

} # === end function

