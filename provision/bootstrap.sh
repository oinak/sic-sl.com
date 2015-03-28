
# Configuration variables with default values
RUBY_VERSION="2.2.0"
APP="sic-sl"
HOSTNAME='sic-sl.dev'

echo -e "\n== #{$APP} on ($RUBY_VERSION) ==\n"

# Inspired by @fxn's https://github.com/rails/rails-dev-box

# The ouput of all these installation steps is noisy. With this utility
# the progress report is nice and concise.
function install {
    echo installing $1
    shift
    DEBIAN_FRONTEND=noninteractive apt-get -y install "$@" >/dev/null 2>&1
}

function install_node {
    echo -e "\nInstalling Node:"
    if [ ! -x /usr/local/bin/node ]; then
        pushd .
        cd /tmp
        VERSION=$1
        wget "http://nodejs.org/dist/v$VERSION/node-v${VERSION}.tar.gz"
        tar xzf node-v${VERSION}.tar.gz
        cd node-v$VERSION
        ./configure
        make && make install
        popd;
    fi
}

function install_ruby_env {
    echo -e "\nRuby develoment environment"
    install 'development tools' build-essential
    su -l vagrant -c 'gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3'
    su -l vagrant -c 'curl -sSL https://get.rvm.io | bash -s -- stable'
    su -l vagrant -c 'source $HOME/.rvm/scripts/rvm'
    su -l vagrant -c "rvm use $RUBY_VERSION --default --install"
    su -l vagrant -c 'gem install bundler'
    su -l vagrant -c 'echo "gem: --no-rdoc --no-ri" >> /home/vagrant/.gemrc'
}

function install_frontend {
    echo -e "\nInstalling Frontend developer environment:"
    install_node '0.12.1'
    npm install -g bower
    npm install -g yo
    npm install -g generator-bourbon-neat
    npm install -g grunt-cli
}

install 'Git' git
install_ruby_env
install_frontend
install 'ACK-Grep' ack-grep
install 'Log colorizer' ccze
install 'Vim' vim

# Needed for docs generation.
update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8

# Hostname
echo "Setting hostname..."
hostname $HOSTNAME

echo 'All set, rock on! thanks to the awesome @fxn!'
