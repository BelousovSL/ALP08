yum install -y wget rpmdevtools rpm-build createrepo yum-utils nano

# Собираем пакет
cd ~/rpmbuild/
rpmbuild -bb SPECS/veryimportantapplication.spec

# Создаем репозиторий
dnf -y install nginx
mkdir /usr/share/nginx/html/repo
cp ~/rpmbuild/RPMS/x86_64/*.rpm /usr/share/nginx/html/repo/
createrepo /usr/share/nginx/html/repo/
rm -f /etc/nginx/nginx.conf
cp /root/nginx/nginx.conf /etc/nginx/nginx.conf
systemctl restart nginx
systemctl enable nginx

# Подключаем репозиторий и загружаем свой пакет из него
cat >> /etc/yum.repos.d/otus.repo << EOF
[otus]
name=otus-linux
baseurl=http://localhost/repo
gpgcheck=0
enabled=1
EOF
yum install -y veryimportantapplication
systemctl start veryimportantapplication
systemctl enable veryimportantapplication