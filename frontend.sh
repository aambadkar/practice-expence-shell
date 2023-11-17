dnf install nginx -y

systemctl enable nginx
systemctl start nginx
cp expense.conf /etc/nginx/default.d/expense.conf

curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip

cd /usr/share/nginx/html
unzip /tmp/frontend.zip

vim /etc/nginx/default.d/expense.conf


systemctl restart nginx