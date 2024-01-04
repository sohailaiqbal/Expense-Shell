echo -e "\e[36mDISABLING NODEJS VERSION\e[0m"
dnf module disable nodejs -y &>>/tmp/expense.log

echo -e "\e[36mENABLING NODEJS VERSION\e[0m"
dnf module enable nodejs:18 -y &>>/tmp/expense.log

echo -e "\e[36mINSTALLING NODEJS VERSION\e[0m"
dnf install nodejs -y &>>/tmp/expense.log

echo -e "\e[36mBACKEND SERVICE CONFIGURATION\e[0m"
cp backend.service /etc/systemd/system/backend.service &>>/tmp/expense.log

echo -e "\e[36mADDING APPLICATION USER\e[0m"
useradd expense &>>/tmp/expense.log

echo -e "\e[36mDELETING EXITING APP CONTENT\e[0m"
rm -rf /app &>>/tmp/expense.log

echo -e "\e[36mCREATING APPLICATION DIRECTORY\e[0m"
mkdir /app &>>/tmp/expense.log

echo -e "\e[36mDOWNLOADING APPLICATION CONTENT\e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>/tmp/expense.log

cd /app &>>/tmp/expense.log

echo -e "\e[36mEXTRACTING APPLICATION CONTENT\e[0m"
unzip /tmp/backend.zip &>>/tmp/expense.log

echo -e "\e[36mDOWNLOADING APPLICATION DEPENDENCIES\e[0m"
npm install &>>/tmp/expense.log

echo -e "\e[36mRELOADING SYSTEM D ENABLE AND BACKEND SERVICE\e[0m"
systemctl daemon-reload &>>/tmp/expense.log
systemctl enable backend &>>/tmp/expense.log
systemctl restart backend &>>/tmp/expense.log

echo -e "\e[36mINSTALLING MYSQL CLIENT\e[0m"
dnf install mysql -y &>>/tmp/expense.log

echo -e "\e[36mLOADING SCHEMA\e[0m"
mysql -h mysql-dev.sidevops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>/tmp/expense.log