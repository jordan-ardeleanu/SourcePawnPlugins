#include <sourcemod>
#include <sdktools>
#include <cstrike>

int g_wardentaken = 0;
int g_warden;

public void OnPluginStart()
{
	RegConsoleCmd("sm_warden", Command_Warden, "Takes warden");
	RegConsoleCmd("sm_unwarden", Command_UnWarden);
	HookEvent("player_death", Event_WardenDeath, EventHookMode_Pre);
}

public Action Command_Warden(int iClient, int iArgs)
{
	if(IsPlayerAlive(iClient) && GetClientTeam(iClient) == CS_TEAM_CT && g_wardentaken == 0)
	{
		g_wardentaken = 1;
		g_warden = iClient;
		SetEntityRenderColor(iClient, 0, 0, 255, 255);
		PrintToChat(iClient, "[Warden] You are now the warden");
		PrintToChatAll("[Warden] %N has taken warden", iClient);
	}else{
		PrintToChat(iClient, "[Warden] You cannot take warden");
	}
}

public Action Command_UnWarden(int iClient, int iArgs)
{
	if(IsPlayerAlive(iClient) && GetClientTeam(iClient) == CS_TEAM_CT && g_warden == iClient)
	{
		g_warden = -1;
		g_wardentaken = 0;
		SetEntityRenderColor(iClient, 0, 0, 0, 0);
		PrintToChatAll("[Warden] %N has unwardened", iClient);
	}else{
		PrintToChat(iClient, "[Warden] You cannot unwarden, as you are not the warden");
	}
}

public void Event_WardenDeath(Event event, const char[] name, bool dontBroadcast)
{
	int client = GetClientOfUserId(event.GetInt("userid"))
	PrintToChatAll("[Warden] %N is dead. You can now take warden", client)
	g_wardentaken = 0;
}



