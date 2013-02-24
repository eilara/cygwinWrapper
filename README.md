cygwinWrapper
=============

Wrapper for running Cygwin shell commands from Windows.

Say you need to run a shell command (e.g. ssh foo@bar date), but from a
windows program, batch files, or DOS console.

You need to handle:

    - quoting and escaping, DOS issue are particularly interesting
    - path translation, from DOS paths using cygpath utility
    - biolerplate for calling shell, etc.

Or use cygwinWrapper:

  cygwinWrapper.bat --cygpath=2 c:\cygwin\bin\ls -la c:\

See batch file for some docs and an example.
~                                                                                        
