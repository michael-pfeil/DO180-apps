exit
ps
ps auf
kill 9505
ls
lab-configure
git clone https://github.com/michael-pfeil/DO180-apps
ls
cd DO180-apps/
git status
ls
cd
sudo podman search rhel
sudo podman pull rhel
sudo podman images
sudo podman run ubi7/ubi:7.7 echo 'Hello!'
sudo podman run -d rhscl/httpd-24-rhel7:2.4-36.8
sudo podman containers
sudo podman container
sudo podman list
sudo podman ls
sudo podman container ls
sudo podman inspect -l -f "{{.NetworkSettings.IPAddress}}"
sudo podman inspect -l|less
sudo podman inspect|less
lab container-create start
ls
sudo podman run --name mysql-basic > -e MYSQL_USER=user1 -e MYSQL_PASSWORD=mypa55 > -e MYSQL_DATABASE=items -e MYSQL_ROOT_PASSWORD=r00tpa55 \
sudo podman run --name mysql-basic -e MYSQL_USER=user1 -e MYSQL_PASSWORD=mypa55 -e MYSQL_DATABASE=items -e MYSQL_ROOT_PASSWORD=r00tpa55 -d rhscl/mysql-57-rhel7:5.7-3.14
sudo podman ps --format "{{.ID}} {{.Image}} {{.Names}}"
sudo podman container ls
sudo podman exec -it mysql-basic /bin/bash
lab container-create finish
lab container-review grade
lab manage-lifecycle start
sudo podman run --name mysql-db rhscl/mysql-57-rhel7
sudo podman run --name mysql -d -e MYSQL_USER=user1 -e MYSQL_PASSWORD=mypa55 -e MYSQL_DATABASE=items -e MYSQL_ROOT_PASSWORD=r00tpa55 rhscl/mysql-57-rhel7
sudo podman ps --format "{{.ID}} {{.Image}} {{.Names}}"
sudo podman inspect -l -f "{{.NetworkSettings.IPAddress}}"
mysql -uuser1 -h 10.88.0.6 -pmypa55 items < /home/student/DO180/labs/manage-lifecycle/db.sql
sudo podman run --name mysql-2 -it rhscl/mysql-57-rhel7 /bin/bash
sudo podman ps --format "{{.ID}} {{.Image}} {{.Names}}"
sudo podman exec mysql /bin/bash  -c 'mysql -uuser1 -pmypa55 -e "select * from items.Projects;"'
lab manage-lifecycle finish
lab manage-storage start
sudo mkdir -pv /var/local/mysql
sudo semanage fcontext -a  -t container_file_t '/var/local/mysql(/.*)?'
sudo restorecon -R /var/local/mysql
ls -ldZ /var/local/mysql
sudo chown -Rv 27:27 /var/local/mysql
sudo podman pull rhscl/mysql-57-rhel7
sudo podman run --name persist-db  -d -v /var/local/mysql:/var/lib/mysql/data  -e MYSQL_USER=user1 -e MYSQL_PASSWORD=mypa55  -e MYSQL_DATABASE=items -e MYSQL_ROOT_PASSWORD=r00tpa55  rhscl/mysql-57-rhel7
ls -ld /var/local/mysql/items
lab manage-storage finish
sudo podman container ls
sudo podman ls -a
sudo podman ls
lab manage-networking start
sudo podman run --name mysqldb-port  -d -v /var/local/mysql:/var/lib/mysql/data -p 13306:3306  -e MYSQL_USER=user1 -e MYSQL_PASSWORD=mypa55  -e MYSQL_DATABASE=items -e MYSQL_ROOT_PASSWORD=r00tpa55  rhscl/mysql-57-rhel7
sudo podman ps --format="{{.ID}} {{.Names}} {{.Ports}}"
mysql -uuser1 -h 127.0.0.1 -pmypa55  -P13306 items < /home/student/DO180/labs/manage-networking/db.sql
sudo podman exec -it mysqldb-port  /opt/rh/rh-mysql57/root/usr/bin/mysql -uroot items -e "SELECT * FROM Item"
mysql -uuser1 -h 127.0.0.1 -pmypa55  -P13306 items -e "SELECT * FROM Item"
lab manage-networking finish
lab manage-review start
sudo mkdir -pv /var/local/mysql
sudo semanage fcontext -a  -t container_file_t '/var/local/mysql(/.*)?'
sudo restorecon -R /var/local/mysql
sudo chown -Rv 27:27 /var/local/mysql
sudo podman run --name mysql-1 -d -v /var/local/mysql:/var/lib/mysql/data -e MYSQL_USER=user1 -e MYSQL_PASSWORD=mypa55  -e MYSQL_DATABASE=items -e MYSQL_ROOT_PASSWORD=r00tpa55  rhscl/mysql-57-rhel7
sudo podman inspect -l -f "{{.NetworkSettings.IPAddress}}"
mysql -uuser1 -h 10.88.0.10 -pmypa55 items < /home/student/DO180/labs/manage-review/db.sql
sudo podman exec mysql-1 /bin/bash  -c 'mysql -uuser1 -pmypa55 -e "select * from items.Projects;"'
sudo podman exec mysql-1 /bin/bash  -c 'mysql -uuser1 -pmypa55 -e "select * from items.item;"'
cat /home/student/DO180/labs/manage-review/db.sql
sudo podman exec mysql-1 /bin/bash  -c 'mysql -uuser1 -pmypa55 -e "select * from items.Item;"'
sudo podman stop mysql-1
sudo podman run --name mysql-2  -d -v /var/local/mysql:/var/lib/mysql/data  -p 13306:3306  -e MYSQL_USER=user1 -e MYSQL_PASSWORD=mypa55  -e MYSQL_DATABASE=items -e MYSQL_ROOT_PASSWORD=r00tpa55  rhscl/mysql-57-rhel7
sudo podman ps -a > /tmp/my-containers
sudo podman exec -it mysql-2 /bin/bash
sudo podman rm mysql-1
lab manage-review grade
lab manage-review finish
sudo podman search --help
ls -a
ls -al
ls DO180-apps/
ls DO180-apps/temps/
mkdir DO180-apps/up
cp .bash_history DO180-apps/up/
git status
cd DO180-apps/
git status
git add
git add .
git status
git commit -m 'day1'
git push
history -a
