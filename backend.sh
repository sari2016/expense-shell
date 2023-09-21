source common.sh
component=backend

echo Install NodeJS Repos
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$log_file

if [ $? -eq 0 ]; then
  echo SUCCESS
  else
    echo FAILED
    fi

    echo Install NodeJS
dnf install nodejs -y &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
  else
    echo FAILED
    fi

    echo copy Backend Service File
cp backend.service /etc/systemd/system/backend.service &>>$log_file

if [ $? -eq 0 ]; then
  echo SUCCESS
  else
    echo FAILED
    fi

echo Add Application User
useradd expense &>>$log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
  else
    echo FAILED
    fi
echo Clean App Content
rm -rf /app &>>$log_file
mkdir /app

echo Download App Content

curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>>$log_file
cd /app

echo Extract App Content
unzip /tmp/backend.zip &>>$log_file

echo Download Dependencies
cd /app
npm install &>>$log_file

echo Start Backend Service
systemctl daemon-reload &>>$log_file
systemctl enable backend &>>$log_file
systemctl start backend &>>$log_file

echo Install MYSQL Client
dnf install mysql -y
