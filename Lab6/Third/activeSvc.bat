@echo off
sc queryex type=service | findstr /r "SERVICE_NAME" > services.txt