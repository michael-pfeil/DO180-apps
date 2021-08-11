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
ls .. -al
git commit -a
cp ../.bash_history up/
git status
git commit -a
git log
git commit --amend
git log
git status
git add .
git commit --amend
git push --force
clear
lab image-operations start
sudo podman login quay.io
sudo podman run -d --name official-httpd  -p 8180:80 quay.io/redhattraining/httpd-parent
sudo podman exec -it official-httpd /bin/bash
sudo podman diff official-httpd
sudo podman stop official-httpd
sudo podman diff official-httpd
sudo podman commit  -a 'Michael Pfeil' official-httpd do180-custom-httpd
sudo podman images
cat /usr/local/etc/ocp4.config
. /usr/local/etc/ocp4.config
sudo podman tag do180-custom-httpd  quay.io/${RHT_OCP4_QUAY_USER}/do180-custom-httpd:v1.0
sudo podman images
sudo podman push  quay.io/${RHT_OCP4_QUAY_USER}/do180-custom-httpd:v1.0
sudo podman search do180
sudo podman search do180|grep micha
sudo podman pull  -q quay.io/${RHT_OCP4_QUAY_USER}/do180-custom-httpd:v1.0
lab image-operations finish
lab image-review start
sudo podman pull -q quay.io/${RHT_OCP4_QUAY_USER}/redhattraining/
sudo podman pull -q quay.io/${RHT_OCP4_QUAY_USER}/redhattraining/nginx:1.17
sudo podman pull -q quay.io/redhattraining/nginx:1.17
sudo podman run --name official-nginx  -d -p 8080:80 quay.io/redhattraining/nginx:1.17
sudo podman exec -it official-nginx /bin/bash
sudo podman stop official-nginx-dev
sudo podman stop official-nginx
sudo podman commit  -a 'Michael Pfeil' official-nginx do180/mynginx:v1.0-SNAPSHOT
sudo podman run --name official-nginx-dev  -d -p 8080:80 do180/mynginx:v1.0-SNAPSHOT
sudo podman exec -it official-nginx-dev /bin/bash
sudo podman images
sudo podman rm a5444d585639
sudo podman rmi a5444d585639
sudo podman search ubi
lab image-review finish
sudo podman images
sudo podman ps
sudo podman stop 0492a20819ef
lab dockerfile-review start
cd /home/student/DO180/labs/dockerfile-review/
nano Dockerfile
rm Dockerfile 
nano Dockerfile
cat Dockerfile 
sudo podman build --layers=false -t do180/custom-apache .
sudo podman images
sudo podman run -d --name dockerfile -p 20080:8080 do180/custom-apache
lab dockerfile-review grade
lab dockerfile-review finish
nano /home/student/DO180/labs/dockerfile-create/Dockerfile
lab openshift-resources start
. /usr/local/etc/ocp4.config
oc login -u ${RHT_OCP4_DEV_USER} -p ${RHT_OCP4_DEV_PASSWORD} ${RHT_OCP4_MASTER_API}
oc new-project ${RHT_OCP4_DEV_USER}-mysql-openshift
oc new-app --as-deployment-config > --docker-image=registry.access.redhat.com/rhscl/mysql-57-rhel7:latest > --name=mysql-openshift > -e MYSQL_USER=user1 -e MYSQL_PASSWORD=mypa55 -e MYSQL_DATABASE=testdb \
oc new-app --as-deployment-config \--docker-image=registry.access.redhat.com/rhscl/mysql-57-rhel7:latest \--name=mysql-openshift -e MYSQL_USER=user1 -e MYSQL_PASSWORD=mypa55 -e MYSQL_DATABASE=testdb -e MYSQL_ROOT_PASSWORD=r00tpa55
oc status
oc get pods
oc describe pod mysql-openshift-1-wdhpb 
oc get svc
oc expose service mysql-openshift
oc ge trt



