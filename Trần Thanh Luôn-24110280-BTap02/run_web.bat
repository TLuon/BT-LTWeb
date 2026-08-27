@echo off
set JAVA_HOME=C:\Users\ADMIN\OneDrive\Desktop\BT-LTWeb\tools\jdk-21.0.2+13
set M2_HOME=C:\Users\ADMIN\OneDrive\Desktop\BT-LTWeb\tools\apache-maven-3.9.6
set TOMCAT_HOME=C:\Users\ADMIN\OneDrive\Desktop\BT-LTWeb\tools\apache-tomcat-11.0.0-M20
set PATH=%JAVA_HOME%\bin;%M2_HOME%\bin;%PATH%

echo 1. Dang bien dich va dong goi du an (Web)...
call mvn clean package

echo 2. Dang Deploy len Tomcat...
set WEBAPPS=%TOMCAT_HOME%\webapps

if exist "%WEBAPPS%\ROOT" (
    rmdir /S /Q "%WEBAPPS%\ROOT"
)
if exist "%WEBAPPS%\ROOT.war" (
    del /F /Q "%WEBAPPS%\ROOT.war"
)

copy /Y "target\btap02-1.0-SNAPSHOT.war" "%WEBAPPS%\ROOT.war"

echo 3. Khoi dong Tomcat Server...
cd /d "%TOMCAT_HOME%\bin"
catalina.bat run
