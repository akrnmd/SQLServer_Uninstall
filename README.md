# SQLServer_Uninstall
Uninstall SQLServer completely.

[refer](http://kaz827.blog.fc2.com/blog-entry-22.html)

1.Save "setup.ps1" and "setup.bat" in the same directory.

2.Run "setup.bat".  
Note. Running this batch file may uninstall another application not involved.  
Example: sqlite3

3.Delete if there is a key containing "Microsoft SQL" or "MSSQL" under the followings.  
  - HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft  
  - HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft


