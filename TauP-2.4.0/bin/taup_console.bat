@echo off
set APPDIR=%~dp0
set CMD_LINE_ARGS=%1
shift
:getArgs
if " "%1" "==" "" " goto doneArgs
set CMD_LINE_ARGS=%CMD_LINE_ARGS% %1
shift
goto getArgs
:doneArgs

if "%JAVA%"=="" set JAVA=java
if "%TAUP_HOME%"=="" GOTO FIND
echo TAUP_HOME is no longer used and will be ignored
:FIND
PUSHD %APPDIR%
cd ..
set TAUP_HOME=%CD%
POPD

set LIB=%TAUP_HOME%\lib

set TAUP=%LIB%\TauP-2.4.0.jar
set SEISFILE=%LIB%\seisFile-1.7.1.jar
set JYTHONSTANDALONE=%LIB%\jython-standalone-2.5.3.jar
set SEEDCODEC=%LIB%\seedCodec-1.0.11.jar
set JSAP=%LIB%\jsap-2.1.jar
set SLF4JAPI=%LIB%\slf4j-api-1.7.21.jar
set SLF4JLOG4J12=%LIB%\slf4j-log4j12-1.7.21.jar
set RXTX=%LIB%\rxtx-2.1.7.jar
set WOODSTOXCORELGPL=%LIB%\woodstox-core-lgpl-4.4.1.jar
set MSVCORE=%LIB%\msv-core-2013.6.1.jar
set HTTPCLIENT=%LIB%\httpclient-4.5.2.jar
set MYSQLCONNECTORJAVA=%LIB%\mysql-connector-java-5.1.39.jar
set LOG4J=%LIB%\log4j-1.2.17.jar
set STAXAPI=%LIB%\stax-api-1.0-2.jar
set STAX2API=%LIB%\stax2-api-3.1.4.jar
set XSDLIB=%LIB%\xsdlib-2013.6.1.jar
set ISORELAX=%LIB%\isorelax-20090621.jar
set HTTPCORE=%LIB%\httpcore-4.4.4.jar
set COMMONSLOGGING=%LIB%\commons-logging-1.2.jar
set COMMONSCODEC=%LIB%\commons-codec-1.9.jar
set RELAXNGDATATYPE=%LIB%\relaxngDatatype-20020414.jar


if EXIST "%TAUP%" GOTO LIBEND
echo %TAUP% doesn't exist
echo TAUP requires this file to function.  It should be in the lib dir
echo parallel to the bin directory to this script in the filesystem.
echo If it seems like the lib dir is there, email sod@seis.sc.edu for help
GOTO END
:LIBEND
    
set CLASSPATH=%TAUP%;%SEISFILE%;%JYTHONSTANDALONE%;%SEEDCODEC%;%JSAP%;%SLF4JAPI%;%SLF4JLOG4J12%;%RXTX%;%WOODSTOXCORELGPL%;%MSVCORE%;%HTTPCLIENT%;%MYSQLCONNECTORJAVA%;%LOG4J%;%STAXAPI%;%STAX2API%;%XSDLIB%;%ISORELAX%;%HTTPCORE%;%COMMONSLOGGING%;%COMMONSCODEC%;%RELAXNGDATATYPE%

%JAVA% -classpath %CLASSPATH%   -Xmx512m    edu.sc.seis.TauP.TauP_Console  %CMD_LINE_ARGS%
:END
