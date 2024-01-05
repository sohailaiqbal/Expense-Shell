MYSQL_PASSWORD=$1
source common.sh

Head "INSTALLING NGINX"
dnf install nginx -y &>>$log_file
echo $?

Head "Copy Expense Config File"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$log_file
echo $?

Head "Enabling NGINX"
systemctl enable nginx &>>$log_file
echo $?

Head "STARTING NGINX"
systemctl start nginx
echo $?

Head "DELETING EXISTING CONTENT"
rm -rf /usr/share/nginx/html/* &>>$log_file
echo $?

Head "DOWNLOADING APPLICATION CODE"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip &>>$log_file
echo $?

cd /usr/share/nginx/html


unzip /tmp/frontend.zip &>>$log_file
echo $?
systemctl restart nginx &>>$log_file

echo $?
