clear

echo -E "    ____                              __               "
echo -E "   / __ \____ _____  ___  _________  / ____ _____  ___ "
echo -E "  / /_/ / __ \`/ __ \/ _ \/ ___/ __ \/ / __ \`/ __ \/ \\"
echo -E " / ____/ /_/ / /_/ /  __/ /  / /_/ / / /_/ / / / /  __/"
echo -E "/_/    \__,_/ .___/\___/_/  / .___/_/\__,_/_/ /_/\___/ "
echo -E "   _____ __/_/ _      __   /_/    _____          __    "
echo -E "  / ___// /_  (______/ /_  __  __/ __(____  ____/ /    "
echo -E "  \__ \/ __ \/ / ___/ __ \/ / / / /_/ / _ \/ __  /     "
echo -E " ___/ / / / / (__  / / / / /_/ / __/ /  __/ /_/ /      "
echo -E "/____/_/ /_/_/____/_/ /_/\__,_/_/ /_/\___/\__,_/       "
echo -E "                                                       "

sleep 5
clear

pkg update && pkg upgrade -y
pkg install clang curl git libcrypt libffi libiconv libjpeg* libjpeg-turbo libwebp libxml2 libxslt make ndk-sysroot openssl postgresql python readline wget zlib -y

git clone https://github.com/ArnavVarshney/PaperplaneShishufied/.git
cd PaperplaneShishufied || exit

pip install --upgrade pip setuptools
pip install -r requirements.txt

mv sample_config.env config.env

mkdir -p $PREFIX/var/lib/postgresql
initdb $PREFIX/var/lib/postgresql
pg_ctl -D $PREFIX/var/lib/postgresql start
createdb botdb
createuser botuser

cd ..
echo "pg_ctl -D $PREFIX/var/lib/postgresql start" >startbot.sh
echo "cd PaperplaneShishufied" >>startbot.sh
echo "python3 -m userbot" >>startbot.sh
chmod 755 startbot.sh

echo "Done."
echo "Now edit config.env with nano or anything you want, then run the userbot with startbot.sh"
echo "Please edit the db to postgresql://botuser:@localhost:5432/botdb"
echo "Good luck!"
