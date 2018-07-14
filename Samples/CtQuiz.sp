#include <sourcemod>
#include <sdktools>
#include <cstrike>

Handle SwapTimers[MAXPLAYERS + 1];
bool g_bFailedQuiz[MAXPLAYERS + 1];

public void OnPluginStart()
{
	HookEvent("player_team", SwitchCT, EventHookMode_Post);
}

public Action SwitchCT(Event event, const char[] name, bool dontBroadcast)
{
	int iClient = GetClientOfUserId(event.GetInt("userid"));

	if (g_bFailedQuiz[iClient])
	{
		PrintToChat(iClient, "[CTQuiz] Sorry you have failed the CTQuiz and must wait 5 minutes before trying again");
		return Plugin_Stop;
	}
	else if(GetClientTeam(iClient) == CS_TEAM_CT && IsClientInGame(iClient) && IsPlayerAlive(iClient))
	{
		Menu CTQuiz = new Menu(MenuHandler_CTQuiz);
		CTQuiz.SetTitle("CTQuiz Question - Can you freekill?");
		CTQuiz.AddItem("Yes", "Yes");
		CTQuiz.AddItem("No", "No");
		CTQuiz.Display(iClient, 15);
	}
	return Plugin_Continue;
}

public int MenuHandler_CTQuiz(Menu menu, MenuAction action, int param1, int param2)
{
	if (action == MenuAction_Select)
	{
		char info[64];
		menu.GetItem(param2, info, sizeof(info));
		if(StrEqual(info, "No", false))
		{
			g_bFailedQuiz[param1] = false;
			PrintToChat(param1, "[CTQuiz] You have passed the CTQuiz");
		}else if(StrEqual(info, "Yes", false)){
			g_bFailedQuiz[param1] = true;
			ChangeClientTeam(param1, CS_TEAM_T);
			PrintToChat(param1, "[CTQuiz] Sorry you have failed the CTQuiz and now must wait 5 minutes before trying again");
			SwapTimers[param1] = CreateTimer(60.0 * 5, Timer_SwapClient, param2);
		}
	}
	else if (action == MenuAction_End)
	{
		delete menu;	
	}
	else if (action == MenuCancel_Timeout)
	{
		g_bFailedQuiz[param1] = true;
		ChangeClientTeam(param1, CS_TEAM_T);
		PrintToChat(param1, "[CTQuiz] Sorry you have failed the CTQuiz and now must wait 5 minutes before trying again");
		SwapTimers[param1] = CreateTimer(60.0 * 5, Timer_SwapClient, param2);
	}
}

public Action Timer_SwapClient(Handle timer, any client)
{
    if (IsClientInGame(client) && IsPlayerAlive(client) && GetClientTeam(client) == CS_TEAM_CT)
    {
    	g_bFailedQuiz[client] = false;
    }
    return Plugin_Stop;
}

public void OnClientDisconnect(int client)
{
	g_bFailedQuiz[client] = false;
	delete SwapTimers[client];
}
