@echo off
set JAVA_HOME=C:\Users\ADMIN\OneDrive\Desktop\BT-LTWeb\tools\jdk-21.0.2+13
set M2_HOME=C:\Users\ADMIN\OneDrive\Desktop\BT-LTWeb\tools\apache-maven-3.9.6
set PATH=%JAVA_HOME%\bin;%M2_HOME%\bin;%PATH%

echo Dang tai thu vien va bien dich du an...
call mvn clean compile

echo.
echo Dang chay file Test.java de insert vao SQL Server...
call mvn exec:java -Dexec.mainClass="vn.iotstar.config.Test"

echo.
pause
