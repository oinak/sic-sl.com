
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

## Ruby development Environment ##
install 'development tools' build-essential
echo -e "\nGetting RVM keyring"
su -l vagrant -c 'gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3'
echo -e "\nInstalling RVM:"
su -l vagrant -c 'curl -sSL https://get.rvm.io | bash -s -- stable'
echo -e "\nLoading RVM to continue:"
su -l vagrant -c 'source $HOME/.rvm/scripts/rvm'
echo -e "\nInstalling Ruby ($RUBY_VERSION)"
su -l vagrant -c "rvm use $RUBY_VERSION --default --install"
echo -e "\nInstalling Bundler:"
su -l vagrant -c 'gem install bundler'
su -l vagrant -c 'echo "gem: --no-rdoc --no-ri" >> /home/vagrant/.gemrc'

install Git git

install 'ExecJS runtime (for coffee)' nodejs

install 'ACK-Grep' ack-grep

install 'Log colorizer' ccze

install 'Vim' vim

# Needed for docs generation.
update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8

# Hostname
echo "Setting hostname..."
hostname $HOSTNAME

echo 'All set, rock on! thanks to the awesome @fxn!'
