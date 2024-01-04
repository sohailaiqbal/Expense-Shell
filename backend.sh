echo DISABLING NODEJS VERSION
dnf module disable nodejs -y
dnf module enable nodejs:18 -y

echo INSTALLING NODEJS VERSION
dnf install nodejs -y

echo BACKEND SERVICE CONFIGURATION
cp backend.service /etc/systemd/system/backend.service

echo ADDING APPLICATION USER
useradd expense

echo DELETING EXITING APP CONTENT
rm -rf /app

echo CREATING APPLICATION DIRECTORY
mkdir /app

echo DOWNLOADING APPLICATION CONTENT
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip

cd /app

echo EXTRACTING APPLICATION CONTENT
unzip /tmp/backend.zip

echo DOWNLOADING APPLICATION DEPENDENCIES
npm install

echo RELOADING SYSTEM D ENABLE AND BACKEND SERVICE
systemctl daemon-reload
systemctl enable backend
systemctl restart backend

echo INSTALLING MYSQL CLIENT
dnf install mysql -y

echo LOADING SCHEMA
mysql -h mysql-dev.sidevops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql