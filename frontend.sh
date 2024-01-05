component=frontend
source common.sh

Head "INSTALLING NGINX"
dnf install nginx -y &>>$log_file
echo $?

Head "Copy Expense Config File"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
echo $?

App_Prereq "/usr/share/nginx/html"


Head "STARTING NGINX SERVICE"
systemctl enable  nginx &>>$log_file
systemctl restart nginx &>>$log_file
echo $?
