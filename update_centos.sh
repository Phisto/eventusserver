systemctl stop festivals-server
echo "1. Stopped festivals-server"

curl -o /usr/local/go.tar.gz "https://dl.google.com/go/$(curl "https://golang.org/VERSION?m=text").linux-amd64.tar.gz"
tar -C /usr/local -xf /usr/local/go.tar.gz
rm /usr/local/go.tar.gz
ln -sf /usr/local/go/bin/* /usr/local/bin
echo "2. Updated go"

echo "3. Download current festivals-server"
curl -L -o /usr/local/festivals-server.zip https://github.com/Festivals-App/festivals-server/archive/master.zip
unzip /usr/local/festivals-server.zip -d /usr/local
rm /usr/local/festivals-server.zip
echo "4. Downloaded current festivals-server"

cd /usr/local/festivals-server-master || exit
/usr/local/bin/go build main.go
echo "6. Build festivals-server"

mv main /usr/local/bin/festivals-server
restorecon -v /usr/local/bin/festivals-server
echo "7. Installed festivals-server"

systemctl start festivals-server
echo "5. Enabled systemd service"

rm -R /usr/local/festivals-server-master
echo "6. Cleaning up after updating"
sleep 2

# remove this script
rm -- "$0"