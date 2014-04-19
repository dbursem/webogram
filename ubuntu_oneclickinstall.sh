#!/usr/bin/env bash

_cur=$(pwd);

trap "cd $_cur; exit" SIGHUP SIGINT SIGTERM

if [ "$(lsb_release -is)" != "Ubuntu" ] ; then
    echo "This script is only intended to run on Ubuntu"
    exit 255
fi

if [ $UID -ne 0 ] ; then
    echo "Please run this as root!"
    exit 255
fi

BASE=/opt/webogram

if [ -d "$BASE" ] ; then
    echo "Already exists";
    exit 1
fi

cd /tmp
apt-get install -y nodejs
wget https://github.com/zhukov/webogram/archive/master.zip
unzip master.zip
rm -f master.zip
mv webogram-master $BASE

SCRIPT=/usr/local/bin/webogram

NODEJS=/usr/bin/nodejs
if [ ! -x '/usr/bin/nodejs' ] ; then
    NODEJS=node
fi
cat > $SCRIPT <<OEF
cd /opt/webogram
$NODEJS server.js >/dev/null 2>&1 &
google-chrome-unstable localhost:8000/app/index.html >/dev/null 2>&1 &
OEF

chmod +x $SCRIPT
chown root:root $SCRIPT

# ~ expand niet in een shell script
cat > /usr/share/applications/webogram.desktop <<OEF
[Desktop Entry]
Name=Webogram
Comment=Webbased Telegram client
Exec=webogram
Icon=$BASE/app/img/Tlogo_2x.png
Terminal=false
Type=Application
Categories=Application;Network;Internet;
StartupNotify=true
OEF

cd $_cur
