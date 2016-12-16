
# === {{CMD}}
install () {
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

  cd /progs/rust/$DIR
  ./install.sh --prefix="/progs/rust"

} # === end function
