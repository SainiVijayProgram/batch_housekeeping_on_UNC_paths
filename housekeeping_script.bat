@echo off

REM ******************************************************
REM *******Developed By: Vijay Saini******************
REM *******Date: 12th Sept 2016***********************
REM *******Purpose:  To delete the files older then the defined no of days(recursively).
REM ******************************************************
REM ********Modified on: 24th October 2016
REM ********Covered: Executable on UNC paths
REM ******************************************************


SET BATCH_HOME=C:\admin\scripts

REM *If Multiple locations, keep it comma seperated without any spaces
SET TARGET_LOCATIONS=\\server_name.hosted.local\bostonmarket\XMLFiles\1000001,\\server_name.hosted.local\bte\xmlfiles

SET DELETE_OLDER_THEN=15
SET LOG_NAME=housekeeping

echo Started Deleting file older then %DELETE_OLDER_THEN% Days Today on %DATE% at %TIME% >> %BATCH_HOME%\%LOG_NAME%.log
echo ******************************************************>> %BATCH_HOME%\%LOG_NAME%.log
echo ******************************************************>> %BATCH_HOME%\%LOG_NAME%.log

for %%a in ("%TARGET_LOCATIONS:,=" "%") do (
		
		
	PushD "%%a" &&(
		echo List of files which are getting deleted at location %%a at %DATE%, %TIME% >> %BATCH_HOME%\%LOG_NAME%.log
		echo ******************************************************>> %BATCH_HOME%\%LOG_NAME%.log
		
		forfiles -s -m *.* -d -%DELETE_OLDER_THEN% -c "cmd /c echo @path " >> %BATCH_HOME%\%LOG_NAME%.log
		
		echo **********Ececuting Delete Operation********>> %BATCH_HOME%\%LOG_NAME%.log
		forfiles -p %%a -s -m *.* /D -%DELETE_OLDER_THEN% /C "cmd /c del @path"  >>%BATCH_HOME%\%LOG_NAME%.log
	
		rem forfiles -s -m *.* -d -7 -c "cmd /c echo @path " >> %BATCH_HOME%\%LOG_NAME%.log
		
     ) & PopD
	 
			
)

echo **Delete Job complete successfully*******>> %BATCH_HOME%\%LOG_NAME%.log

endlocal

