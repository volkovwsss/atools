; <COMPILER: v1.1.36.02>
Menu, Tray, NoStandard
Menu, Tray, Add, Help
Menu, Tray, Rename, Help, Технічна підтримка
Menu, Tray, Add
Menu, Tray, Add
Menu, Tray, Add, Reload
Menu, Tray, Rename, Reload, Перезапуск
Menu, Tray, Add
Menu, Tray, Add, GuiClose
Menu, Tray, Rename, GuiClose, Вихід

TrayTip, Atools, Загрузка...
IfExist, %A_ScriptDir%\config.ini
Gosub, ReadSettings
Version := 8.0
Ranks := ["Ігровий помічник","Модератор","Ст. Модератор","Адміністратор","Ст. Адміністратор","Зам.ГА","Головний Адміністратор","Керівник"]
Servers := ["Центральна Україна","Західна Україна","Східна Україна","Північна Україна","Південна Україна","Подільский Край"]
Gui +LastFound
Gui, Font, S10 CDefault, Verdana
CustomColor3 = 6A9AB6
WinSet, TransColor, %CustomColor3% 250
buildscr = 65
downlurl := "https://github.com/volkovwsss/atools/blob/main/updt.ahk"
downllen := "https://raw.githubusercontent.com/volkovwsss/atools/main/newupdate.ini"
Utf8ToAnsi(ByRef Utf8String, CodePage = 1251)
{
If (NumGet(Utf8String) & 0xFFFFFF) = 0xBFBBEF
BOM = 3
Else
BOM = 0
UniSize := DllCall("MultiByteToWideChar", "UInt", 65001, "UInt", 0
, "UInt", &Utf8String + BOM, "Int", -1
, "Int", 0, "Int", 0)
VarSetCapacity(UniBuf, UniSize * 2)
DllCall("MultiByteToWideChar", "UInt", 65001, "UInt", 0
, "UInt", &Utf8String + BOM, "Int", -1
, "UInt", &UniBuf, "Int", UniSize)
AnsiSize := DllCall("WideCharToMultiByte", "UInt", CodePage, "UInt", 0
, "UInt", &UniBuf, "Int", -1
, "Int", 0, "Int", 0
, "Int", 0, "Int", 0)
VarSetCapacity(AnsiString, AnsiSize)
DllCall("WideCharToMultiByte", "UInt", CodePage, "UInt", 0
, "UInt", &UniBuf, "Int", -1
, "Str", AnsiString, "Int", AnsiSize
, "Int", 0, "Int", 0)
Return AnsiString
}
Say(text)
{
SendInput,{е}
Sleep 100
SendInput,%text%{enter}
}
SayNoEnter(text)
{
SendInput,{е}
Sleep 100
SendInput,%text%
}
Gui, Margin, 10, 10
Gui +LastFound
Gui, Color, 000000
Gui, Font, s10
Gui, Font, cWhite
WinSet, TransColor, %CustomColor3% 200
Gui, Add, GroupBox, x10 y10 w280 h50, Автооновлення
Gui, Add, Text, x20 y30 w240 h20 Center, Запуск скрипта. Очікуйте..
Gui, Show, AutoSize, Автооновлення.
Sleep, 1500
URLDownloadToFile, %downllen%, %a_temp%/newupdate.ini
IniRead, buildupd, %a_temp%/newupdate.ini, UPD, build
if buildupd =
{
GuiControl, Hide, Автооновлення
Gui, Add, GroupBox, x10 y10 w280 h50, Автооновлення
Gui, Add, Text, x20 y30 w240 h20 Center, Запуск скрипта. Очікуйте..
Gui, Add, Text, x20 y50 w240 h20 Center, Помилка. Немає звязку з сервером.
GuiControl, Hide, Автооновлення
Gui, Show, AutoSize, Автооновлення
Sleep, 2000
Gui, Destroy
return
}
if buildupd > %buildscr%
{
IniRead, vupd, %a_temp%/newupdate.ini, UPD, v
filePath := a_temp . "\newupdate.ini"
file := FileOpen(filePath, "r", "UTF-8")
if !IsObject(file) {
    MsgBox, Помилка: Не вдалося зєднатись з грою. Можливо ви не вибрали папку UKRAINE GTA, натисніть кнопку "Вибрати папку UGTA".
    return
}
fileContent := file.Read()
file.Close()
desupd := ""
Loop, parse, fileContent, `n
{
if RegExMatch(A_LoopField, "^des=(.*)$", outputtt)
{
desupd := outputtt1
}
}
GuiControl, Hide, Автооновлення.
Gui, Add, GroupBox, x10 y10 w280 h220, Доступне оновлення
Gui, Add, Text, x20 y30 w240 h20 Center, Рекомендуємо оновити ATools
Gui, Add, Text, x20 y50 w240 h20 Center, до версії %vupd%.
Gui, Add, Edit,  w260 h100 ReadOnly +Wrap Center, %desupd%
GuiControl, Move, Edit1,  y80 w260 h100 Center
Gui, Add, Button, x20 y190 w120 h30 gUpdateScript, Да
Gui, Add, Button, x160 y190 w120 h30 gSkipUpdate, Ні
GuiControl, Hide, Автооновлення
Gui, Show, AutoSize, Доступне оновлення
return
}
Gui, Destroy
UpdateScript:
if buildupd > %buildscr%
{
put2 := % A_ScriptFullPath
RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\UAGTA ,put2 , % put2
URLDownloadToFile, %downlurl%, %a_temp%/nupdt.exe
Sleep, 1000
Run, %a_temp%/nupdt.exe
ExitApp
}
SkipUpdate:
Gui, Destroy
FileReadLine, filePath, road.ini, 1
checkboxState := 0
Gui, Font, cWhite
Gui, Add, Tab, x2 y-1 w1360 h540 , Загальні налаштування |Налаштування команд |Налаштування репортів 01 |Налаштування репортів 02 |Видати покарання
Gui, Add, Text, x22 y40 w220 h25 , NickName
Gui, Add, Text, x22 y79 w220 h25 , Рівень адміністратора
Gui, Add, Text, x22 y119 w220 h25 , Сервер
Gui, Font, cBlack
Gui, Add, Edit, x200 y40 w230 h25 vName, %Name%
Gui, Font, cWhite
Gui, Add, DropDownList, AltSubmit vnRank x200 y79 w230 , Ігровий помічник|Модератор|Ст. Модератор|Адміністратор|Ст. Адміністратор|Зам.ГА|Головний Адміністратор|Керівник
Gui, Add, DropDownList, AltSubmit vnServer x200 y119 w230 , Центральна Україна|Західна Україна|Східна Україна|Північна Україна|Підвенна Україна|Подільский Край
Gui, Add, Button, x445 y40 w215 h100 gSaveGen, Зберегти

; Меню "Підказки\Налаштування"
Gui, Add, GroupBox, x445 y160 w215 h220, Підказки\Налаштування
Gui, Add, Button, x450 y180 w200 h30 gSelectFolder, Виберіть папку UGTA
Gui, Add, Button, x450 y220 w200 h30 gGreenZone, Карта ЗЗ
Gui, Add, Button, x450 y260 w200 h30 gAdminH, Адм.команди
Gui, Add, Button, x450 y295 w200 h30 gToggleMusic vToggleMusicButton, Гімн тестерів

Gui, Add, GroupBox, x238 y160 w190 h220, Додаткий функціонал
Gui, Add, CheckBox, x245 y180 w170 h23 vCheckboxChecked gToggleF2, Принятие адм.форм на F2
Gui, Add, CheckBox, x245 y200 w170 h23 gwhitelist, Підсказки
Gui, Add, CheckBox, x245 y220 w170 h23 vCheckboxChecked2 gToggleF3, AutoID PM на F3
Gui, Add, CheckBox, x245 y240 w170 h23 gCheckboxToggle  , Включити додаткові команди
Gui, Add, CheckBox, x245 y260 w170 h23 vCheckboxChecked3 gToggleReport, Відповісти на репорти [BETA]
Gui, Add, CheckBox, x245 y280 w170 h23 vCheckboxChecked4 gToggleachat, Включити адмінчат
Gui, Add, GroupBox, x10 y160 w220 h220, Підключення на сервера
Gui, Add, Button, x12 y180 w95 h30 gtest1, Тестовий
Gui, Add, Button, x117 y180 w95 h30 gLaunchUKRAINEGTA, Лаунчер
Gui, Add, Button, x10 y220 w200 h23 gserver1, Центральна Україна 01
Gui, Add, Button, x10 y250 w200 h23 gserver2, Західна Україна 02
Gui, Add, Button, x10 y280 w200 h23 gserver3, Східна Україна 03
Gui, Add, Button, x10 y310 w200 h23 gserver4, Північна Україна 04
Gui, Add, Button, x10 y340 w200 h23 gserver5, Південна Україна 05
Gui, Add, Button, x10 y370 w200 h23 gserver6, Подільський Край 06
GuiControl, Move, Підключення на сервера, xCenter y160 w220 h245
musicEnabled := false
Gui, Add, Text, x12 y549 w1110 h25 , Admin Tools 01 server ♡ v %Version%. З любов'ю для адміністрації UKRAINE GTA ♡
Gui, Tab, Загальні налаштування
Gui, Add, Text, x12 y420 w550 h25 , Загальне:
Gui, Add, Text, x12 y435 w550 h25 , AdminTools після змін команд\репортів необхідно перезапускати
Gui, Add, Text, x12 y450 w550 h25 , AdminTools обовязково повиний бути запущенний від імені адміністратора
Gui, Add, Text, x12 y465 w550 h25 , ALT+R - дана комбінація одразу зайнята вкладкою "Видати покарання"
Gui, Add, Text, x12 y480 w550 h25 , Після першого запуску створюється файл .ini в папці зі скриптом, не удаляйте його, це ваші настройки!!!
Gui, Add, Text, x12 y495 w550 h25 , Блащина шаманив
TempImagePath1 := A_Temp . "\ugta.png"
FileInstall, C:\Users\YevheniiPichkur\OneDrive - EWL\Pulpit\1.png, %TempImagePath1%
Gui, Add, Picture, x700 y110 w410 h410, %TempImagePath1%
Gui, Add, button, x5 y510 w130 h25 gnormaAdmin, Норма адмінів 01
Gui, Add, button, x145 y510 w130 h25 gposibnik, Посібник Адміністратора
Gui, Add, Link, x950 y55, Правила видачі покарання <a href="https://forum.ukraine-gta.com.ua/threads/Правила-ukraine-gta.209016/">Форум</a>
Gui, Add, Link, x950 y70, Список скінів 5+ <a href="https://docs.google.com/document/d/1CfnVD1Mpq9m2ZIH9j7dstP8jAFl-Llfpgy8KUA5A3Vo/edit?tab=t.0">Google Таблиці</a>
Gui, Add, Link, x950 y85, Список авто 5+ <a href="https://docs.google.com/document/d/1uAnAJYImjZj_P2QXctAayKstJNiSJZgKqnoctO5YVjM/edit?tab=t.0">Google Таблиці</a>
Gui, Tab, Налаштування команд
Gui, Add, Text, x12 y69 w210 h25 , Команда
Gui, Add, Text, x232 y69 w150 h25 , Кнопка
Gui, Add, Text, x392 y69 w210 h25 , Команда
Gui, Add, Text, x612 y69 w150 h25 , Кнопка
Gui, Add, Text, x772 y69 w210 h25 , Команда
Gui, Add, Text, x992 y69 w150 h25 , Кнопка
Gui, Tab, Налаштування команд
Gui, Add, Text, x12 y549 w1130 h25 , Admin Tools 01 server ♡ v %Version%. З любов'ю для адміністрації UKRAINE GTA ♡
Gui, Font, cBlack
Gui, Add, Edit, x12 y99 w210 h25 vCom0, %Com0%
Gui, Add, Edit, x12 y139 w210 h25 vCom1, %Com1%
Gui, Add, Edit, x12 y179 w210 h25 vCom2, %Com2%
Gui, Add, Edit, x12 y219 w210 h25 vCom3, %Com3%
Gui, Add, Edit, x12 y259 w210 h25 vCom4, %Com4%
Gui, Add, Edit, x12 y299 w210 h25 vCom5, %Com5%
Gui, Add, Edit, x12 y339 w210 h25 vCom6, %Com6%
Gui, Add, Edit, x12 y379 w210 h25 vCom7, %Com7%
Gui, Add, Edit, x12 y419 w210 h25 vCom8, %Com8%
Gui, Add, Edit, x12 y459 w210 h25 vCom9, %Com9%
Gui, Add, Edit, x392 y99 w210 h25 vCom10, %Com10%
Gui, Add, Edit, x392 y139 w210 h25 vCom11, %Com11%
Gui, Add, Edit, x392 y179 w210 h25 vCom12, %Com12%
Gui, Add, Edit, x392 y219 w210 h25 vCom13, %Com13%
Gui, Add, Edit, x392 y259 w210 h25 vCom14, %Com14%
Gui, Add, Edit, x392 y299 w210 h25 vCom15, %Com15%
Gui, Add, Edit, x392 y339 w210 h25 vCom16, %Com16%
Gui, Add, Edit, x392 y379 w210 h25 vCom17, %Com17%
Gui, Add, Edit, x392 y419 w210 h25 vCom18, %Com18%
Gui, Add, Edit, x392 y459 w210 h25 vCom19, %Com19%
Gui, Add, Edit, x772 y99 w210 h25 vCom20, %Com20%
Gui, Add, Edit, x772 y139 w210 h25 vCom21, %Com21%
Gui, Add, Edit, x772 y179 w210 h25 vCom22, %Com22%
Gui, Add, Edit, x772 y219 w210 h25 vCom23, %Com23%
Gui, Add, Edit, x772 y259 w210 h25 vCom24, %Com24%
Gui, Add, Edit, x772 y299 w210 h25 vCom25, %Com25%
Gui, Add, Edit, x772 y339 w210 h25 vCom26, %Com26%
Gui, Add, Edit, x772 y379 w210 h25 vCom27, %Com27%
Gui, Add, Edit, x772 y419 w210 h25 vCom28, %Com28%
Gui, Add, Edit, x772 y459 w210 h25 vCom29, %Com29%
Gui, Add, Hotkey, x232 y99 w150 h25 vKeys0 gSaveKeys0, %Keys0%
Gui, Add, Hotkey, x232 y139 w150 h25 vKeys1 gSaveKeys1, %Keys1%
Gui, Add, Hotkey, x232 y179 w150 h25 vKeys2 gSaveKeys2, %Keys2%
Gui, Add, Hotkey, x232 y219 w150 h25 vKeys3 gSaveKeys3, %Keys3%
Gui, Add, Hotkey, x232 y259 w150 h25 vKeys4 gSaveKeys4, %Keys4%
Gui, Add, Hotkey, x232 y299 w150 h25 vKeys5 gSaveKeys5, %Keys5%
Gui, Add, Hotkey, x232 y339 w150 h25 vKeys6 gSaveKeys6, %Keys6%
Gui, Add, Hotkey, x232 y379 w150 h25 vKeys7 gSaveKeys7, %Keys7%
Gui, Add, Hotkey, x232 y419 w150 h25 vKeys8 gSaveKeys8, %Keys8%
Gui, Add, Hotkey, x232 y459 w150 h25 vKeys9 gSaveKeys9, %Keys9%
Gui, Add, Hotkey, x612 y99 w150 h25 vKeys10 gSaveKeys10, %Keys10%
Gui, Add, Hotkey, x612 y139 w150 h25 vKeys11 gSaveKeys11, %Keys11%
Gui, Add, Hotkey, x612 y179 w150 h25 vKeys12 gSaveKeys12, %Keys12%
Gui, Add, Hotkey, x612 y219 w150 h25 vKeys13 gSaveKeys13, %Keys13%
Gui, Add, Hotkey, x612 y259 w150 h25 vKeys14 gSaveKeys14, %Keys14%
Gui, Add, Hotkey, x612 y299 w150 h25 vKeys15 gSaveKeys15, %Keys15%
Gui, Add, Hotkey, x612 y339 w150 h25 vKeys16 gSaveKeys16, %Keys16%
Gui, Add, Hotkey, x612 y379 w150 h25 vKeys17 gSaveKeys17, %Keys17%
Gui, Add, Hotkey, x612 y419 w150 h25 vKeys18 gSaveKeys18, %Keys18%
Gui, Add, Hotkey, x612 y459 w150 h25 vKeys19 gSaveKeys19, %Keys19%
Gui, Add, Hotkey, x992 y99 w150 h25 vKeys20 gSaveKeys20, %Keys20%
Gui, Add, Hotkey, x992 y139 w150 h25 vKeys21 gSaveKeys21, %Keys21%
Gui, Add, Hotkey, x992 y179 w150 h25 vKeys22 gSaveKeys22, %Keys22%
Gui, Add, Hotkey, x992 y219 w150 h25 vKeys23 gSaveKeys23, %Keys23%
Gui, Add, Hotkey, x992 y259 w150 h25 vKeys24 gSaveKeys24, %Keys24%
Gui, Add, Hotkey, x992 y299 w150 h25 vKeys25 gSaveKeys25, %Keys25%
Gui, Add, Hotkey, x992 y339 w150 h25 vKeys26 gSaveKeys26, %Keys26%
Gui, Add, Hotkey, x992 y379 w150 h25 vKeys27 gSaveKeys27, %Keys27%
Gui, Add, Hotkey, x992 y419 w150 h25 vKeys28 gSaveKeys28, %Keys28%
Gui, Add, Hotkey, x992 y459 w150 h25 vKeys29 gSaveKeys29, %Keys29%
Gui, Font, cWhite
Gui, Tab, Налаштування команд
Gui, Add, Button, x902 y499 w240 h25 gSaveCom, Зберегти команди
Gui, Tab, Налаштування команд
Gui, Add, Text, x32 y39 w1100 h25 , Команди прописувати без знака / і пробіла після введення. Кнопок можна вибрати до 3х.
Gui, Tab, Налаштування репортів 01
Gui, Add, Text, x12 y29 w1130 h25 , Даний розділ заповнюється так як і команди. В першому повідомленні нічого не змінювати!!!
Gui, Add, Text, x12 y69 w400 h25 , Повідомлення
Gui, Add, Text, x582 y69 w400 h25 , Повідомлення
Gui, Add, Text, x422 y69 w150 h25 , Кнопка
Gui, Add, Text, x992 y69 w150 h25 , Кнопка
Gui, Font, cBlack
Gui, Add, Edit, x12 y99 w400 h25 vRep0, Вітаю, на зв'язку %Rank% %Name%. Працюю по Вашій заявці.
Gui, Add, Edit, x12 y139 w400 h25 vRep1, %Rep1%
Gui, Add, Edit, x12 y179 w400 h25 vRep2, %Rep2%
Gui, Add, Edit, x12 y219 w400 h25 vRep3, %Rep3%
Gui, Add, Edit, x12 y259 w400 h25 vRep4, %Rep4%
Gui, Add, Edit, x12 y299 w400 h25 vRep5, %Rep5%
Gui, Add, Edit, x12 y339 w400 h25 vRep6, %Rep6%
Gui, Add, Edit, x12 y379 w400 h25 vRep7, %Rep7%
Gui, Add, Edit, x12 y419 w400 h25 vRep8, %Rep8%
Gui, Add, Edit, x12 y459 w400 h25 vRep9, %Rep9%
Gui, Tab, Налаштування репортів 01
Gui, Add, Edit, x582 y99 w400 h25 vRep10, %Rep10%
Gui, Add, Edit, x582 y139 w400 h25 vRep11, %Rep11%
Gui, Add, Edit, x582 y179 w400 h25 vRep12, %Rep12%
Gui, Add, Edit, x582 y219 w400 h25 vRep13, %Rep13%
Gui, Add, Edit, x582 y259 w400 h25 vRep14, %Rep14%
Gui, Add, Edit, x582 y299 w400 h25 vRep15, %Rep15%
Gui, Add, Edit, x582 y339 w400 h25 vRep16, %Rep16%
Gui, Add, Edit, x582 y379 w400 h25 vRep17, %Rep17%
Gui, Add, Edit, x582 y419 w400 h25 vRep18, %Rep18%
Gui, Add, Edit, x582 y459 w400 h25 vRep19, %Rep19%
Gui, Add, Hotkey, x422 y99 w150 h25 vKeys30 gSaveKeys30, %Keys30%
Gui, Add, Hotkey, x422 y139 w150 h25 vKeys31 gSaveKeys31, %Keys31%
Gui, Add, Hotkey, x422 y179 w150 h25 vKeys32 gSaveKeys32, %Keys32%
Gui, Add, Hotkey, x422 y219 w150 h25 vKeys33 gSaveKeys33, %Keys33%
Gui, Add, Hotkey, x422 y259 w150 h25 vKeys34 gSaveKeys34, %Keys34%
Gui, Add, Hotkey, x422 y299 w150 h25 vKeys35 gSaveKeys35, %Keys35%
Gui, Add, Hotkey, x422 y339 w150 h25 vKeys36 gSaveKeys36, %Keys36%
Gui, Add, Hotkey, x422 y379 w150 h25 vKeys37 gSaveKeys37, %Keys37%
Gui, Add, Hotkey, x422 y419 w150 h25 vKeys38 gSaveKeys38, %Keys38%
Gui, Add, Hotkey, x422 y459 w150 h25 vKeys39 gSaveKeys39, %Keys39%
Gui, Add, Hotkey, x992 y99 w150 h25 vKeys40 gSaveKeys40, %Keys40%
Gui, Add, Hotkey, x992 y139 w150 h25 vKeys41 gSaveKeys41, %Keys41%
Gui, Add, Hotkey, x992 y179 w150 h25 vKeys42 gSaveKeys42, %Keys42%
Gui, Add, Hotkey, x992 y219 w150 h25 vKeys43 gSaveKeys43, %Keys43%
Gui, Add, Hotkey, x992 y259 w150 h25 vKeys44 gSaveKeys44, %Keys44%
Gui, Add, Hotkey, x992 y299 w150 h25 vKeys45 gSaveKeys45, %Keys45%
Gui, Add, Hotkey, x992 y339 w150 h25 vKeys46 gSaveKeys46, %Keys46%
Gui, Add, Hotkey, x992 y379 w150 h25 vKeys47 gSaveKeys47, %Keys47%
Gui, Add, Hotkey, x992 y419 w150 h25 vKeys48 gSaveKeys48, %Keys48%
Gui, Add, Hotkey, x992 y459 w150 h25 vKeys49 gSaveKeys49, %Keys49%
Gui, Add, Button, x802 y499 w340 h25 gSaveRep, Зберегти репорти
Gui, Add, Text, x12 y549 w1130 h25 , Admin Tools 01 server ♡  v %Version%. З любов'ю для адміністрації UKRAINE GTA ♡
Gui, Tab, Налаштування репортів 02
Gui, Font, cWhite
Gui, Add, Text, x12 y29 w1130 h25 , Даний розділ заповнюється так як і команди. В першому повідомленні нічого не змінювати!!!
Gui, Add, Text, x12 y69 w400 h25 , Повідомлення
Gui, Add, Text, x582 y69 w400 h25 , Повідомлення
Gui, Add, Text, x422 y69 w150 h25 , Кнопка
Gui, Add, Text, x992 y69 w150 h25 , Кнопка
Gui, Font, cBlack
Gui, Add, Edit, x12 y99 w400 h25 vRep20, %Rep20%
Gui, Add, Edit, x12 y139 w400 h25 vRep21, %Rep21%
Gui, Add, Edit, x12 y179 w400 h25 vRep22, %Rep22%
Gui, Add, Edit, x12 y219 w400 h25 vRep23, %Rep23%
Gui, Add, Edit, x12 y259 w400 h25 vRep24, %Rep24%
Gui, Add, Edit, x12 y299 w400 h25 vRep25, %Rep25%
Gui, Add, Edit, x12 y339 w400 h25 vRep26, %Rep26%
Gui, Add, Edit, x12 y379 w400 h25 vRep27, %Rep27%
Gui, Add, Edit, x12 y419 w400 h25 vRep28, %Rep28%
Gui, Add, Edit, x12 y459 w400 h25 vRep29, %Rep29%
Gui, Tab, Налаштування репортів 02
Gui, Add, Edit, x582 y99 w400 h25 vRep30, %Rep30%
Gui, Add, Edit, x582 y139 w400 h25 vRep31, %Rep31%
Gui, Add, Edit, x582 y179 w400 h25 vRep32, %Rep32%
Gui, Add, Edit, x582 y219 w400 h25 vRep33, %Rep33%
Gui, Add, Edit, x582 y259 w400 h25 vRep34, %Rep34%
Gui, Add, Edit, x582 y299 w400 h25 vRep35, %Rep35%
Gui, Add, Edit, x582 y339 w400 h25 vRep36, %Rep36%
Gui, Add, Edit, x582 y379 w400 h25 vRep37, %Rep37%
Gui, Add, Edit, x582 y419 w400 h25 vRep38, %Rep38%
Gui, Add, Edit, x582 y459 w400 h25 vRep39, %Rep39%
Gui, Add, Hotkey, x422 y99 w150 h25 vKeys50 gSaveKeys50, %Keys50%
Gui, Add, Hotkey, x422 y139 w150 h25 vKeys51 gSaveKeys51, %Keys51%
Gui, Add, Hotkey, x422 y179 w150 h25 vKeys52 gSaveKeys52, %Keys52%
Gui, Add, Hotkey, x422 y219 w150 h25 vKeys53 gSaveKeys53, %Keys53%
Gui, Add, Hotkey, x422 y259 w150 h25 vKeys54 gSaveKeys54, %Keys54%
Gui, Add, Hotkey, x422 y299 w150 h25 vKeys55 gSaveKeys55, %Keys55%
Gui, Add, Hotkey, x422 y339 w150 h25 vKeys56 gSaveKeys56, %Keys56%
Gui, Add, Hotkey, x422 y379 w150 h25 vKeys57 gSaveKeys57, %Keys57%
Gui, Add, Hotkey, x422 y419 w150 h25 vKeys58 gSaveKeys58, %Keys58%
Gui, Add, Hotkey, x422 y459 w150 h25 vKeys59 gSaveKeys59, %Keys59%
Gui, Add, Hotkey, x992 y99 w150 h25 vKeys60 gSaveKeys60, %Keys60%
Gui, Add, Hotkey, x992 y139 w150 h25 vKeys61 gSaveKeys61, %Keys61%
Gui, Add, Hotkey, x992 y179 w150 h25 vKeys62 gSaveKeys62, %Keys62%
Gui, Add, Hotkey, x992 y219 w150 h25 vKeys63 gSaveKeys63, %Keys63%
Gui, Add, Hotkey, x992 y259 w150 h25 vKeys64 gSaveKeys64, %Keys64%
Gui, Add, Hotkey, x992 y299 w150 h25 vKeys65 gSaveKeys65, %Keys65%
Gui, Add, Hotkey, x992 y339 w150 h25 vKeys66 gSaveKeys66, %Keys66%
Gui, Add, Hotkey, x992 y379 w150 h25 vKeys67 gSaveKeys67, %Keys67%
Gui, Add, Hotkey, x992 y419 w150 h25 vKeys68 gSaveKeys68, %Keys68%
Gui, Add, Hotkey, x992 y459 w150 h25 vKeys69 gSaveKeys69, %Keys69%
Gui, Add, Button, x802 y499 w340 h25 gSaveRep, Зберегти репорти
Gui, Add, Text, x12 y549 w1130 h25 , Admin Tools 01 server ♡  v %Version%. З любов'ю для адміністрації UKRAINE GTA ♡


Gui, Tab, Видати покарання
Gui, Font, cBlack
Gui, Add, Edit, x12 y99 w1150 h300
Gui, Font, cWhite
Gui, Add, Text, x12 y39 w1140 h430 , Введіть форму видачі (одна форма - одна строка):
Gui, Add, Text, x12 y69 w1130 h25 , Для відправки форм в гру, натисніть ALT + R
Gui, Add, Text, x12 y549 w1140 h25 , Admin Tools 01 server ♡  v %Version%. З любов'ю для адміністрації UKRAINE GTA ♡
CustomColor3 = 6A9AB6
Gui +LastFound
Gui, Color, 000000
WinSet, TransColor, %CustomColor3% 470
Gui, Show, x127 y87 h594 w1165 , Admin Tools 01 server ♡  v %Version%


#IfWinActive ahk_class AutoHotkeyGUI

!r::SendEvent, {Alt up}{r}{Alt down}
#IfWinActive
$!r::
Gui, Submit, NoHide
StringSplit, Lines, Strings, `n
Loop, %Lines0%
{
currentLine := Lines%A_Index%
Sleep 350
Send, {T}
Sleep 450
SendInput, %currentLine%{enter}
Sleep 300
}

ReadSettings:
IniRead, Rank, config.ini, Admin, Rank
IniRead, nRank, config.ini, Admin, nRank
IniRead, Name, config.ini, Admin, Name
IniRead, Startup, config.ini, Admin, Startup
IniRead, Server, config.ini, Admin, Server
IniRead, nServer, config.ini, Admin, nServer
GuiControl, Choose,nRank, %nRank%
GuiControl, Choose,nServer, %nServer%
GuiControl,, %Name%
GuiControl,, %Rank%
GuiControl,, %Server%
GuiControl,,Name,%Name%
IniRead, Com0, config.ini, Command, Com0
IniRead, Com1, config.ini, Command, Com1
IniRead, Com2, config.ini, Command, Com2
IniRead, Com3, config.ini, Command, Com3
IniRead, Com4, config.ini, Command, Com4
IniRead, Com5, config.ini, Command, Com5
IniRead, Com6, config.ini, Command, Com6
IniRead, Com7, config.ini, Command, Com7
IniRead, Com8, config.ini, Command, Com8
IniRead, Com9, config.ini, Command, Com9
IniRead, Com10, config.ini, Command, Com10
IniRead, Com11, config.ini, Command, Com11
IniRead, Com12, config.ini, Command, Com12
IniRead, Com13, config.ini, Command, Com13
IniRead, Com14, config.ini, Command, Com14
IniRead, Com15, config.ini, Command, Com15
IniRead, Com16, config.ini, Command, Com16
IniRead, Com17, config.ini, Command, Com17
IniRead, Com18, config.ini, Command, Com18
IniRead, Com19, config.ini, Command, Com19
IniRead, Com20, config.ini, Command, Com20
IniRead, Com21, config.ini, Command, Com21
IniRead, Com22, config.ini, Command, Com22
IniRead, Com23, config.ini, Command, Com23
IniRead, Com24, config.ini, Command, Com24
IniRead, Com25, config.ini, Command, Com25
IniRead, Com26, config.ini, Command, Com26
IniRead, Com27, config.ini, Command, Com27
IniRead, Com28, config.ini, Command, Com28
IniRead, Com29, config.ini, Command, Com29
GuiControlGet, Com0
GuiControlGet, Com1
GuiControlGet, Com2
GuiControlGet, Com3
GuiControlGet, Com4
GuiControlGet, Com5
GuiControlGet, Com6
GuiControlGet, Com7
GuiControlGet, Com8
GuiControlGet, Com9
GuiControlGet, Com10
GuiControlGet, Com11
GuiControlGet, Com12
GuiControlGet, Com13
GuiControlGet, Com14
GuiControlGet, Com15
GuiControlGet, Com16
GuiControlGet, Com17
GuiControlGet, Com18
GuiControlGet, Com19
GuiControlGet, Com20
GuiControlGet, Com21
GuiControlGet, Com22
GuiControlGet, Com23
GuiControlGet, Com24
GuiControlGet, Com25
GuiControlGet, Com26
GuiControlGet, Com27
GuiControlGet, Com28
GuiControlGet, Com29
IniRead, Keys0 , config.ini, Command, keys0
IniRead, Keys1 , config.ini, Command, keys1
IniRead, Keys2 , config.ini, Command, keys2
IniRead, Keys3 , config.ini, Command, keys3
IniRead, Keys4 , config.ini, Command, keys4
IniRead, Keys5 , config.ini, Command, keys5
IniRead, Keys6 , config.ini, Command, keys6
IniRead, Keys7 , config.ini, Command, keys7
IniRead, Keys8 , config.ini, Command, keys8
IniRead, Keys9 , config.ini, Command, keys9
IniRead, Keys10 , config.ini, Command, keys10
IniRead, Keys11 , config.ini, Command, keys11
IniRead, Keys12 , config.ini, Command, keys12
IniRead, Keys13 , config.ini, Command, keys13
IniRead, Keys14 , config.ini, Command, keys14
IniRead, Keys15 , config.ini, Command, keys15
IniRead, Keys16 , config.ini, Command, keys16
IniRead, Keys17 , config.ini, Command, keys17
IniRead, Keys18 , config.ini, Command, keys18
IniRead, Keys19 , config.ini, Command, keys19
IniRead, Keys20 , config.ini, Command, keys20
IniRead, Keys21 , config.ini, Command, keys21
IniRead, Keys22 , config.ini, Command, keys22
IniRead, Keys23 , config.ini, Command, keys23
IniRead, Keys24 , config.ini, Command, keys24
IniRead, Keys25 , config.ini, Command, keys25
IniRead, Keys26 , config.ini, Command, keys26
IniRead, Keys27 , config.ini, Command, keys27
IniRead, Keys28 , config.ini, Command, keys28
IniRead, Keys29 , config.ini, Command, keys29
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys0, Action0, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys1, Action1, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys2, Action2, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys3, Action3, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys4, Action4, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys5, Action5, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys6, Action6, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys7, Action7, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys8, Action8, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys9, Action9, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys10, Action10, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys11, Action11, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys12, Action12, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys13, Action13, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys14, Action14, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys15, Action15, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys16, Action16, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys17, Action17, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys18, Action18, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys19, Action19, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys20, Action20, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys21, Action21, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys22, Action22, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys23, Action23, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys24, Action24, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys25, Action25, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys26, Action26, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys27, Action27, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys28, Action28, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys29, Action29, On, UseErrorLevel
GuiControl,, %Keys0%
GuiControl,, %Keys1%
GuiControl,, %Keys2%
GuiControl,, %Keys3%
GuiControl,, %Keys4%
GuiControl,, %Keys5%
GuiControl,, %Keys6%
GuiControl,, %Keys7%
GuiControl,, %Keys8%
GuiControl,, %Keys9%
GuiControl,, %Keys10%
GuiControl,, %Keys11%
GuiControl,, %Keys12%
GuiControl,, %Keys13%
GuiControl,, %Keys14%
GuiControl,, %Keys15%
GuiControl,, %Keys16%
GuiControl,, %Keys17%
GuiControl,, %Keys18%
GuiControl,, %Keys19%
GuiControl,, %Keys20%
GuiControl,, %Keys21%
GuiControl,, %Keys22%
GuiControl,, %Keys23%
GuiControl,, %Keys24%
GuiControl,, %Keys25%
GuiControl,, %Keys26%
GuiControl,, %Keys27%
GuiControl,, %Keys28%
GuiControl,, %Keys29%
IniRead, Rep0, config.ini, Rep, rep0
IniRead, Rep1, config.ini, Rep, rep1
IniRead, Rep2, config.ini, Rep, rep2
IniRead, Rep3, config.ini, Rep, rep3
IniRead, Rep4, config.ini, Rep, rep4
IniRead, Rep5, config.ini, Rep, rep5
IniRead, Rep6, config.ini, Rep, rep6
IniRead, Rep7, config.ini, Rep, rep7
IniRead, Rep8, config.ini, Rep, rep8
IniRead, Rep9, config.ini, Rep, rep9
IniRead, Rep10, config.ini, Rep, rep10
IniRead, Rep11, config.ini, Rep, rep11
IniRead, Rep12, config.ini, Rep, rep12
IniRead, Rep13, config.ini, Rep, rep13
IniRead, Rep14, config.ini, Rep, rep14
IniRead, Rep15, config.ini, Rep, rep15
IniRead, Rep16, config.ini, Rep, rep16
IniRead, Rep17, config.ini, Rep, rep17
IniRead, Rep18, config.ini, Rep, rep18
IniRead, Rep19, config.ini, Rep, rep19
IniRead, Rep20, config.ini, Rep, rep20
IniRead, Rep21, config.ini, Rep, rep21
IniRead, Rep22, config.ini, Rep, rep22
IniRead, Rep23, config.ini, Rep, rep23
IniRead, Rep24, config.ini, Rep, rep24
IniRead, Rep25, config.ini, Rep, rep25
IniRead, Rep26, config.ini, Rep, rep26
IniRead, Rep27, config.ini, Rep, rep27
IniRead, Rep28, config.ini, Rep, rep28
IniRead, Rep29, config.ini, Rep, rep29
IniRead, Rep30, config.ini, Rep, rep30
IniRead, Rep31, config.ini, Rep, rep31
IniRead, Rep32, config.ini, Rep, rep32
IniRead, Rep33, config.ini, Rep, rep33
IniRead, Rep34, config.ini, Rep, rep34
IniRead, Rep35, config.ini, Rep, rep35
IniRead, Rep36, config.ini, Rep, rep36
IniRead, Rep37, config.ini, Rep, rep37
IniRead, Rep38, config.ini, Rep, rep38
IniRead, Rep39, config.ini, Rep, rep39
GuiControlGet, Rep0
GuiControlGet, Rep1
GuiControlGet, Rep2
GuiControlGet, Rep3
GuiControlGet, Rep4
GuiControlGet, Rep5
GuiControlGet, Rep6
GuiControlGet, Rep7
GuiControlGet, Rep8
GuiControlGet, Rep9
GuiControlGet, Rep10
GuiControlGet, Rep11
GuiControlGet, Rep12
GuiControlGet, Rep13
GuiControlGet, Rep14
GuiControlGet, Rep15
GuiControlGet, Rep16
GuiControlGet, Rep17
GuiControlGet, Rep18
GuiControlGet, Rep19
GuiControlGet, Rep20
GuiControlGet, Rep21
GuiControlGet, Rep22
GuiControlGet, Rep23
GuiControlGet, Rep24
GuiControlGet, Rep25
GuiControlGet, Rep26
GuiControlGet, Rep27
GuiControlGet, Rep28
GuiControlGet, Rep29
GuiControlGet, Rep30
GuiControlGet, Rep31
GuiControlGet, Rep32
GuiControlGet, Rep33
GuiControlGet, Rep34
GuiControlGet, Rep35
GuiControlGet, Rep36
GuiControlGet, Rep37
GuiControlGet, Rep38
GuiControlGet, Rep39
IniRead, Keys30, config.ini, Reports, keys30
IniRead, Keys31, config.ini, Reports, keys31
IniRead, Keys32, config.ini, Reports, keys32
IniRead, Keys33, config.ini, Reports, keys33
IniRead, Keys34, config.ini, Reports, keys34
IniRead, Keys35, config.ini, Reports, keys35
IniRead, Keys36, config.ini, Reports, keys36
IniRead, Keys37, config.ini, Reports, keys37
IniRead, Keys38, config.ini, Reports, keys38
IniRead, Keys39, config.ini, Reports, keys39
IniRead, Keys40, config.ini, Reports, keys40
IniRead, Keys41, config.ini, Reports, keys41
IniRead, Keys42, config.ini, Reports, keys42
IniRead, Keys43, config.ini, Reports, keys43
IniRead, Keys44, config.ini, Reports, keys44
IniRead, Keys45, config.ini, Reports, keys45
IniRead, Keys46, config.ini, Reports, keys46
IniRead, Keys47, config.ini, Reports, keys47
IniRead, Keys48, config.ini, Reports, keys48
IniRead, Keys49, config.ini, Reports, keys49
IniRead, Keys50, config.ini, Reports, keys50
IniRead, Keys51, config.ini, Reports, keys51
IniRead, Keys52, config.ini, Reports, keys52
IniRead, Keys53, config.ini, Reports, keys53
IniRead, Keys54, config.ini, Reports, keys54
IniRead, Keys55, config.ini, Reports, keys55
IniRead, Keys56, config.ini, Reports, keys56
IniRead, Keys57, config.ini, Reports, keys57
IniRead, Keys58, config.ini, Reports, keys58
IniRead, Keys59, config.ini, Reports, keys59
IniRead, Keys60, config.ini, Reports, keys60
IniRead, Keys61, config.ini, Reports, keys61
IniRead, Keys62, config.ini, Reports, keys62
IniRead, Keys63, config.ini, Reports, keys63
IniRead, Keys64, config.ini, Reports, keys64
IniRead, Keys65, config.ini, Reports, keys65
IniRead, Keys66, config.ini, Reports, keys66
IniRead, Keys67, config.ini, Reports, keys67
IniRead, Keys68, config.ini, Reports, keys68
IniRead, Keys69, config.ini, Reports, keys69
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys30, Action30, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys31, Action31, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys32, Action32, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys33, Action33, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys34, Action34, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys35, Action35, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys36, Action36, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys37, Action37, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys38, Action38, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys39, Action39, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys40, Action40, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys41, Action41, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys42, Action42, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys43, Action43, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys44, Action44, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys45, Action45, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys46, Action46, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys47, Action47, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys48, Action48, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys49, Action49, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys50, Action50, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys51, Action51, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys52, Action52, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys53, Action53, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys54, Action54, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys55, Action55, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys56, Action56, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys57, Action57, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys58, Action58, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys59, Action59, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys60, Action60, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys61, Action61, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys62, Action62, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys63, Action63, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys64, Action64, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys65, Action65, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys66, Action66, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys67, Action67, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys68, Action68, On, UseErrorLevel
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys69, Action69, On, UseErrorLevel
GuiControl,, %Keys30%
GuiControl,, %Keys31%
GuiControl,, %Keys32%
GuiControl,, %Keys33%
GuiControl,, %Keys34%
GuiControl,, %Keys35%
GuiControl,, %Keys36%
GuiControl,, %Keys37%
GuiControl,, %Keys38%
GuiControl,, %Keys39%
GuiControl,, %Keys40%
GuiControl,, %Keys41%
GuiControl,, %Keys42%
GuiControl,, %Keys43%
GuiControl,, %Keys44%
GuiControl,, %Keys45%
GuiControl,, %Keys46%
GuiControl,, %Keys47%
GuiControl,, %Keys48%
GuiControl,, %Keys49%
GuiControl,, %Keys50%
GuiControl,, %Keys51%
GuiControl,, %Keys52%
GuiControl,, %Keys53%
GuiControl,, %Keys54%
GuiControl,, %Keys55%
GuiControl,, %Keys56%
GuiControl,, %Keys57%
GuiControl,, %Keys58%
GuiControl,, %Keys59%
GuiControl,, %Keys60%
GuiControl,, %Keys61%
GuiControl,, %Keys62%
GuiControl,, %Keys63%
GuiControl,, %Keys64%
GuiControl,, %Keys65%
GuiControl,, %Keys66%
GuiControl,, %Keys67%
GuiControl,, %Keys68%
GuiControl,, %Keys69%
return
SaveKeys0:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys0, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys0, Action0, On, UseErrorLevel
return
SaveKeys1:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys1, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys1, Action1, On, UseErrorLevel
return
SaveKeys2:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys2, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys2, Action2, On, UseErrorLevel
return
SaveKeys3:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys3, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys3, Action3, On, UseErrorLevel
return
SaveKeys4:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys4, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys4, Action4, On, UseErrorLevel
return
SaveKeys5:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys5, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys5, Action5, On, UseErrorLevel
return
SaveKeys6:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys6, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys6, Action6, On, UseErrorLevel
return
SaveKeys7:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys7, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys7, Action7, On, UseErrorLevel
return
SaveKeys8:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys8, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys8, Action8, On, UseErrorLevel
return
SaveKeys9:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys9, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys9, Action9, On, UseErrorLevel
return
SaveKeys10:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys10, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys10, Action10, On, UseErrorLevel
return
SaveKeys11:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys11, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys11, Action11, On, UseErrorLevel
return
SaveKeys12:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys12, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys12, Action12, On, UseErrorLevel
return
SaveKeys13:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys13, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys13, Action13, On, UseErrorLevel
return
SaveKeys14:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys14, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys14, Action14, On, UseErrorLevel
return
SaveKeys15:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys15, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys15, Action15, On, UseErrorLevel
return
SaveKeys16:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys16, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys16, Action16, On, UseErrorLevel
return
SaveKeys17:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys17, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys17, Action17, On, UseErrorLevel
return
SaveKeys18:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys18, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys18, Action18, On, UseErrorLevel
return
SaveKeys19:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys19, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys19, Action19, On, UseErrorLevel
return
SaveKeys20:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys20, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys20, Action20, On, UseErrorLevel
return
SaveKeys21:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys21, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys21, Action21, On, UseErrorLevel
return
SaveKeys22:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys22, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys22, Action22, On, UseErrorLevel
return
SaveKeys23:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys23, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys23, Action23, On, UseErrorLevel
return
SaveKeys24:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys24, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys24, Action24, On, UseErrorLevel
return
SaveKeys25:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys25, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys25, Action25, On, UseErrorLevel
return
SaveKeys26:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys26, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys26, Action26, On, UseErrorLevel
return
SaveKeys27:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys27, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys27, Action27, On, UseErrorLevel
return
SaveKeys28:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys28, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys28, Action28, On, UseErrorLevel
return
SaveKeys29:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys29, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys29, Action29, On, UseErrorLevel
return
SaveKeys30:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys30, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys30, Action30, On, UseErrorLevel
return
SaveKeys31:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys31, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys31, Action31, On, UseErrorLevel
return
SaveKeys32:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys32, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys32, Action32, On, UseErrorLevel
return
SaveKeys33:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys33, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys33, Action33, On, UseErrorLevel
return
SaveKeys34:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys34, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys34, Action34, On, UseErrorLevel
return
SaveKeys35:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys35, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys35, Action35, On, UseErrorLevel
return
SaveKeys36:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys36, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys36, Action36, On, UseErrorLevel
return
SaveKeys37:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys37, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys37, Action37, On, UseErrorLevel
return
SaveKeys38:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys38, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys38, Action38, On, UseErrorLevel
return
SaveKeys39:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys39, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys39, Action39, On, UseErrorLevel
return
SaveKeys40:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys40, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys40, Action40, On, UseErrorLevel
return
SaveKeys41:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys41, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys41, Action41, On, UseErrorLevel
return
SaveKeys42:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys42, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys42, Action42, On, UseErrorLevel
return
SaveKeys43:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys43, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys43, Action43, On, UseErrorLevel
return
SaveKeys44:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys44, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys44, Action44, On, UseErrorLevel
return
SaveKeys45:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys45, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys45, Action45, On, UseErrorLevel
return
SaveKeys46:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys46, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys46, Action46, On, UseErrorLevel
return
SaveKeys47:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys47, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys47, Action47, On, UseErrorLevel
return
SaveKeys48:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys48, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys48, Action48, On, UseErrorLevel
return
SaveKeys49:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys49, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys49, Action49, On, UseErrorLevel
return
SaveKeys50:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys50, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys50, Action50, On, UseErrorLevel
return
SaveKeys51:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys51, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys51, Action51, On, UseErrorLevel
return
SaveKeys52:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys52, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys52, Action52, On, UseErrorLevel
return
SaveKeys53:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys53, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys53, Action53, On, UseErrorLevel
return
SaveKeys54:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys54, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys54, Action54, On, UseErrorLevel
return
SaveKeys55:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys55, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys55, Action55, On, UseErrorLevel
return
SaveKeys56:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys56, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys56, Action56, On, UseErrorLevel
return
SaveKeys57:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys57, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys57, Action57, On, UseErrorLevel
return
SaveKeys58:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys58, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys58, Action58, On, UseErrorLevel
return
SaveKeys59:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys59, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys59, Action59, On, UseErrorLevel
return
SaveKeys60:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys60, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys60, Action60, On, UseErrorLevel
return
SaveKeys61:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys61, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys61, Action61, On, UseErrorLevel
return
SaveKeys62:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys62, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys62, Action62, On, UseErrorLevel
return
SaveKeys63:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys63, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys63, Action63, On, UseErrorLevel
return
SaveKeys64:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys64, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys64, Action64, On, UseErrorLevel
return
SaveKeys65:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys65, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys65, Action65, On, UseErrorLevel
return
SaveKeys66:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys66, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys66, Action66, On, UseErrorLevel
return
SaveKeys67:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys67, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys67, Action67, On, UseErrorLevel
return
SaveKeys68:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys68, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys68, Action68, On, UseErrorLevel
return
SaveKeys69:
Hotkey, % PrKey%A_Gui%%A_GuiControl%, Off, UseErrorLevel
GuiControlGet, Keys69, %A_Gui%:, %A_GuiControl%
Hotkey, % PrKey%A_Gui%%A_GuiControl% := Keys69, Action69, On, UseErrorLevel
AcceptForm:
MsgBox, 0x40, AdminTools by Pichkur, Test.
return
GreenZone:
State4:=!State4
If state4


#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

global Zoom := 100
global TempImagePath := A_Temp . "\temp_image.jpeg"
global OffsetX := 0
global OffsetY := 0
global MouseDown := false
global StartX := 0
global StartY := 0

Url := "https://i.imgur.com/Dt165cj.jpeg"
UrlDownloadToFile, %Url%, %TempImagePath%

if !FileExist(TempImagePath) {
    MsgBox, ❌ Не вдалося завантажити зображення!
    ExitApp
}

Gui, 3: New
Gui, 3: +LastFound +ToolWindow +AlwaysOnTop -Resize
Gui, 3: Color, 000000
Gui, 3: Font, s7
Gui, 3: Font, cWhite
Gui, 3: Show, w800 h800 x980 y10 NoActivate, Карта зелених зон.

Gui, 3: Add, Picture, x0 y0 vMyImage, %TempImagePath%

OnMessage(0x020A, "HandleMouseWheel")      ; колесо
OnMessage(0x0201, "OnLButtonDown")         ; ліва кнопка вниз
OnMessage(0x0202, "OnLButtonUp")           ; ліва кнопка вгору
OnMessage(0x0200, "OnMouseMove")           ; рух миші

return

HandleMouseWheel(wParam, lParam, msg, hwnd) {
    global Zoom
    delta := (wParam >> 16) & 0xFFFF
    if (delta > 32767)
        delta := delta - 65536

    if (delta > 0)
        Zoom += 10
    else
        Zoom -= 10

    if (Zoom > 500)
        Zoom := 500
    if (Zoom < 10)
        Zoom := 10

    DrawImage()
}

OnLButtonDown(wParam, lParam, msg, hwnd) {
    global MouseDown, StartX, StartY
    MouseDown := true
    MouseGetPos, StartX, StartY
}

OnLButtonUp(wParam, lParam, msg, hwnd) {
    global MouseDown
    MouseDown := false
}

OnMouseMove(wParam, lParam, msg, hwnd) {
    global MouseDown, StartX, StartY, OffsetX, OffsetY

    if (MouseDown) {
        MouseGetPos, x, y
        dx := x - StartX
        dy := y - StartY
        OffsetX += dx
        OffsetY += dy
        StartX := x
        StartY := y
        DrawImage()
    }
}

DrawImage() {
    global Zoom, TempImagePath, OffsetX, OffsetY

    width := 800 * Zoom / 100
    height := 800 * Zoom / 100

    GuiControl, 3: MoveDraw, MyImage, x%OffsetX% y%OffsetY% w%width% h%height%
}


return
AdminH:
State3:=!State3
If state3
{
Gui 2: +LastFound +AlwaysOnTop  +ToolWindow
Gui 2: Color, 000000
Gui 2: Font, s7, Arial Unicode MS
Gui 2: Font, cWhite
Gui 2: Add, GroupBox, x10 y10 w320 h100, [1] Ігровий Помічник
Gui 2: ADD, TEXT,x20 y30 w300,       /admins - Список адмінів онлайн
Gui 2: ADD, TEXT,x20 y45 w300,       /pm <id> <текст> - Надати відповідь у репорт
Gui 2: ADD, TEXT,x20 y60 w300,       /astats - Переглянути статистику онлайну та репортів
Gui 2: Add, GroupBox, x10 y110 w320 h250,  [2] Модератор
Gui 2: ADD, TEXT,x20 y130 w300,/sp <id> - Слiдкувати
Gui 2: ADD, TEXT,x20 y145 w300,/inv - Стати невидимим
Gui 2: ADD, TEXT,x20 y160 w300,/killchat - Kill Chat
Gui 2: ADD, TEXT,x20 y175 w300,/pmute <id> <причина> - Дати мут гравцю
Gui 2: ADD, TEXT,x20 y190 w300,/fixveh <vid> - Полагодити машину
Gui 2: ADD, TEXT,x20 y205 w300,/flip <vid> - Перевернути машину на колеса
Gui 2: ADD, TEXT,x20 y220 w300,/pwarp <id> - Телепортуватись до гравця
Gui 2: ADD, TEXT,x20 y235 w300,/vget <vid> - Телепортувати машину до себе
Gui 2: ADD, TEXT,x20 y250 w300,/jail <id> <час> <причина> - Посадити гравця у КПЗ на N хвилин
Gui 2: ADD, TEXT,x20 y265 w300,/unjail <id> - Витягти гравця з в'язниці
Gui 2: ADD, TEXT,x20 y280 w300,/sethp <id> <число> - Встановити хп гравця
Gui 2: ADD, TEXT,x20 y295 w300,/toprison <id> - Перевести з КПЗ до колонії
Gui 2: ADD, TEXT,x20 y310 w300,/freeprison <id> - Звільнити з колонії
Gui 2: ADD, TEXT,x20 y325 w300,/get <id> - Телепортувати гравця до себе
Gui 2: ADD, TEXT,x20 y340 w300,/vgoto <vid> - Телепортуватися до автомобіля
Gui 2: Add, GroupBox, x10 y360 w320 h160, [3] Ст. Модератор
Gui 2: ADD, TEXT,x20 y380 w300,/reviving <id> - Відрадити гравця
Gui 2: ADD, TEXT,x20 y395 w300,/pkick <id> <причина> - Кік гравця з сервера
Gui 2: ADD, TEXT,x20 y410 w300,/pfreeze <id> - Заморозити гравця
Gui 2: ADD, TEXT,x20 y425 w300,/punfreeze <id> - Розморозити гравця
Gui 2: ADD, TEXT,x20 y440 w300,/pban <id> <время> <причина> - Забанити гравця
Gui 2: ADD, TEXT,x20 y455 w300,/punban <uid> - Зняти бан із гравця
Gui 2: ADD, TEXT,x20 y470 w300,/vehspawn <vid> - Заспавнити автомобіль (не тимчасовий)
Gui 2: ADD, TEXT,x20 y485 w300,/gm <uid> - Видати собі безсмертя
Gui 2: ADD, TEXT,x20 y500 w300,/chekip - останні 5 IP гравця
Gui 2: Add, GroupBox, x340 y10 w350 h280, [4] Адмінітратор
Gui 2: ADD, TEXT, x350 y30 w320 ,       /global <текст> - Глобальне повідомлення у чат
Gui 2: ADD, TEXT, x350 y45 w320 ,       /alarm <текст> - Надіслати повідомлення у телефон всім гравцям
Gui 2: ADD, TEXT, x350 y60 w320 ,       /setfuel <vid> <топливо> - Встановити паливо машині (у літрах)
Gui 2: ADD, TEXT, x350 y75 w320 ,       /jailoffline <uid> <время> <причина> - Посадити гравця у КПЗ офлайн
Gui 2: ADD, TEXT, x350 y90 w320 ,       /vtempsetcolor <vid> <r> <g> <b> - Колір тимчасової машини
Gui 2: ADD, TEXT, x350 y105 w320 ,       /tempnickname <id> <имя> <фамилия> - Тимчасове ім'я гравцю
Gui 2: ADD, TEXT, x350 y120 w320 ,       /tempskin <id> <скин> - Тимчасовий скін гравцю
Gui 2: ADD, TEXT, x350 y135 w320 ,       /pbanoffline <uid> <время> <причина> - Забанити гравця офлайн
Gui 2: ADD, TEXT, x350 y150 w320 ,       /setnickname <id> <имя> <фамилия> - Змінити нік гравецю
Gui 2: ADD, TEXT, x350 y165 w320 ,       /weapongive <id> <ID <зброї> <патрони> - Видати зброю
Gui 2: ADD, TEXT, x350 y180 w320 ,       /weapontake <id> <ID <зброї> <патрони> - Відібрати зброю
Gui 2: ADD, TEXT, x350 y195 w320 ,       /takeallweapons <id> - Відібрати всю зброю
Gui 2: ADD, TEXT, x350 y210 w320 ,       /vdelete <vid> - Видалити тимчасову машину
Gui 2: ADD, TEXT, x350 y225 w320 ,       /veh <vmodel> - Запавнити тимчасову машину
Gui 2: ADD, TEXT, x350 y240 w320 ,       /ahistory <id> - Подивитись історію покарань гравця
Gui 2: ADD, TEXT, x350 y255 w320 ,       /pskin <id> - Видать тимчасовий скін гравцю який є в грі
Gui 2: ADD, TEXT, x350 y270 w320 ,       /car <vid> - Заспавнити тимчасовий автомобіль якиє є в грі
Gui 2: Add, GroupBox, x340 y290 w350 h100, [5] Адмінітратор
Gui 2: ADD, TEXT, x350 y310 w320 ,       /setfaction <id> <фракция> - Встановити гравця у фракцію
Gui 2: ADD, TEXT, x350 y325 w320 ,       /setfactionlevel <id> <ранг> -Встановити ранг у фракції
Gui 2: ADD, TEXT, x350 y340 w320 ,       /offsetfaction <uid> <фракция> - Встановити гравця у фракцію
Gui 2: ADD, TEXT, x350 y355 w320 ,       /offsetfactionlevel <uid> <ранг> - Встановити ранг у фракції
Gui 2: ADD, TEXT, x350 y370 w320 ,       /setrating <id> <кількість> <причина> - Змінити соц. рейтинг
WinSet, TransColor, %CustomColor3% 200
Gui 2: Show, x980 y10 NoActivate, Адмін команди
}
Else
{
Gui 2: Destroy
}
return
SaveGen:
Gui, Submit, NoHide
For index, value in Ranks {
if (index = nRank) {
Rank := value
}
}
For index, value in Servers {
if (index = nServer) {
Server := value
}
}
Gui, Submit, NoHide
GuiControl,, %Name%
GuiControl,, %Rank%
GuiControl,, %Server%
IniWrite, %Rank%, config.ini, Admin, Rank
IniWrite, %nRank%, config.ini, Admin, nRank
IniWrite, %Name%, config.ini, Admin, Name
IniWrite, %Startup%, config.ini, Admin, Startup
IniWrite, %Server%, config.ini, Admin, Server
IniWrite, %nServer%, config.ini, Admin, nServer
MsgBox, 0x40, AdminTools by Pichkur,  Інформація про адміністратора успішно збережена.
return
SaveCom:
GuiControlGet Com1,,Com1
GuiControlGet Com2,,Com2
GuiControlGet Com3,,Com3
GuiControlGet Com4,,Com4
GuiControlGet Com5,,Com5
GuiControlGet Com6,,Com6
GuiControlGet Com7,,Com7
GuiControlGet Com8,,Com8
GuiControlGet Com9,,Com9
GuiControlGet Com0,,Com0
GuiControlGet Com10,,Com10
GuiControlGet Com11,,Com11
GuiControlGet Com12,,Com12
GuiControlGet Com13,,Com13
GuiControlGet Com14,,Com14
GuiControlGet Com15,,Com15
GuiControlGet Com16,,Com16
GuiControlGet Com17,,Com17
GuiControlGet Com18,,Com18
GuiControlGet Com19,,Com19
GuiControlGet Com20,,Com20
GuiControlGet Com21,,Com21
GuiControlGet Com22,,Com22
GuiControlGet Com23,,Com23
GuiControlGet Com24,,Com24
GuiControlGet Com25,,Com25
GuiControlGet Com26,,Com26
GuiControlGet Com27,,Com27
GuiControlGet Com28,,Com28
GuiControlGet Com29,,Com29
Iniwrite %Com0%, config.ini, Command, Com0
Iniwrite %Com1%, config.ini, Command, Com1
Iniwrite %Com2%, config.ini, Command, Com2
Iniwrite %Com3%, config.ini, Command, Com3
Iniwrite %Com4%, config.ini, Command, Com4
Iniwrite %Com5%, config.ini, Command, Com5
Iniwrite %Com6%, config.ini, Command, Com6
Iniwrite %Com7%, config.ini, Command, Com7
Iniwrite %Com8%, config.ini, Command, Com8
Iniwrite %Com9%, config.ini, Command, Com9
Iniwrite %Com10%, config.ini, Command, Com10
Iniwrite %Com11%, config.ini, Command, Com11
Iniwrite %Com12%, config.ini, Command, Com12
Iniwrite %Com13%, config.ini, Command, Com13
Iniwrite %Com14%, config.ini, Command, Com14
Iniwrite %Com15%, config.ini, Command, Com15
Iniwrite %Com16%, config.ini, Command, Com16
Iniwrite %Com17%, config.ini, Command, Com17
Iniwrite %Com18%, config.ini, Command, Com18
Iniwrite %Com19%, config.ini, Command, Com19
Iniwrite %Com20%, config.ini, Command, Com20
Iniwrite %Com21%, config.ini, Command, Com21
Iniwrite %Com22%, config.ini, Command, Com22
Iniwrite %Com23%, config.ini, Command, Com23
Iniwrite %Com24%, config.ini, Command, Com24
Iniwrite %Com25%, config.ini, Command, Com25
Iniwrite %Com26%, config.ini, Command, Com26
Iniwrite %Com27%, config.ini, Command, Com27
Iniwrite %Com28%, config.ini, Command, Com28
Iniwrite %Com29%, config.ini, Command, Com29
GuiControl,, %Keys0%
GuiControl,, %Keys1%
GuiControl,, %Keys2%
GuiControl,, %Keys3%
GuiControl,, %Keys4%
GuiControl,, %Keys5%
GuiControl,, %Keys6%
GuiControl,, %Keys7%
GuiControl,, %Keys8%
GuiControl,, %Keys9%
GuiControl,, %Keys10%
GuiControl,, %Keys11%
GuiControl,, %Keys12%
GuiControl,, %Keys13%
GuiControl,, %Keys14%
GuiControl,, %Keys15%
GuiControl,, %Keys16%
GuiControl,, %Keys17%
GuiControl,, %Keys18%
GuiControl,, %Keys19%
GuiControl,, %Keys20%
GuiControl,, %Keys21%
GuiControl,, %Keys22%
;Спішка та неуважність + неправильне вкладання, над цим ми зараз працюємо
GuiControl,, %Keys23%
GuiControl,, %Keys24%
GuiControl,, %Keys25%
GuiControl,, %Keys26%
GuiControl,, %Keys27%
GuiControl,, %Keys28%
GuiControl,, %Keys29%
Iniwrite %Keys0% , config.ini, Command, keys0
Iniwrite %Keys1% , config.ini, Command, keys1
Iniwrite %Keys2% , config.ini, Command, keys2
Iniwrite %Keys3% , config.ini, Command, keys3
Iniwrite %Keys4% , config.ini, Command, keys4
Iniwrite %Keys5% , config.ini, Command, keys5
Iniwrite %Keys6% , config.ini, Command, keys6
Iniwrite %Keys7% , config.ini, Command, keys7
Iniwrite %Keys8% , config.ini, Command, keys8
Iniwrite %Keys9% , config.ini, Command, keys9
Iniwrite %Keys10% , config.ini, Command, keys10
Iniwrite %Keys11% , config.ini, Command, keys11
Iniwrite %Keys12% , config.ini, Command, keys12
Iniwrite %Keys13% , config.ini, Command, keys13
Iniwrite %Keys14% , config.ini, Command, keys14
Iniwrite %Keys15% , config.ini, Command, keys15
Iniwrite %Keys16% , config.ini, Command, keys16
Iniwrite %Keys17% , config.ini, Command, keys17
Iniwrite %Keys18% , config.ini, Command, keys18
Iniwrite %Keys19% , config.ini, Command, keys19
Iniwrite %Keys20% , config.ini, Command, keys20
Iniwrite %Keys21% , config.ini, Command, keys21
Iniwrite %Keys22% , config.ini, Command, keys22
Iniwrite %Keys23% , config.ini, Command, keys23
Iniwrite %Keys24% , config.ini, Command, keys24
Iniwrite %Keys25% , config.ini, Command, keys25
Iniwrite %Keys26% , config.ini, Command, keys26
Iniwrite %Keys27% , config.ini, Command, keys27
Iniwrite %Keys28% , config.ini, Command, keys28
Iniwrite %Keys29% , config.ini, Command, keys29
MsgBox, 0x40, AdminTools by Pichkur, Команди успішно збережені.
return
SaveRep:
GuiControlGet Rep0,,Rep0
GuiControlGet Rep1,,Rep1
GuiControlGet Rep2,,Rep2
GuiControlGet Rep3,,Rep3
GuiControlGet Rep4,,Rep4
GuiControlGet Rep5,,Rep5
GuiControlGet Rep6,,Rep6
GuiControlGet Rep7,,Rep7
GuiControlGet Rep8,,Rep8
GuiControlGet Rep9,,Rep9
GuiControlGet Rep10,,Rep10
GuiControlGet Rep11,,Rep11
GuiControlGet Rep12,,Rep12
GuiControlGet Rep13,,Rep13
GuiControlGet Rep14,,Rep14
GuiControlGet Rep15,,Rep15
GuiControlGet Rep16,,Rep16
GuiControlGet Rep17,,Rep17
GuiControlGet Rep18,,Rep18
GuiControlGet Rep19,,Rep19
GuiControlGet Rep20,,Rep20
GuiControlGet Rep21,,Rep21
GuiControlGet Rep22,,Rep22
GuiControlGet Rep23,,Rep23
GuiControlGet Rep24,,Rep24
GuiControlGet Rep25,,Rep25
GuiControlGet Rep26,,Rep26
GuiControlGet Rep27,,Rep27
GuiControlGet Rep28,,Rep28
GuiControlGet Rep29,,Rep29
GuiControlGet Rep30,,Rep30
GuiControlGet Rep31,,Rep31
GuiControlGet Rep32,,Rep32
GuiControlGet Rep33,,Rep33
GuiControlGet Rep34,,Rep34
GuiControlGet Rep35,,Rep35
GuiControlGet Rep36,,Rep36
GuiControlGet Rep37,,Rep37
GuiControlGet Rep38,,Rep38
GuiControlGet Rep39,,Rep39
IniWrite %Rep0%, config.ini, Rep, rep0
IniWrite %Rep1%, config.ini, Rep, rep1
IniWrite %Rep2%, config.ini, Rep, rep2
IniWrite %Rep3%, config.ini, Rep, rep3
IniWrite %Rep4%, config.ini, Rep, rep4
IniWrite %Rep5%, config.ini, Rep, rep5
IniWrite %Rep6%, config.ini, Rep, rep6
IniWrite %Rep7%, config.ini, Rep, rep7
IniWrite %Rep8%, config.ini, Rep, rep8
IniWrite %Rep9%, config.ini, Rep, rep9
IniWrite %Rep10%, config.ini, Rep, rep10
IniWrite %Rep11%, config.ini, Rep, rep11
IniWrite %Rep12%, config.ini, Rep, rep12
IniWrite %Rep13%, config.ini, Rep, rep13
IniWrite %Rep14%, config.ini, Rep, rep14
IniWrite %Rep15%, config.ini, Rep, rep15
IniWrite %Rep16%, config.ini, Rep, rep16
IniWrite %Rep17%, config.ini, Rep, rep17
IniWrite %Rep18%, config.ini, Rep, rep18
IniWrite %Rep19%, config.ini, Rep, rep19
IniWrite %Rep20%, config.ini, Rep, rep20
IniWrite %Rep21%, config.ini, Rep, rep21
IniWrite %Rep22%, config.ini, Rep, rep22
IniWrite %Rep23%, config.ini, Rep, rep23
IniWrite %Rep24%, config.ini, Rep, rep24
IniWrite %Rep25%, config.ini, Rep, rep25
IniWrite %Rep26%, config.ini, Rep, rep26
IniWrite %Rep27%, config.ini, Rep, rep27
IniWrite %Rep28%, config.ini, Rep, rep28
IniWrite %Rep29%, config.ini, Rep, rep29
IniWrite %Rep30%, config.ini, Rep, rep30
IniWrite %Rep31%, config.ini, Rep, rep31
IniWrite %Rep32%, config.ini, Rep, rep32
IniWrite %Rep33%, config.ini, Rep, rep33
IniWrite %Rep34%, config.ini, Rep, rep34
IniWrite %Rep35%, config.ini, Rep, rep35
IniWrite %Rep36%, config.ini, Rep, rep36
IniWrite %Rep37%, config.ini, Rep, rep37
IniWrite %Rep38%, config.ini, Rep, rep38
IniWrite %Rep39%, config.ini, Rep, rep39
GuiControl,, %Keys31%
GuiControl,, %Keys32%
GuiControl,, %Keys33%
GuiControl,, %Keys34%
GuiControl,, %Keys35%
GuiControl,, %Keys36%
GuiControl,, %Keys37%
GuiControl,, %Keys38%
GuiControl,, %Keys39%
GuiControl,, %Keys40%
GuiControl,, %Keys41%
GuiControl,, %Keys42%
GuiControl,, %Keys43%
GuiControl,, %Keys44%
GuiControl,, %Keys45%
GuiControl,, %Keys46%
GuiControl,, %Keys47%
GuiControl,, %Keys48%
GuiControl,, %Keys49%
GuiControl,, %Keys51%
GuiControl,, %Keys52%
GuiControl,, %Keys53%
GuiControl,, %Keys54%
GuiControl,, %Keys55%
GuiControl,, %Keys56%
GuiControl,, %Keys57%
GuiControl,, %Keys58%
GuiControl,, %Keys59%
GuiControl,, %Keys60%
GuiControl,, %Keys61%
GuiControl,, %Keys62%
GuiControl,, %Keys63%
GuiControl,, %Keys64%
GuiControl,, %Keys65%
GuiControl,, %Keys66%
GuiControl,, %Keys67%
GuiControl,, %Keys68%
GuiControl,, %Keys69%
Iniwrite %Keys30% , config.ini, Reports, keys30
Iniwrite %Keys31% , config.ini, Reports, keys31
Iniwrite %Keys32% , config.ini, Reports, keys32
Iniwrite %Keys33% , config.ini, Reports, keys33
Iniwrite %Keys34% , config.ini, Reports, keys34
Iniwrite %Keys35% , config.ini, Reports, keys35
Iniwrite %Keys36% , config.ini, Reports, keys36
Iniwrite %Keys37% , config.ini, Reports, keys37
Iniwrite %Keys38% , config.ini, Reports, keys38
Iniwrite %Keys39% , config.ini, Reports, keys39
Iniwrite %Keys40% , config.ini, Reports, keys40
Iniwrite %Keys41% , config.ini, Reports, keys41
Iniwrite %Keys42% , config.ini, Reports, keys42
Iniwrite %Keys43% , config.ini, Reports, keys43
Iniwrite %Keys44% , config.ini, Reports, keys44
Iniwrite %Keys45% , config.ini, Reports, keys45
Iniwrite %Keys46% , config.ini, Reports, keys46
Iniwrite %Keys47% , config.ini, Reports, keys47
Iniwrite %Keys48% , config.ini, Reports, keys48
Iniwrite %Keys49% , config.ini, Reports, keys49
Iniwrite %Keys50% , config.ini, Reports, keys50
Iniwrite %Keys51% , config.ini, Reports, keys51
Iniwrite %Keys52% , config.ini, Reports, keys52
Iniwrite %Keys53% , config.ini, Reports, keys53
Iniwrite %Keys54% , config.ini, Reports, keys54
Iniwrite %Keys55% , config.ini, Reports, keys55
Iniwrite %Keys56% , config.ini, Reports, keys56
Iniwrite %Keys57% , config.ini, Reports, keys57
Iniwrite %Keys58% , config.ini, Reports, keys58
Iniwrite %Keys59% , config.ini, Reports, keys59
Iniwrite %Keys60% , config.ini, Reports, keys60
Iniwrite %Keys61% , config.ini, Reports, keys61
Iniwrite %Keys62% , config.ini, Reports, keys62
Iniwrite %Keys63% , config.ini, Reports, keys63
Iniwrite %Keys64% , config.ini, Reports, keys64
Iniwrite %Keys65% , config.ini, Reports, keys65
Iniwrite %Keys66% , config.ini, Reports, keys66
Iniwrite %Keys67% , config.ini, Reports, keys67
Iniwrite %Keys68% , config.ini, Reports, keys68
Iniwrite %Keys69% , config.ini, Reports, keys69
MsgBox, 0x40, AdminTools by Pichkur,  Бінди на репорти успішно збережені.
return
Action0:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, {е}
Sleep 100
Send, ^a
Sleep 100
SendInput, /%Com0%{space}
BlockInput, off
return
Action1:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, {е}
Sleep 100
Send, ^a
Sleep 100
SendInput, /%Com1%{space}
BlockInput, off
return
Action2:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, {е}
Sleep 100
Send, ^a
Sleep 100
SendInput, /%Com2%{space}
BlockInput, off
return
Action3:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, {е}
Sleep 100
Send, ^a
Sleep 100
SendInput, /%Com3%{space}
BlockInput, off
return
Action4:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, {е}
Sleep 100
Send, ^a
Sleep 100
SendInput, /%Com4%{space}
BlockInput, off
return
Action5:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, {е}
Sleep 100
Send, ^a
Sleep 100
SendInput, /%Com5%{space}
BlockInput, off
return
Action6:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, {е}
Sleep 100
Send, ^a
Sleep 100
SendInput, /%Com6%{space}
BlockInput, off
return
Action7:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, {е}
Sleep 100
Send, ^a
Sleep 100
SendInput, /%Com7%{space}
BlockInput, off
return
Action8:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, {е}
Sleep 100
Send, ^a
Sleep 100
SendInput, /%Com8%{space}
BlockInput, off
return
Action9:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, {е}
Sleep 100
Send, ^a
Sleep 100
SendInput, /%Com9%{space}
BlockInput, off
return
Action10:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, {е}
Sleep 100
Send, ^a
Sleep 100
SendInput, /%Com10%{space}
BlockInput, off
return
Action11:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, {е}
Sleep 100
Send, ^a
Sleep 100
SendInput, /%Com11%{space}
BlockInput, off
return
Action12:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, {е}
Sleep 100
Send, ^a
Sleep 100
SendInput, /%Com12%{space}
BlockInput, off
return
Action13:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, {е}
Sleep 100
Send, ^a
Sleep 100
SendInput, /%Com13%{space}
BlockInput, off
return
Action14:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, {е}
Sleep 100
Send, ^a
Sleep 100
SendInput, /%Com14%{space}
BlockInput, off
return
Action15:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, {е}
Sleep 100
Send, ^a
Sleep 100
SendInput, /%Com15%{space}
BlockInput, off
return
Action16:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, {е}
Sleep 100
Send, ^a
Sleep 100
SendInput, /%Com16%{space}
BlockInput, off
return
Action17:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, {е}
Sleep 100
Send, ^a
Sleep 100
SendInput, /%Com17%{space}
BlockInput, off
return
Action18:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, {е}
Sleep 100
Send, ^a
Sleep 100
SendInput, /%Com18%{space}
BlockInput, off
return
Action19:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, {е}
Sleep 100
Send, ^a
Sleep 100
SendInput, /%Com19%{space}
BlockInput, off
return
Action20:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, {е}
Sleep 100
Send, ^a
Sleep 100
SendInput, /%Com20%{space}
BlockInput, off
return
Action21:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, {е}
Sleep 100
Send, ^a
Sleep 100
SendInput, /%Com21%{space}
BlockInput, off
return
Action22:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, {е}
Sleep 100
Send, ^a
Sleep 100
SendInput, /%Com22%{space}
BlockInput, off
return
Action23:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, {е}
Sleep 100
Send, ^a
Sleep 100
SendInput, /%Com23%{space}
BlockInput, off
return
Action24:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, {е}
Sleep 100
Send, ^a
Sleep 100
SendInput, /%Com24%{space}
BlockInput, off
return
Action25:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, {е}
Sleep 100
Send, ^a
Sleep 100
SendInput, /%Com25%{space}
BlockInput, off
return
Action26:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, {е}
Sleep 100
Send, ^a
Sleep 100
SendInput, /%Com26%{space}
BlockInput, off
return
Action27:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, {е}
Sleep 100
Send, ^a
Sleep 100
SendInput, /%Com27%{space}
BlockInput, off
return
Action28:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, {е}
Sleep 100
Send, ^a
Sleep 100
SendInput, /%Com28%{space}
BlockInput, off
return
Action29:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, {е}
Sleep 100
Send, ^a
Sleep 100
SendInput, /%Com29%{space}
BlockInput, off
return
Action30:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, Вітаю, на зв'язку %Rank% %Name%. Працюю по Вашій заявці.
return
Action31:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep1%
return
Action32:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep2%
return
Action33:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep3%
return
Action34:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep4%
return
Action35:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep5%
return
Action36:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep6%
return
Action37:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep7%
return
Action38:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep8%
return
Action39:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep9%
return
Action40:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep10%
return
Action41:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep11%
return
Action42:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep12%
return
Action43:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep13%
return
Action44:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep14%
return
Action45:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep15%
return
Action46:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep16%
return
Action47:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep17%
return
Action48:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep18%
return
Action49:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep19%
Action50:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep20%
return
Action51:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep21%
return
Action52:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep22%
return
Action53:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep23%
return
Action54:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep24%
return
Action55:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep25%
return
Action56:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep26%
return
Action57:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep27%
return
Action58:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep28%
return
Action59:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep29%
return
Action60:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep30%
return
Action61:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep31%
return
Action62:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep32%
return
Action63:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep33%
return
Action64:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep34%
return
Action65:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep35%
return
Action66:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep36%
return
Action67:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep37%
return
Action68:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep38%
return
Action69:
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput, %Rep39%
return




global lastCommandInGUI := ""  ; остання виведена команда в GUI

F2::
Gui, Submit, NoHide
GuiControlGet, CheckboxChecked, , % "CheckboxChecked"
if (CheckboxChecked = 1)
{
    FileReadLine, filePath, road.ini, 1
    if (filePath = "") {
        MsgBox, ❌ Файл road.ini не містить шлях.
        return
    }

    Words := "offmute|jailoffline|pbanoffline|warn|pkick|pban|pmute|jail|unwarn|unmute|unjail|global|offwarn|pskin|weapongive|setnickname|tempnickname|gm"
    lastMatch := ""
    foundCommand := false

    Loop 5
    {
        file := FileOpen(filePath "\game\mta\logs\console.log", "r", "UTF-8")
        if !IsObject(file) {
            MsgBox, ❌ Не вдалося з’єднатись з грою.
            return
        }
        fileContent := file.Read()
        file.Close()

        lines := StrSplit(fileContent, "`n")
        Loop % lines.MaxIndex()
        {
            idx := lines.MaxIndex() - A_Index + 1
            line := lines[idx]
            if RegExMatch(line, "^\[.*?\]\s\[Output\]\s:\s\[.*?\]\s.*?\[\d+\]:\s(.+)$", match)
            {
                commandText := match1
                if RegExMatch(commandText, "^(?i)(" Words ")\b", cmdMatch)
                {
                    lastMatch := commandText
                    foundCommand := true
                    break
                }
            }
        }

        if (foundCommand)
            break
        else
            Sleep, 300
    }

    if (lastMatch != "" && lastMatch != "/")
    {
        GuiControl, 5:, LastMatchText, %lastMatch%
        lastCommandInGUI := lastMatch

        ; Вставити в гру без натискання Enter
        SendMessage, 0x50,, -0xF57FBDE,, A
        SendInput,{е}
        Sleep 300
        SendInput, /%lastMatch%
    }
    else
    {
        MsgBox, ❌ Команда не знайдена або порожня.
    }
}
return

; === GUI відображення останньої форми ===
ToggleF2:
GuiControlGet, CheckboxChecked, , % "CheckboxChecked"
if (CheckboxChecked = 1)
{
    Gui, 5: +AlwaysOnTop +ToolWindow +LastFound
    Gui, 5: Color, 000000
    Gui, 5: Font, cWhite, s7, c0, Arial, 0
    Gui, 5: Add, Text, x10 y5 w250 h13 vLastMatchText
	WinSet, TransColor, %CustomColor3% 200
    WinSet, AlwaysOnTop, On
    Gui, 5: Show, y0 NoActivate, Остання форма:
    SetTimer, UpdateGUI, 300
}
else
{
    Gui, 5: Destroy
    SetTimer, UpdateGUI, Off
}
return

; === Оновлення GUI кожні 300 мс ===
UpdateGUI:
FileReadLine, filePath, road.ini, 1
if (filePath = "") {
    return
}
file := FileOpen(filePath "\game\mta\logs\console.log", "r", "UTF-8")
if !IsObject(file) {
    return
}
fileContent := file.Read()
file.Close()

Words := "offmute|jailoffline|pbanoffline|warn|pkick|pban|pmute|jail|unwarn|unmute|unjail|global|offwarn|pskin|weapongive|setnickname|tempnickname|gm"
lastMatch := ""

lines := StrSplit(fileContent, "`n")
Loop % lines.MaxIndex()
{
    idx := lines.MaxIndex() - A_Index + 1
    line := lines[idx]
    if RegExMatch(line, "^\[.*?\]\s\[Output\]\s:\s\[.*?\]\s.*?\[\d+\]:\s(.+)$", match)
    {
        commandText := match1
        if RegExMatch(commandText, "^(?i)(" Words ")\b", cmdMatch)
        {
            lastMatch := commandText
            break
        }
    }
}

if (lastMatch != "" && lastMatch != lastCommandInGUI) {
    GuiControl, 5:, LastMatchText, %lastMatch%
    lastCommandInGUI := lastMatch
}
return












Toggleachat:
GuiControlGet, CheckboxChecked4, , % "CheckboxChecked4"
if (CheckboxChecked4 = 1)
{
Gui, 9:  +AlwaysOnTop  +ToolWindow +LastFound
Gui, 9: Color, 000000
Gui, 9: Font, cWhite, s9, c0, Arial, 0
Gui, 9: Add, Edit,  w850 h90 ReadOnly +Wrap  vLastMatchText4
WinSet, TransColor, %CustomColor3% 200
WinSet, AlwaysOnTop, On
Gui, 9: Show, y0 NoActivate, Адміністративний ігровий чат
SetTimer, UpdateGUIAChat, 1000
}
else
{
Gui, 9: Destroy
SetTimer, UpdateGUIReport, Off
}
return
ToggleReport:
GuiControlGet, CheckboxChecked3, , % "CheckboxChecked3"
if (CheckboxChecked3 = 1)
{
Gui, 8:  +AlwaysOnTop  +ToolWindow +LastFound
Gui, 8: Color, 000000
Gui, 8: Font, cWhite, s9, c0, Arial, 0
Gui, 8: Add, Edit,  w900 h90 ReadOnly +Wrap  vLastMatchText2
Gui, 8: Add, Edit, w900 h20  cBlack vMyEditText
Gui, 8: Add, Button, gSendToGame, Отправить в игру
WinSet, TransColor, %CustomColor3% 200
WinSet, AlwaysOnTop, On
Gui, 8: Show, y0 NoActivate, Репорти від граців
SetTimer, UpdateGUIReport, 1000
}
else
{
Gui, 8: Destroy
SetTimer, UpdateGUIReport, Off
}
return
SendToGame:
hWnd := WinExist("UKRAINE GTA")
WinGet, winState, MinMax, ahk_id %hWnd%
SendMessage, 0x50, 2, 0x00000422,, ahk_id %hWnd%
GuiControlGet, MyEditText
if (SubStr(MyEditText, 1, 1) = "/") {
StringTrimLeft, MyEditText, MyEditText, 1
} else {
MyEditText := "say " . MyEditText
}
ControlSend, ahk_parent, {f8}, ahk_id %hWnd%
Sleep 350
ControlSend, ahk_parent, {Raw}%MyEditText%, ahk_id %hWnd%
ControlSend, ahk_parent, {enter}, ahk_id %hWnd%
ControlSend, ahk_parent, {f8}, ahk_id %hWnd%
UrlDownloadToFile, https://github.com/PizdaZaebali/pizdanahuibliat/blob/main/10.mp3?raw=true, % rep  := A_Temp "\rep.mp3"
SoundPlay,  % rep
if (winState = -1)
WinMinimize, ahk_id %hWnd%
return
UpdateGUIReport:
FileReadLine, filePath, road.ini, 1
if (filePath = "") {
MsgBox, Помилка: Файл road.ini не існує, або не вибрана папка з UKRAINEGTA.
return
}
file := FileOpen(filePath "\game\mta\logs\console.log", "r", "UTF-8")
if !IsObject(file) {
    MsgBox, Помилка: Не вдалося зєднатись з грою. Можливо ви не вибрали папку UKRAINE GTA, натисніть кнопку "Вибрати папку UGTA".
    return
}
fileContent := file.Read()
file.Close()
lastMatches := []
Loop, parse, fileContent, `n
{
if RegExMatch(A_LoopField, "^\[\d{4}\-\d{2}\-\d{2}\s\d{2}\:\d{2}\:\d{2}\]\s\[Output\]\s\:\s(.*)від гравця.*\[(\d+)\].*$", report)
{
lastMatches.Push(A_LoopField)
if (lastMatches.Length() > 6)
lastMatches.RemoveAt(1)
}
}
lastMatch2 := ""
Loop, % lastMatches.Length()
{
lastMatch2 .= lastMatches[A_Index] "`n"
}
GuiControl, 8:, LastMatchText2, %lastMatch2%
return
UpdateGUIAChat:
FileReadLine, filePath, road.ini, 1
if (filePath = "") {
MsgBox, Помилка: Файл road.ini не існує, або не вибрана папка з UKRAINEGTA.
return
}
file := FileOpen(filePath "\game\mta\logs\console.log", "r", "UTF-8")
if !IsObject(file) {
    MsgBox, Помилка: Не вдалося зєднатись з грою. Можливо ви не вибрали папку UKRAINE GTA, натисніть кнопку "Вибрати папку UGTA".
return
}
fileContent := file.Read()
file.Close()
lastMatches := []
Loop, parse, fileContent, `n
{
if RegExMatch(A_LoopField, "^\[\d{4}\-\d{2}\-\d{2}\s\d{2}\:\d{2}\:\d{2}\]\s\[Output\]\s\:\s\[(.*\s\d+|ЗГА|Ігровий помічник|Головний Адміністратор|Керівник)\]\s.*\s\[\d+\]\:\s.*$", report)
{
lastMatches.Push(A_LoopField)
if (lastMatches.Length() > 6)
lastMatches.RemoveAt(1)
}
}
lastMatch4 := ""
Loop, % lastMatches.Length()
{
lastMatch4 .= lastMatches[A_Index] "`n"
}
GuiControl, 9:, LastMatchText4, %lastMatch4%
return






