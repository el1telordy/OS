sc stop WSearch
TIMEOUT /T 5 /NOBREAK
sc queryex type=service | findstr /r "SERVICE_NAME" > C:\Lab6\Third\updatedServices.txt
call C:\Lab6\Third\diff.bat
sc start WSearch
Pause