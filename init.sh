#!/bin/bash

cd /home/appuser

export HOME=/home/appuser
export XDG_CONFIG_HOME=/home/appuser/.config

Xvnc :0 -rfbport 5900 -alwaysshared -geometry 1280x720 -rfbauth /workdir/vncpasswd &
websockify 8888 :5900 &

twistd -n ftp --password-file=ftppasswd --root=$HOME &

sleep 10

DISPLAY=:0 exec startlxde