oc get rt
oc get route
oc port-forward mysql-openshift-1-xg665 3306:3306
oc port-forward mysql-openshift-1-wdhpb 3306:3306
bg
mysql -uuser1 -pmypa55 --protocol tcp -h localhost
oc delete project ${RHT_OCP4_DEV_USER}-mysql-openshift
lab openshift-resources finish
lab openshift-routes start
oc whoami
oc new-project ${RHT_OCP4_DEV_USER}-route
oc new-app --as-deployment-configphp:7.3~https://github.com/${RHT_OCP4_GITHUB_USER}/DO180-apps--context-dir php-helloworld --name php-helloworld
oc new-app --as-deployment-config php:7.3~https://github.com/${RHT_OCP4_GITHUB_USER}/DO180-apps --context-dir php-helloworld --name php-helloworld
oc get pods -w
oc describe svc/php-helloworld
curl php-helloworld-${RHT_OCP4_DEV_USER}-route.${RHT_OCP4_W ILDCARD_DOMAIN}
curl php-helloworld-${RHT_OCP4_DEV_USER}-route.${RHT_OCP4_WILDCARD_DOMAIN}
lab openshift-routes finish
oc get all
oc get pod
cat /usr/local/etc/ocp4.config:
oc get pod
lab openshift-s2i start
cd ~/DO180-apps
gir status
git status
git log
git branch back
git log
git reset f7cd8963ef353d9173c3a21dcccf402f3616840b
git log
git log --graph --oneline --decorate --all
git push -u origin s2i
git checkout -b s2i
git push -u origin s2i
cat /usr/local/etc/ocp4.config:
. /usr/local/etc/ocp4.config
oc whoami
oc new-project ${RHT_OCP4_DEV_USER}-s2i
new-app --as-deployment-config php:7.3  --name=php-helloworld  https://github.com/${RHT_OCP4_GITHUB_USER}/DO180-apps#s2i  --context-dir php-helloworld
oc new-app --as-deployment-config php:7.3  --name=php-helloworld  https://github.com/${RHT_OCP4_GITHUB_USER}/DO180-apps#s2i  --context-dir php-helloworld
oc get pod
oc logs --all-containers  -f php-helloworld-1-build
oc describe dc/php-helloworld
oc expose service php-helloworld  --name ${RHT_OCP4_DEV_USER}-helloworld
oc get route -o jsonpath='{..spec.host}{"\n"}'
curl hhwqvv-helloworld-hhwqvv-s2i.apps.na45.prod.nextcle.com
cd ~/DO180-apps/php-helloworld
git add .
git status
lab openshift-s2i finish
lab openshift-webconsole start
cd ..
git status
git checkout master
git status
git checkout -b console
git push -u origin console
cat php-helloworld/index.php 
oc whoami --show-console 
cat /usr/local/etc/ocp4.config:
cat /usr/local/etc/ocp4.config
ls
nano php-helloworld/index.php 
git add php-helloworld/index.php 
git status
git commit -m 'changed'
git push
nano php-helloworld/index.php 
git commit --amend
git push --force
lab openshift-webconsole finish
lab multicontainer-openshift start
cd ~/DO180/labs/multicontainer-openshift/images/mysql
sudo podman build -t do180-mysql-57-rhel7 .
sudo podman login quay.io -u ${RHT_OCP4_QUAY_USER}
sudo podman tag  do180-mysql-57-rhel7 quay.io/${RHT_OCP4_QUAY_USER}/do180-mysql-57-rhel7
sudo podman images
sudo podman push  quay.io/${RHT_OCP4_QUAY_USER}/do180-mysql-57-rhel7
pwd
cd ../../../../labs/multicontainer-openshift/
cd images/nodejs/
sudo podman build --layers=false -t do180-nodejs .
cd ../../deploy/nodejs/
./build.sh 
sudo podman tag do180/todonodejs  quay.io/${RHT_OCP4_QUAY_USER}/do180-todonodejs
sudo podman push  quay.io/${RHT_OCP4_QUAY_USER}/do180-todonodejs
oc new-project ${RHT_OCP4_DEV_USER}-template
cd ../../../../labs/multicontainer-openshift/
oc new-app todo-template.json -p RHT_OCP4_QUAY_USER=${RHT_OCP4_QUAY_USER}
oc get pod
oc get pod -w
oc expose service todoapi 
curl -w "\n"  $(oc status | grep -o "http:.*com")/todo/api/items/1
lab multicontainer-openshift finish
cd
cd DO180-apps/
git status
git reset
git status
git reset --hard
git status
git checkout master
git log --graph --oneline --decorate --all
git checkout back
rm up/.bash_history 
git checkout back
cp ../.bash_history up/
git log --graph --oneline --decorate --all
git status
cp ../.bash_history up/
git status
history -a
cp ../.bash_history up/
git status
git commit -m 'day3'
git add .
git commit -m 'day3'
git push
git log --graph --oneline --decorate --all
clear

lab troubleshoot-s2i start
git status
git checkout master
git log --graph --oneline --decorate --all
git push origin master
git push origin master --force
git log --graph --oneline --decorate --all
git checkout -b troubleshoot-s2i
git push -u origin troubleshoot-s2i
oc whoami
oc new-project ${RHT_OCP4_DEV_USER}-nodejs
oc new-app --as-deployment-config --context-dir=nodejs-helloworld https://github.com/${RHT_OCP4_GITHUB_USER}/DO180-apps#troubleshoot-s2i -i nodejs:12 --name nodejs-hello --build-env npm_config_registry=http://${RHT_OCP4_NEXUS_SERVER}/repository/npm-proxy
oc get pod -w
oc logs nodejs-hello
oc logs bc/nodejs-hello
nano nodejs-helloworld/package.json 
git commit -am "Fixed Express release"
git push
git log --graph --oneline --decorate --all
oc start-build nodejs-hello 
oc logs bc/nodejs-hello
oc get pod
oc logs dc/nodejs-hello
nano nodejs-helloworld/package.json 
git commit -am "Added start up script"
git push
oc start-build nodejs-hello 
oc get pod
oc logs dc/nodejs-hello
oc expose svc/nodejs-hello
lab troubleshoot-s2i finish
lab troubleshoot-container start
cd ..
cd DO180
less labs/troubleshoot-container/conf/h
less labs/troubleshoot-container/conf/httpd.conf 
cd labs/troubleshoot-container/
sudo podman build -t troubleshoot-container .
history -a
cat /usr/local/etc/ocp4.config
git status
pwd
cd ~/DO180-apps
git status
git log --graph --oneline --decorate --all
git checkout back
git log
git push back
git push origin back
git log --graph --oneline --decorate --all
history -a
