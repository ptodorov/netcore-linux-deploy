@echo off

set PrivateKeyLocation="C:\Users\Panayot\Documents\linux_amazon.ppk"
set CertificateFileLocation="/mnt/c/Users/Panayot/Documents/linux_amazon.pem"

for %%* in (.) do set CurrentDirName=%%~nx*
set OutputFolder="%tmp%\%CurrentDirName%"
set OutputZipFile="%tmp%\%CurrentDirName%.zip"
set RemoteHost="ubuntu@54.154.115.137"
set RemoteLocation="/home/ubuntu"

dotnet restore
dotnet publish -o "%OutputFolder%"

powershell -command "& {&'Compress-Archive' -Path %OutputFolder% -DestinationPath %OutputZipFile%}"
rmdir /s /q %OutputFolder%

pscp -i %PrivateKeyLocation% -pw 4ubakatA %OutputZipFile% %RemoteHost%:%RemoteLocation%
del /q %OutputZipFile%

bash -c "ssh -i %CertificateFileLocation% %RemoteHost% 'sudo rm -rf %CurrentDirName% ; unzip %CurrentDirName%.zip ; rm -r %CurrentDirName%.zip ; sudo service supervisor restart'"

pause