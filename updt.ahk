Sleep, 1000
newFile := A_Temp . "\atools.ahk"
URLDownloadToFile, %downlurl%, %a_temp%\nupdt.ahk
Sleep, 1000
Run, %A_AhkPath% "%a_temp%\nupdt.ahk"
Run, %A_AhkPath% "%newFile%"
ExitApp
