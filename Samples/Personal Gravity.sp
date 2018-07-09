#include <sourcemod>
#include <sdktools>

public void OnPluginStart()
{
	RegConsoleCmd("sm_Lowgrav", Command_LowGrav, "Makes your gravity half of regular amount");
	RegConsoleCmd("sm_Doublegrav", Command_DoubleGrav, "Makes your gravity double of regular");
	RegConsoleCmd("sm_Resetgravity", Command_ResetGrav, "Resets your gravity");
}

public Action Command_LowGrav(int iClient, int iArgs)
{
	SetEntityGravity(iClient, 0.5);
	SetEntityRenderColor(iClient, 0, 0, 255, 255);
	return Plugin_Handled;
}

public Action Command_DoubleGrav(int iClient, int iArgs)
{
	SetEntityGravity(iClient, 2.0);
	SetEntityRenderColor(iClient, 0, 255, 0, 255);
	return Plugin_Handled;
}

public Action Command_ResetGrav(int iClient, int iArgs)
{
	SetEntityGravity(iClient, 1.0);
	SetEntityRenderColor(iClient, 255, 255, 255, 255);
	return Plugin_Handled;
}
