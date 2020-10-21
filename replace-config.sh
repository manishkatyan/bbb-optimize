#!/bin/bash

echo "Replacing default apply-conf.sh in BBB with your customized version"
cp apply-config.sh /etc/bigbluebutton/bbb-conf/apply-config.sh

echo "Restarting bbb"
bbb-conf --restart
