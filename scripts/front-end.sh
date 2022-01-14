#!/bin/bash

sudo apt update -y
sudo apt install python -y
sudo apt install python-pip -y
sudo pip install Flask
sudo pip install bson
sudo pip install pymongo

##### Indtalll code Deploy agent ###########

git clone https://github.com/indra281/FlaskWithMongoDB.git
cd FlaskWithMongoDB
python app.py &
