MYSQL_PASSWORD=$1
source common.sh

Head "DISABLING NODEJS VERSION"
dnf module disable nodejs -y &>>$log_file
echo $?

Head "ENABLING NODEJS VERSION"
dnf module enable nodejs:18 -y &>>$log_file
echo $?

Head "INSTALLING NODEJS VERSION"
dnf install nodejs -y &>>$log_file
echo $?

Head "BACKEND SERVICE CONFIGURATION"
cp backend.service /etc/systemd/system/backend.service &>>$log_file
echo $?

Head "ADDING APPLICATION USER"
useradd expense &>>$log_file
echo $?

Head "DELETING EXITING APP CONTENT"
rm -rf /app &>>$log_file
echo $?

Head "CREATING APPLICATION DIRECTORY"
mkdir /app &>>$log_file
echo $?

Head "DOWNLOADING APPLICATION CONTENT"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>/tmp/expense.log
echo $?

cd /app &>>$log_file
echo $?

Head "EXTRACTING APPLICATION CONTENT"
unzip /tmp/backend.zip &>>$log_file
echo $?

Head "DOWNLOADING APPLICATION DEPENDENCIES"
npm install &>>$log_file
echo $?

Head "RELOADING SYSTEM D ENABLE AND BACKEND SERVICE"
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl restart backend &>>$log_file
echo $?

Head "INSTALLING MYSQL CLIENT"
dnf install mysql -y &>>$log_file
echo $?

Head "LOADING SCHEMA"
mysql -h mysql-dev.sidevops.online -uroot -p${MYSQL_PASSWORD} < /app/schema/backend.sql &>>$log_file
echo $?