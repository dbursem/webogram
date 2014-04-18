sudo apt-get install -y nodejs
wget https://github.com/zhukov/webogram/archive/master.zip
unzip master.zip 
sudo mv webogram-master /opt/webogram
echo "cd /opt/webogram
nodejs server.js >/dev/null 2>&1 &
firefox localhost:8000/app/index.html >/dev/null 2>&1 &" > webogram
sudo mv webogram /usr/local/bin
sudo chmod +x /usr/local/bin/webogram
echo "[Desktop Entry]
Name=Webogram
Comment=Webbased Telegram client
Exec=webogram
Icon=/opt/webogram/app/img/Tlogo_2x.png
Terminal=false
Type=Application
Categories=Application;Network;Internet;
StartupNotify=true" > ~/.local/share/applications/webogram.desktop
