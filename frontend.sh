echo installing nginx
dnf install nginx -y >>/tmp/expense.log


echo copy expense config file in nginx
cp expense.conf /etc/nginx/default.d/expense.conf >>/tmp/expense.log

echo remove old nginx content
rm -rf /user/share/nginx/html/* >>/tmp/expense.log

echo download frontend code
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip >>/tmp/expense.log

cd /usr/share/nginx/html

echo extracting frontend code
unzip /tmp/frontend.zip >>/tmp/expense.log


echo start nginx service
systemctl enable nginx >>/tmp/expense.log
systemctl restart nginx >>/tmp/expense.log