source common.sh

echo disable node js 10 version
dnf module disable nodejs -y >>$log_file
dnf module enable nodejs:18 -y >>$log_file

echo copy backend service file
cp backend.service /etc/systemd/system/backend.service >>$log_file

echo install nodeJS
dnf install nodejs -y >>$log_file

echo add application user
useradd expense >>$log_file

echo clean app contents
rm -rf /app >>$log_file
mkdir /app

echo download app contents
curl  -s -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip >>$log_file

cd /app

echo extract app data
unzip /tmp/backend.zip >>$log_file


echo download dependencies
npm install >>$log_file

echo start backend service
systemctl daemon-reload >>$log_file
systemctl enable backend >>$log_file
systemctl start backend >>$log_file

echo install mysql client
dnf install mysql -y >>$log_file

echo load the schema
mysql -h mysql.devopsa17.online -uroot -pExpenseApp@1 < /app/schema/backend.sql >>$log_file