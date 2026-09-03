[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ErrorActionPreference = "Stop"

$workspace = "C:\Users\ADMIN\OneDrive\Desktop\BT-LTWeb"
$toolsDir = Join-Path $workspace "tools"

if (-not (Test-Path $toolsDir)) {
    New-Item -ItemType Directory -Path $toolsDir | Out-Null
}

Write-Host "1. Đang tải OpenJDK 21..."
$jdkUrl = "https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.2%2B13/OpenJDK21U-jdk_x64_windows_hotspot_21.0.2_13.zip"
$jdkZip = Join-Path $toolsDir "jdk.zip"
if (-not (Test-Path $jdkZip)) {
    Invoke-WebRequest -Uri $jdkUrl -OutFile $jdkZip
}
$jdkDir = Join-Path $toolsDir "jdk-21.0.2+13"
if (-not (Test-Path $jdkDir)) {
    Write-Host "Giải nén JDK 21..."
    Expand-Archive -Path $jdkZip -DestinationPath $toolsDir -Force
}

Write-Host "2. Đang tải Apache Maven 3.9..."
$mvnUrl = "https://archive.apache.org/dist/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.zip"
$mvnZip = Join-Path $toolsDir "maven.zip"
if (-not (Test-Path $mvnZip)) {
    Invoke-WebRequest -Uri $mvnUrl -OutFile $mvnZip
}
$mvnDir = Join-Path $toolsDir "apache-maven-3.9.6"
if (-not (Test-Path $mvnDir)) {
    Write-Host "Giải nén Maven..."
    Expand-Archive -Path $mvnZip -DestinationPath $toolsDir -Force
}

Write-Host "3. Đang tải Tomcat 11.0..."
$tomcatUrl = "https://archive.apache.org/dist/tomcat/tomcat-11/v11.0.0-M20/bin/apache-tomcat-11.0.0-M20.zip"
$tomcatZip = Join-Path $toolsDir "tomcat.zip"
if (-not (Test-Path $tomcatZip)) {
    Invoke-WebRequest -Uri $tomcatUrl -OutFile $tomcatZip
}
$tomcatDir = Join-Path $toolsDir "apache-tomcat-11.0.0-M20"
if (-not (Test-Path $tomcatDir)) {
    Write-Host "Giải nén Tomcat..."
    Expand-Archive -Path $tomcatZip -DestinationPath $toolsDir -Force
}

Write-Host "Thiết lập biến môi trường..."
$env:JAVA_HOME = $jdkDir
$env:PATH = "$jdkDir\bin;$($mvnDir)\bin;" + $env:PATH

Write-Host "Đang build project bằng Maven..."
Set-Location $workspace
mvn clean package

Write-Host "Đang deploy lên Tomcat..."
$warFile = Join-Path $workspace "target\bt-ltweb-1.0-SNAPSHOT.war"
$webappDir = Join-Path $tomcatDir "webapps"
$rootWar = Join-Path $webappDir "ROOT.war"

$rootFolder = Join-Path $webappDir "ROOT"
if (Test-Path $rootFolder) {
    Remove-Item -Recurse -Force $rootFolder
}

Copy-Item $warFile -Destination $rootWar -Force

Write-Host "Khởi động Tomcat Server ở port 8080..."
$startScript = Join-Path $workspace "run_server.bat"
$startScriptContent = @"
@echo off
set JAVA_HOME=$jdkDir
set PATH=%JAVA_HOME%\bin;%PATH%
cd /d "$tomcatDir\bin"
catalina.bat run
"@
Set-Content -Path $startScript -Value $startScriptContent

Write-Host "Đã xong! Project sẽ chạy qua run_server.bat"
