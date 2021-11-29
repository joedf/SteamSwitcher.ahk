;@Ahk2Exe-SetMainIcon res/icon.ico
;@Ahk2Exe-SetCopyright joedf (2021)
;@Ahk2Exe-SetDescription Simplest AHK based Steam account switcher.

#NoEnv
#Include <Steam>

Gui, Add, ListView, vLVA gLVA, Double-Click user name to set the account|
Gui, Show, , Steam Switcher
gosub, list_accounts
return

GuiClose:
ExitApp

list_accounts:
	acc:=Steam.GetAccountsList()
	for k, v in acc
		LV_Add("", k)
return

LVA:
	if (A_GuiEvent = "DoubleClick")  ; There are many other possible values the script can check.
	{
		LV_GetText(UserName, A_EventInfo, 1)
		if StrLen(UserName) > 3
		{
			GuiControl, Disable, LVA
			LV_Add()
			
			Steam.SetActiveUser(UserName)
			RestartSteam()
			
			ExitApp
		}
	}
return

RestartSteam() {
	Process, Exist , steam.exe
	if (pid:=ErrorLevel) {
		LV_Add("", "Restarting Steam, please wait ...")
		Steam.Exit()
		Process, WaitClose, %pid%, 5
		Sleep, 3000
	} else {
		LV_Add("", "Starting Steam, please wait ...")
	}
	Steam.Start()
}