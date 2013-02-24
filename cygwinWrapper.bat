
@echo off

set PERL_WRAPPER=/bin/cygwinWrapper.pl
set DOS_SCRIPTPATH=
set SCRIPTPATH=
set DOS_CYGBINDIR=
set DOS_ZSHEXE=
set CYGPATH_SPEC=

:: escaping: use \\\ for escaping " in args to command
::           use '$'\''' for escaping '
::           args with \ must be quoted with '
::           args with space must be quoted with '
::           use "," (double quotes) to escape , and =
::           use ^^^^ for escaping ^
::           use ^ to escape >,<, and &

:: e.g.
:: cmd /c cygwinWrapper.bat --cygpath=4:5 c:\cygwin\tmp\foo.zsh sadf sdf  '1\2^^^^3\\\"2'$'\'''3^&4 5^&6' 'c:\n' 'd:\a\b\c\xx.sdf'
::                                                              ARG1 ARG2 ARG3                            ARG4   ARG5
::
:: note: do NOT quote the script/command executable path

:: in form: --cygpath=A:B:C.. where A B C are param indexes, starting from 1
:: e.g. --cygpath=1:3 will convert from Windows to Cygwin paths the 1st and
:: 3rd params
:: required argument, set to --cygpath=0 for no convertion
:: script path is always converted to cygwin path
::
:: example:
::
:: cygwinWrapper.bat --cygpath=4
::      %system.mt.BuildScriptsDir%\compose_config_files.zsh
::      -name SomeName
::      -path c:\foo\bar
::      -values xyz
::      -environments 'production:staging:testing:dev'
::      -regions 'foo:bar'


set CYGPATH_SPEC=%2

:: CYGBIN is cygwin bin dir in DOS format
set DOS_CYGBINDIR=C:\cygwin\bin

:: 1st arg is script path in DOS format, it must exist
set DOS_SCRIPTPATH=%3 
for /f "delims=" %%A in ('%DOS_CYGBINDIR%\cygpath.exe "%DOS_SCRIPTPATH%"') do set SCRIPTPATH=%%A

:: ZSHEXE is full path in DOS format to zsh executable
set DOS_ZSHEXE=%DOS_CYGBINDIR%\zsh.exe

set ARG1=%4 & set ARG2=%5 & set ARG3=%6 & set ARG4=%7 & set ARG5=%8 & set ARG6=%9
shift       & shift       & shift       & shift       & shift       & shift 
shift       & shift       & shift

%DOS_ZSHEXE% -l -c "%PERL_WRAPPER% %SCRIPTPATH% %CYGPATH_SPEC% %ARG1% %ARG2% %ARG3% %ARG4% %ARG5% %ARG6% %1 %2 %3 %4 %5 %6 %7 %8 %9"
if ERRORLEVEL 1 goto ExitFailLabel
goto ExitOkLabel

:ExitFailLabel
echo Failed running command through cygwinWrapper.bat
exit 2

:ExitOkLabel
echo cygwinWrapper.bat complete
exit 0
