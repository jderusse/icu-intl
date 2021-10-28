curl -o /tmp/icu.tgz -sL https://github.com/unicode-org/icu/archive/refs/tags/release-"${ICU/./-}".tar.gz
tar -zxf /tmp/icu.tgz -C /tmp
(
  cd /tmp/icu-release-"${ICU/./-}"/icu4c/source || exit 1
  sudo mkdir /usr/local/icu
  sudo ln -sf /usr/include/locale.h /usr/include/xlocale.h || true
  ./configure --prefix=/usr/local/icu
  make -j"$(nproc)"
  sudo make install
)
