#!/bin/bash

if [ -f /usr/bin/mongod ]; then
  echo "MongoDB is installed on your machine."
  kill -0 "$$" || exit
else
  echo "********************* MongoDB 4.0 INSTALL **************************"
  echo "MongoDB is is not installed."
  echo "******************************************************************"
  
  wget -qO- https://www.mongodb.org/static/pgp/server-4.0.asc | sudo bash -c "apt-key add"
  
  sudo bash -c "echo deb http://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse > /etc/apt/sources.list.d/mongodb-org.list"
  sudo bash -c "apt update && apt upgrade -y"
  sudo bash -c "apt install mongodb-org -y"

  sudo bash -c "apt autoremove && apt clean"
  
  sudo bash -c " mkdir /data /data/db"
    
  sudo bash -c "systemctl enable mongod"  #enables Mongo on system startup
  sed -i -e 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf    #Confiure mongo to listen on 0.0.0.0  this is for test env only 
  sudo bash -c "service mongod start"
  
fi

echo "Script complete."