check_package() { ! dpkg --get-selections "$1" 2>&1 | grep -q 'no package'; }
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y automake curl git gnupg make pkg-config software-properties-common sudo zstd
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
for ppa in ppa:git-core/ppa ppa:ondrej/php https://cli.github.com/packages; do
  LC_ALL=C.UTF-8 apt-add-repository "$ppa" -y
done
apt-get install -y git gh
if ! check_package php"$VERSION"; then
  curl -sSLO https://github.com/shivammathur/php-builder/releases/latest/download/install.sh
  chmod a+x ./install.sh
  ./install.sh local "$VERSION"
else
  apt-get install -y php"$VERSION" php"$VERSION"-xml php"$VERSION"-dev
fi
