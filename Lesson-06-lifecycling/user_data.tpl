#!/bin/bash
yum -y update
yum -y install httpd



cat <<EOF > /var/www/html/index.html
<html>
<h2>Build by Power of Terraform </h2><br>
Owner ${f_name} ${l_name} <br>

%{ for x in names ~}
Hello to ${x} from ${f_name}<br>
%{ endfor ~}

<p>
Done! <br>

</html>
EOF

sudo service httpd start
chkconfig httpd on
