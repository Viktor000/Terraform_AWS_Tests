#!/bin/bash
yum -y update
yum -y install httpd

ip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
cat <<EOF > /var/www/html/index.html
<html>
<h1>WebServer IP: $ip</h1></br> 
Autobuild</br>
Owner: ${name}</br>
Userlist:</br>
<ol>
%{for x in names~}
<li>${x}</li> 
%{ endfor~}
</ol>
</html>
EOF

sudo service httpd restart
chkconfig httpd on