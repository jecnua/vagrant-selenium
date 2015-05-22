#!/bin/sh
set -e

CHROME_DRIVER_VERSION='2.15'
SELENIUM_VERSION='2.45'

#Once every restart
if [ ! -f /tmp/updated ]
then
  apt-get update
  apt-get upgrade --assume-yes
  apt-get autoremove --assume-yes
  touch /tmp/updated
fi

#Once
if [ -f /opt/selenium_chrome_installed ]
then
  echo 'Already installed.'
else
  echo ''
  echo 'INSTALLING'
  echo '----------'

  # Add Google public key to apt
  wget -q -O - "https://dl-ssl.google.com/linux/linux_signing_key.pub" | sudo apt-key add -

  # Add Google to the apt-get source list
  echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' >> /etc/apt/sources.list

  # Install Java, Chrome, Xvfb, and unzip
  apt-get update
  apt-get -y install openjdk-7-jre google-chrome-stable xvfb unzip

  # Download and copy the ChromeDriver to /usr/local/bin
  cd /tmp
  wget "http://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip"
  wget "http://selenium-release.storage.googleapis.com/$SELENIUM_VERSION/selenium-server-standalone-$SELENIUM_VERSION.0.jar"
  unzip chromedriver_linux64.zip
  mv chromedriver /usr/local/bin
  mv "selenium-server-standalone-$SELENIUM_VERSION.0.jar" /usr/local/bin

  # So that running `vagrant provision` doesn't redownload everything
  touch /opt/selenium_chrome_installed
fi

# Start Xvfb, Chrome, and Selenium in the background
export DISPLAY=:10
cd

echo "Starting Xvfb ..."
Xvfb :10 -screen 0 1366x768x24 -ac &

# echo "Starting Google Chrome ..."
# google-chrome --remote-debugging-port=9222 &

echo "Starting Selenium ..."
cd /usr/local/bin
nohup java -jar "./selenium-server-standalone-$SELENIUM_VERSION.0.jar" &
