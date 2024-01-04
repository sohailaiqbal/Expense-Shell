
echo -e "\e[31mDISABLING NODEJS VERSION\e[0m"
dnf module disable nodejs -y
dnf module enable nodejs:18 -y >/tmp/expense.log

echo echo -e "\e[31mINSTALLING NODEJS VERSION\e[0m"
dnf install nodejs -y >/tmp/expense.log

echo -e "\e[31mBACKEND SERVICE CONFIGURATION\e[0m"
cp backend.service /etc/systemd/system/backend.service >/tmp/expense.log

echo -e "\e[31mADDING APPLICATION USER\e[0m"
useradd expense >/tmp/expense.log

echo -e "\e[31mDELETING EXITING APP CONTENT\e[0m"
rm -rf /app >/tmp/expense.log

echo -e "\e[31mCREATING APPLICATION DIRECTORY\e[0m"
mkdir /app >/tmp/expense.log

echo -e "\e[31mDOWNLOADING APPLICATION CONTENT\e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip >/tmp/expense.log

cd /app >/tmp/expense.log

echo -e "\e[31mEXTRACTING APPLICATION CONTENT\e[0m"
unzip /tmp/backend.zip >/tmp/expense.log

echo -e "\e[31mDOWNLOADING APPLICATION DEPENDENCIES\e[0m"
npm install >/tmp/expense.log

echo -e "\e[31mRELOADING SYSTEM D ENABLE AND BACKEND SERVICE\e[0m"
systemctl daemon-reload >/tmp/expense.log
systemctl enable backend >/tmp/expense.log
systemctl restart backend >/tmp/expense.log

echo -e "\e[31mINSTALLING MYSQL CLIENT\e[0m"
dnf install mysql -y >/tmp/expense.log

echo -e "\e[31mLOADING SCHEMA\e[0m"
mysql -h mysql-dev.sidevops.online -uroot -pExpenseApp@1 < /app/schema/backend.sql >/tmp/expense.log