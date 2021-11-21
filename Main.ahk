#NoEnv
#Include <Steam>

Gui, Add, ListView, gLAcc, Double-Click user name to set the account|
Gui, Show, , Steam Switcher

gosub, list_accounts
return

GuiClose:
ExitApp

list_accounts:
acc:=Steam.GetAccountsList()
for k, v in acc
{
	LV_Add("", k)
}
return

LAcc:
if (A_GuiEvent = "DoubleClick")  ; There are many other possible values the script can check.
{
    LV_GetText(UserName, A_EventInfo, 1)
	if StrLen(UserName) > 3
	{
		Steam.SetAutoLoginUser(UserName)
		Steam.SetAccountSettings(UserName, {WantsOfflineMode:0,SkipOfflineModeWarning:0})
		
		Process, Exist , steam.exe
		pid:= ErrorLevel
		if %pid%
		{
			Steam.Exit()
			Process, WaitClose, %pid%, 5
		}
		
		Steam.Start()
		
		ExitApp
	}
}
return
