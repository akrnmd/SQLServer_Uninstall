function exec-uninstall  
{  
    $keys|ForEach-Object{  
        $dispname = (Get-Item -Path "Registry::$_").GetValue("DisplayName");  
        $words = $_.ToString().Split("\")  
        $word = $words[$words.Length - 1]  
        if ($dispname -ne $null -and $dispname.IndexOf("SQL") -ge 0 -and $word.Substring(0,1) -eq "{" -and $dispname.IndexOf("SQLite") -lt 0) {  
            $executecommand = "msiexec"  
            $executecommandparameter = "/x " + $word  
            Start-Process -FilePath $executecommand -ArgumentList $executecommandparameter -Wait  
        }  
    }  
}  
  
$keys = (Get-Item -Path "Registry::HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*") | Select-String "Uninstall"  
  
exec-uninstall  
  
$keys = (Get-Item -Path "Registry::HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*") | Select-String "Uninstall"  

exec-uninstall
