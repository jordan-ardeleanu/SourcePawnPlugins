#include <sourcemod>
#include <sdktools>

 public void OnPluginStart()
{
    RegConsoleCmd("sm_info", Command_Info, "Prints All SteamID's on the Server");
}

public Action Command_Info(int client,int args)
{
	char ip[64];
	char steamid[64];
	GetClientIP(client, ip, sizeof(ip));
	GetClientAuthId(client, AuthId_Steam2, steamid, sizeof(steamid));
	PrintToChat(client, "%N, %s, %s", client, steamid, ip);
	return Plugin_Handled;
} 