source common.sh
component=backend

echo install nodejs repo
curl -sL https://rpm.nodesource.com/setup_lts.x | bash >>$log_file
if [ $? -eq 0 ]; then
   echo -e "\e[32mSUCCESS\e[0m"
else
   echo -e "\e[31mSUCCESS\e[0m"
fi
#echo disable node js 10 version
#dnf module disable nodejs -y >>$log_file
#dnf module enable nodejs:18 -y >>$log_file
#if [ $? -eq 0 ]; then
   #echo SUCCESS
#else
   #echo FAILED
#fi


echo install nodeJS
dnf install nodejs -y >>$log_file
if [ $? -eq 0 ]; then
   echo -e "\e[32mSUCCESS\e[0m"
else
   echo -e "\e[31mSUCCESS\e[0m"
fi

echo copy backend service file
cp backend.service /etc/systemd/system/backend.service >>$log_file
if [ $? -eq 0 ]; then
   echo -e "\e[32mSUCCESS\e[0m"
else
   echo -e "\e[31mSUCCESS\e[0m"
fi


echo add application user
useradd expense >>$log_file
if [ $? -eq 0 ]; then
   echo -e "\e[32mSUCCESS\e[0m"
else
   echo -e "\e[31mSUCCESS\e[0m"
fi

echo clean app contents
rm -rf /app >>$log_file
if [ $? -eq 0 ]; then
   echo -e "\e[32mSUCCESS\e[0m"
else
   echo -e "\e[31mSUCCESS\e[0m"
fi

mkdir /app
cd /app

download_and_extract


echo download dependencies
npm install &>>$log_file
if [ $? -eq 0 ]; then
   echo -e "\e[32mSUCCESS\e[0m"
else
   echo -e "\e[31mSUCCESS\e[0m"
fi

echo start backend service
systemctl daemon-reload >>$log_file
systemctl enable backend >>$log_file
systemctl start backend >>$log_file
if [ $? -eq 0 ]; then
   echo -e "\e[32mSUCCESS\e[0m"
else
   echo -e "\e[31mSUCCESS\e[0m"
fi

echo install mysql client
dnf install mysql -y >>$log_file
if [ $? -eq 0 ]; then
   echo -e "\e[32mSUCCESS\e[0m"
else
   echo -e "\e[31mSUCCESS\e[0m"
fi

echo load the schema
mysql -h mysql.devopsa17.online -uroot -pExpenseApp@1 < /app/schema/backend.sql >>$log_file
iif [ $? -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
 else
    echo -e "\e[31mSUCCESS\e[0m"
 fi