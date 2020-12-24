#!/bin/bash

echo "copying default.pdf"
cp default.pdf /var/www/bigbluebutton-default/
echo "copying logo.png"
cp logo.png /var/www/bigbluebutton-default/
echo "copying favicon.ico"
cp favicon.ico /var/www/bigbluebutton-default/
echo "copying index.html"
cp index.html /var/www/bigbluebutton-default/
echo "copying logo.png for player"
cp logo.png /var/bigbluebutton/playback/presentation/2.0/


echo "Replacing default apply-conf.sh in BBB with your customized version"
cp apply-config.sh /etc/bigbluebutton/bbb-conf/apply-config.sh

echo "Restarting bbb"
bbb-conf --restart
