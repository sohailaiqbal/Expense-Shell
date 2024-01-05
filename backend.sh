log_file=/tmp/expense.log
echo -e "\e[36mDISABLING NODEJS VERSION\e[0m"
dnf module disable nodejs -y &>>$log_file

echo -e "\e[36mENABLING NODEJS VERSION\e[0m"
dnf module enable nodejs:18 -y &>>$log_file

echo -e "\e[36mINSTALLING NODEJS VERSION\e[0m"
dnf install nodejs -y &>>$log_file

echo -e "\e[36mBACKEND SERVICE CONFIGURATION\e[0m"
cp backend.service /etc/systemd/system/backend.service &>>$log_file

echo -e "\e[36mADDING APPLICATION USER\e[0m"
useradd expense &>>$log_file

echo -e "\e[36mDELETING EXITING APP CONTENT\e[0m"
rm -rf /app &>>$log_file

echo -e "\e[36mCREATING APPLICATION DIRECTORY\e[0m"
mkdir /app &>>$log_file

echo -e "\e[36mDOWNLOADING APPLICATION CONTENT\e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>/tmp/expense.log

cd /app &>>$log_file

echo -e "\e[36mEXTRACTING APPLICATION CONTENT\e[0m"
unzip /tmp/backend.zip &>>$log_file

echo -e "\e[36mDOWNLOADING APPLICATION DEPENDENCIES\e[0m"
npm install &>>$log_file

echo -e "\e[36mRELOADING SYSTEM D ENABLE AND BACKEND SERVICE\e[0m"
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl restart backend &>>$log_file

echo -e "\e[36mINSTALLING MYSQL CLIENT\e[0m"
dnf install mysql -y &>>$log_file

echo -e "\e[36mLOADING SCHEMA\e[0m"
mysql -h mysql-dev.sidevops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file