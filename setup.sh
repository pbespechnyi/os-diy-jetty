#!/bin/sh

JETTY_VERSION="8.1.13.v20130916"

cd $OPENSHIFT_DATA_DIR

if [ -d "jetty" ] && [ "`cat jetty/VERSION`" == $JETTY_VERSION ]; then

  echo "Jetty already installed"

else

  echo "Installing Jetty ${JETTY_VERSION}"

  if [ -d "jetty" ]; then
    rm -rf jetty
  fi
  
  echo "Downloading http://eclipse.mirror.garr.it/mirrors/eclipse//jetty/8.1.13.v20130916/dist/jetty-distribution-${JETTY_VERSION}.tar.gz"
  curl -o "jetty.tar.gz" "http://eclipse.mirror.garr.it/mirrors/eclipse//jetty/8.1.13.v20130916/dist/jetty-distribution-${JETTY_VERSION}.tar.gz"

  tar -xf jetty.tar.gz
  rm jetty.tar.gz

  mv jetty-distribution-${JETTY_VERSION} jetty

  echo $JETTY_VERSION > jetty/VERSION

  rm -rf jetty/contexts/*
  rm -rf jetty/webapps

  curl -o maven.xml "https://raw.githubusercontent.com/pbespechnyi/os-diy-jetty/master/maven.xml"

fi
