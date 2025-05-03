Sleep, 1000
newFile := A_Temp . "\atools.exe"
URLDownloadToFile, https://github.com/volkovwsss/atools/raw/main/atools.exe, %newFile%
Sleep, 1000
FileCopy, %newFile%, %A_ScriptDir%\atools.exe, 1
Run, %A_ScriptDir%\atools.exe
ExitApp
