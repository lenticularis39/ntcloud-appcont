#!/bin/bash

cd /home/appuser

export HOME=/home/appuser
export XDG_CONFIG_HOME=/home/appuser/.config
export QT_QPA_PLATFORMTHEME=gtk2

echo $VNCPASSWD | base64 --decode > /workdir/vncpasswd

Xvnc :0 -rfbport 5900 -alwaysshared -geometry $GEOMETRY -rfbauth /workdir/vncpasswd &
websockify 8888 :5900 &

python2 -m pyftpdlib -w -u $FTP_USERNAME -P $FTP_PASSWORD -d /home/appuser &

sleep 10

DISPLAY=:0 exec startlxde
