#include <sourcemod>
#include <sdktools>

public void OnPluginStart()
{
	RegConsoleCmd("sm_colormenu", Command_ColorMenu, "Opens a Menu to pick your Color")
}

public Action Command_ColorMenu(int iClient, int iArgs)
{
	if(iArgs)
	{
		ReplyToCommand(iClient, "[SM] Usage: sm_colormenu");
		return Plugin_Handled;
	}
	
	ShowColorMenu(iClient);
	return Plugin_Handled;
}

void ShowColorMenu(int iClient)
{
	if (IsClientInGame(iClient) && IsPlayerAlive(iClient))
	{
		Menu ColorMenu = new Menu(MenuHandler_Color);
		ColorMenu.SetTitle("Color Menu");
		ColorMenu.AddItem("Red", "Red");
		ColorMenu.AddItem("Blue", "Blue");
		ColorMenu.AddItem("Green", "Green");
		ColorMenu.AddItem("Black", "Black");
		ColorMenu.AddItem("White", "Reset");
		ColorMenu.Display(iClient, MENU_TIME_FOREVER);
	}
}

public int MenuHandler_Color(Menu menu, MenuAction action, int param1, int param2)
{
	if (action == MenuAction_Select)
	{
			char info[64];
			menu.GetItem(param2, info, sizeof(info));
			if(StrEqual(info, "Red", false))
			{
				SetEntityRenderColor(param1, 255, 0, 0, 255);
				PrintToChat(param1, "[ColorMenu] Your player color has been set to Red");
			}
			else if(StrEqual(info, "Blue", false)){
				SetEntityRenderColor(param1, 0, 0, 255, 255);
				PrintToChat(param1, "[ColorMenu] Your player color has been set to Blue");
			}
			else if(StrEqual(info, "Green", false)){
				SetEntityRenderColor(param1, 0, 255, 0, 255);
				PrintToChat(param1, "[ColorMenu] Your player color has been set to Green");
			}
			else if(StrEqual(info, "Black", false)){
				SetEntityRenderColor(param1, 0, 0, 0, 255);
				PrintToChat(param1, "[ColorMenu] Your player color has been set to Black");
			}
				else if(StrEqual(info, "White", false)){
				SetEntityRenderColor(param1, 255, 255, 255, 255);
				PrintToChat(param1, "[ColorMenu] Your player color has been Reset");
			}
		}
	else if (action == MenuAction_End)
	{
		delete menu;	
	}
}