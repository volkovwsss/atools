newScriptUrl := "https://raw.githubusercontent.com/volkovwsss/atools/main/atools.ahk"
target := A_ScriptDir . "\atools.ahk"

URLDownloadToFile, %newScriptUrl%, %target%
Sleep, 500

Run, %A_AhkPath% "%target%"
ExitApp