F3::
Gui, Submit, NoHide
GuiControlGet, CheckboxChecked2, , % "CheckboxChecked2"
if (CheckboxChecked2 = 1)
{
FileReadLine, filePath, road.ini, 1
if (filePath = "") {
MsgBox, Помилка: Файл road.ini не існує, або не вибрана папка з UKRAINEGTA.
return
}
file := FileOpen(filePath "\game\mta\logs\console.log", "r", "UTF-8")
if !IsObject(file) {
MsgBox, Помилка: Не вдалося зєднатись з грою. Можливо ви не вибрали папку UKRAINE GTA, натисніть кнопку "Вибрати папку UGTA".
return
}
fileContent := file.Read()
file.Close()
lastMatch1 := ""
Loop, parse, fileContent, `n
{
if RegExMatch(A_LoopField, "^\[\d{4}\-\d{2}\-\d{2}\s\d{2}\:\d{2}\:\d{2}\]\s\[Output\]\s\:\s.*від гравця.*\[(\d+)\].*$", outputt)
{
lastMatch1 := outputt1
}
}
if (lastMatch1 != "")
{
Sleep 0
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput,{е}
Sleep 500
SendInput,/pm %lastMatch1%{space}
testing1 := lastMatch1
}
FileDelete, C:\Program Files (x86)\game\game\mta\logs\console.log
}
return
F4::
Gui, Submit, NoHide
GuiControlGet, CheckboxChecked2, , % "CheckboxChecked2"
if (CheckboxChecked2 = 1)
{
Sleep 0
SendMessage, 0x50,, -0xF57FBDE,, A
SendInput,%testing1%{space}
}
return
ToggleF3:
GuiControlGet, CheckboxChecked2, , % "CheckboxChecked2"
if (CheckboxChecked2 = 1)
{
Gui, 6: +AlwaysOnTop  +ToolWindow +LastFound
Gui, 6: Color, 000000
Gui, 6: Font, s7
Gui, 6: Font, cWhite
;Gui, 6: Add, Text, x10 y5 w200 h13, Останній репорт від:
Gui, 6: Add, Text, x10 y5 w250 h13 vLastMatchText1
WinSet, TransColor, %CustomColor3% 200
WinSet, AlwaysOnTop, On
Gui, 6: Show, y40 w270 NoActivate, Останній репорт від:
GuiControlGet, CheckboxChecked2, , % "CheckboxChecked2"
SetTimer, UpdateGUI1, 500
}
else
{
Gui, 6: Destroy
SetTimer, UpdateGUI1, Off
}
return
UpdateGUI1:
FileReadLine, filePath, road.ini, 1
if (filePath = "") {
MsgBox, Помилка: Файл road.ini не існує, або не вибрана папка з UKRAINEGTA.
return
}
file := FileOpen(filePath "\game\mta\logs\console.log", "r", "UTF-8")
if !IsObject(file) {
    MsgBox, Помилка: Не вдалося зєднатись з грою. Можливо ви не вибрали папку UKRAINE GTA, натисніть кнопку "Вибрати папку UGTA".
    return
}
fileContent := file.Read()
file.Close()
lastMatch1 := ""
Loop, parse, fileContent, `n
{
if RegExMatch(A_LoopField, "^\[\d{4}\-\d{2}\-\d{2}\s\d{2}\:\d{2}\:\d{2}\]\s\[Output\]\s\:\s.*від гравця.*\[(\d+)\].*$", outputt)
{
lastMatch1 := outputt1
}
}
GuiControl, 6:, LastMatchText1, %lastMatch1%  |  Остання відповідь: %testing1%
return
SelectFolder:
Gui, Submit, NoHide
FileSelectFolder, SelectedFolder, , 3, Виберіть папку UKRAINE GTA
if (SelectedFolder <> "") {
FileDelete, road.ini
FileAppend, %SelectedFolder%`n, road.ini
}
return

; Заглушки для кнопок нового меню
ExtraFunc1:
    MsgBox, Виконати функцію 1 (Функціонал не реалізовано)
return

ExtraFunc2:
    MsgBox, Ви SITконати функцію 2 (Функціонал не реалізовано)
return

ExtraFunc3:
    MsgBox, Виконати функцію 3 (Функціонал не реалізовано)
return

ExtraFunc4:
    MsgBox, Виконати функцію 4 (Функціонал не реалізовано)
return
OpenPasswordMenu:
MsgBox, Тимчасово виклюено
return
LaunchUKRAINEGTA:
    FileReadLine, folderPath, road.ini, 1
    if (folderPath = "") {
        MsgBox, Помилка: Файл road.ini не існує, або не вибрана папка з UKRAINEGTA.
        return
    }

    ukrainegtaPath := folderPath . "\UKRAINEGTA.exe" ; Змініть розширення, якщо не .exe
    if !FileExist(ukrainegtaPath) {
        MsgBox, Файл %ukrainegtaPath% не знайдено!
        return
    }

    Run, %ukrainegtaPath%, , UseErrorLevel
    if (ErrorLevel) {
        MsgBox, Помилка при запуску файлу %ukrainegtaPath%!
    }
return
test1:
FileReadLine, filePath, road.ini, 1
if (filePath = "") {
MsgBox, Ошибка: Файл road.ini не содержит путь.
return
}
exePath := filePath "\game\UKRAINE GTA.exe"
mtasaUrl := "mtasa://stest.ukraine-gta.com.ua"
Run, % exePath " " mtasaUrl
return
server1:
FileReadLine, filePath, road.ini, 1
if (filePath = "") {
MsgBox, Ошибка: Файл road.ini не содержит путь.
return
}
exePath := filePath "\game\UKRAINE GTA.exe"
mtasaUrl := "mtasa://s1.ukraine-gta.com.ua"
Run, % exePath " " mtasaUrl
return
server2:
FileReadLine, filePath, road.ini, 1
if (filePath = "") {
MsgBox, Ошибка: Файл road.ini не содержит путь.
return
}
exePath := filePath "\game\UKRAINE GTA.exe"
mtasaUrl := "mtasa://s2.ukraine-gta.com.ua"
Run, % exePath " " mtasaUrl
return
server3:
FileReadLine, filePath, road.ini, 1
if (filePath = "") {
MsgBox, Ошибка: Файл road.ini не содержит путь.
return
}
exePath := filePath "\game\UKRAINE GTA.exe"
mtasaUrl := "mtasa://s3.ukraine-gta.com.ua"
Run, % exePath " " mtasaUrl
return
server4:
FileReadLine, filePath, road.ini, 1
if (filePath = "") {
MsgBox, Ошибка: Файл road.ini не содержит путь.
return
}
exePath := filePath "\game\UKRAINE GTA.exe"
mtasaUrl := "mtasa://s4.ukraine-gta.com.ua"
Run, % exePath " " mtasaUrl
return

server5:
FileReadLine, filePath, road.ini, 1
if (filePath = "") {
MsgBox, Ошибка: Файл road.ini не содержит путь.
return
}
exePath := filePath "\game\UKRAINE GTA.exe"
mtasaUrl := "mtasa://s5.ukraine-gta.com.ua"
Run, % exePath " " mtasaUrl
return

server6:
FileReadLine, filePath, road.ini, 1
if (filePath = "") {
MsgBox, Ошибка: Файл road.ini не содержит путь.
return
}
exePath := filePath "\game\UKRAINE GTA.exe"
mtasaUrl := "mtasa://s6.ukraine-gta.com.ua"
Run, % exePath " " mtasaUrl
return

normaAdmin:
Run, https://docs.google.com/spreadsheets/d/113Z8XUPeB5ARRweX-FyDhLQqvbb5eXhQ8MKk0z6Q104/edit?gid=0#gid=0  ; Replace with your actual forum URL
return

posibnik:
Run, https://sites.google.com/view/admteamulrainegta/головна-сторінка?authuser=0  ; Replace with your actual forum URL
return

whitelist:
State5:=!State5
If state5
{
Gui 6: +LastFound +AlwaysOnTop  +ToolWindow
Gui 6: Color, 000000
Gui 6: Font, s7, Arial Unicode MS
Gui 6: Font, cWhite
Gui 6: Add, Hotkey, x0 y0 w50 h18 vKeys30 Disabled, %Keys30%
Gui 6: ADD, TEXT,x60 y0 ,        %rep0%
Gui 6: Add, Hotkey, x0 y20 w50 h18 vKeys31 Disabled, %Keys31%
Gui 6: ADD, TEXT,x60 y20 ,        %rep1%
Gui 6: Add, Hotkey, x0 y40 w50 h18 vKeys32 Disabled, %Keys32%
Gui 6: ADD, TEXT,x60 y40 ,        %rep2%
Gui 6: Add, Hotkey, x0 y60 w50 h18 vKeys33 Disabled, %Keys33%
Gui 6: ADD, TEXT,x60 y60 ,        %rep3%
Gui 6: Add, Hotkey, x0 y80 w50 h18 vKeys34 Disabled, %Keys34%
Gui 6: ADD, TEXT,x60 y80 ,        %rep4%
Gui 6: Add, Hotkey, x0 y100 w50 h18 vKeys35 Disabled, %Keys35%
Gui 6: ADD, TEXT,x60 y100 ,        %rep5%
Gui 6: Add, Hotkey, x0 y120 w50 h18 vKeys36 Disabled, %Keys36%
Gui 6: ADD, TEXT,x60 y120 ,        %rep6%
Gui 6: Add, Hotkey, x0 y140 w50 h18 vKeys37 Disabled, %Keys37%
Gui 6: ADD, TEXT,x60 y140 ,        %rep7%
Gui 6: Add, Hotkey, x0 y160 w50 h18 vKeys38 Disabled, %Keys38%
Gui 6: ADD, TEXT,x60 y160 ,        %rep8%
Gui 6: Add, Hotkey, x0 y180 w50 h18 vKeys39 Disabled, %Keys39%
Gui 6: ADD, TEXT,x60 y180 ,        %rep9%
Gui 6: Add, Hotkey, x0 y200 w50 h18 vKeys40 Disabled, %Keys41%
Gui 6: ADD, TEXT,x60 y200 ,        %rep10%
Gui 6: Add, Hotkey, x0 y220 w50 h18 vKeys41 Disabled, %Keys41%
Gui 6: ADD, TEXT,x60 y220 ,        %rep11%
Gui 6: Add, Hotkey, x0 y240 w50 h18 vKeys42 Disabled, %Keys42%
Gui 6: ADD, TEXT,x60 y240 ,        %rep12%
Gui 6: Add, Hotkey, x0 y260 w50 h18 vKeys43 Disabled, %Keys43%
Gui 6: ADD, TEXT,x60 y260 ,        %rep13%



WinSet, TransColor, %CustomColor3% 200
Gui 6: Show, y10 NoActivate, Активні бінди
}
Else
{
Gui 6: Destroy
}
return
Help:
MsgBox, % 4+32+256, Технічна підтримка, Ви дійсно бажаєте перейти до технічної підтримки?
IfMsgBox, No
Return
Run https://t.me/Evgeniy_Pichkur
Return
Reload:
UrlDownloadToFile, https://github.com/a26898/7.7/blob/main/35.mp3?raw=true, % muzyka_5  := A_Temp "\muzyka_5.mp3"
SoundPlay,  % muzyka_5
Sleep 500
Reload
return
GuiClose:
UrlDownloadToFile, https://github.com/a26898/7.7/blob/main/20.mp3?raw=true, % muzyka_4  := A_Temp "\muzyka_1.mp3"
SoundPlay,  % muzyka_4
Sleep 500
ExitApp
server15:
UrlDownloadToFile, https://github.com/PizdaZaebali/pizdanahuibliat/blob/main/2.mp3?raw=true, % muzyka_7  := A_Temp "\muzyka_7.mp3"
SoundPlay,  % muzyka_7
Sleep 3500
return
ToggleMusic:
musicEnabled := !musicEnabled
if (musicEnabled) {
UrlDownloadToFile, https://github.com/PizdaZaebali/pizdanahuibliat/blob/main/gimn.mp3?raw=true, % gimn  := A_Temp "\gimn.mp3"
SoundPlay,  % gimn
} else {
SoundPlay, off
}
return
CheckboxToggle() {
global checkboxState
checkboxState := !checkboxState
}
:*?:тп1::
if (checkboxState) {
SendInput, /pwarp{space}
}
return
:*?:тп2::
if (checkboxState) {
SendInput, /get{space}
}
return
:*?:тпк1::
if (checkboxState) {
SendInput, /vgoto{space}
}
return
:*?:тпк2::
if (checkboxState) {
SendInput, /vget{space}
}
return
:*?:мут1::
if (checkboxState) {
SendInput, /pmute{space}
}
return
:*?:сп1::
if (checkboxState) {
SendInput, /sp{space}
}
return
:*?:фв1::
if (checkboxState) {
SendInput, /fixveh{space}
}
return
:*?:фл1::
if (checkboxState) {
SendInput, /flip{space}
}
return
:*?:ор1::
if (checkboxState) {
SendInput, /weapongive{space}
}
return