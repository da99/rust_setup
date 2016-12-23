
# === {{CMD}}
install-llvm () {
  echo  -n "=== Getting latest version: "
  local +x VERSION="$(curl -s "http://releases.llvm.org/download.html" | grep -P "\"([0-9\.]+/llvm-[0-9\.]+\.src\.tar\.xz)" | cut -d'"' -f2 | head -n1 | cut -d'/' -f1)"
  echo "$VERSION"

  cd /tmp

  rm -rf llvm-src
  mkdir llvm-src
  cd llvm-src

  echo "=== Downloading llvm $VERSION ..."
  curl -s -o llvm-${VERSION}.src.tar.xz "http://releases.llvm.org/${VERSION}/llvm-${VERSION}.src.tar.xz"
  tar xf llvm-${VERSION}.src.tar.xz

  cd llvm-${VERSION}.src/projects/
  echo "=== Downloading libunwind... "
  curl -s http://releases.llvm.org/${VERSION}/libunwind-${VERSION}.src.tar.xz | tar xJf -
  mv libunwind-${VERSION}.src libunwind
  mkdir libunwind/build
  cd libunwind/build
  cmake -DLLVM_PATH=../../.. -DLIBUNWIND_ENABLE_SHARED=0 ..
  make

  cp lib/libunwind.a "$PREFIX"/lib/
  cd /tmp/llvm-src/llvm-${VERSION}.src
} # === end function
