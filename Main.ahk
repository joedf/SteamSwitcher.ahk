#NoEnv
#Include <Steam>

Gui, Add, ListView, vLAcc gLAcc, Double-Click user name to set the account|
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
		GuiControl, Disable, LAcc
		LV_Add()
		
		Steam.SetAutoLoginUser(UserName)
		Steam.SetAccountSettings(UserName, {WantsOfflineMode:0,SkipOfflineModeWarning:0})
		
		Process, Exist , steam.exe
		pid:= ErrorLevel
		if %pid%
		{
			LV_Add("", "Restarting Steam, please wait ...")
			Steam.Exit()
			Process, WaitClose, %pid%, 5
			Sleep, 3000
		} else {
			LV_Add("", "Starting Steam, please wait ...")
		}
		
		Steam.Start()
		
		ExitApp
	}
}
return
