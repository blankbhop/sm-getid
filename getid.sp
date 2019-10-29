#include <sourcemod>

EngineVersion Engine = Engine_Unknown;

public Plugin myinfo = 
{
	name = "GetID",
	author = "Blank, pow",
	description = "Gets SteamID",
	version = "1.0",
	url = ""
}

public void OnPluginStart()
{
	Engine = GetEngineVersion();
	
	RegConsoleCmd("sm_getid", SM_GetID, "");
	RegConsoleCmd("sm_findid", SM_GetID, "");
	RegConsoleCmd("sm_steamid", SM_GetID, "");
}

public Action SM_GetID(int client, int args)
{
	char cName[64];
	GetClientName(client, cName, sizeof(cName));
	char b_prefix[64];
	char b_text[64];
	char b_var[64];
	if(Engine == Engine_CSS)
	{
		FormatEx(b_prefix, sizeof(b_prefix), "\x07dbdbdb[\x0700dd00GetID\x07dbdbdb] ");
		FormatEx(b_text, sizeof(b_text), "\x07dbdbdb");
		FormatEx(b_var, sizeof(b_var), "\x0700dd00");
	}
	else if(Engine == Engine_CSGO)
	{
		FormatEx(b_prefix, sizeof(b_prefix), " \x01[\x04GetID\x01] ");
		FormatEx(b_text, sizeof(b_text), " \x01");
		FormatEx(b_var, sizeof(b_var), " \x04");
	}
	if(args == 0)
	{
		char SelfIDSteamEngine[32];
		GetClientAuthId(client, AuthId_Engine, SelfIDSteamEngine, 32);
		char SelfIDSteam2[32];
		GetClientAuthId(client, AuthId_Steam2, SelfIDSteam2, 32);
		char SelfIDSteam3[32];
		GetClientAuthId(client, AuthId_Steam3, SelfIDSteam3, 32);
		char SelfIDSteam64[32];
		GetClientAuthId(client, AuthId_SteamID64, SelfIDSteam64, 32);
		if(Engine == Engine_CSS)
		{
			SayText2(client, "%s - Player: %s\nSteam2 ID: %s%s\n%sSteam3 ID: %s%s\n%sSteam64 ID: %s%s", b_prefix, cName, b_var, SelfIDSteam2, b_text, b_var, SelfIDSteam3, b_text, b_var, SelfIDSteam64);
		}
		else if(Engine == Engine_CSGO)
		{
			PrintToChat(client, "%s - Player: %s\n", b_prefix, cName);
			PrintToChat(client, "Steam2 ID: %s%s\n", b_var, SelfIDSteam2);
			PrintToChat(client, "%sSteam3 ID: %s%s\n", b_text, b_var, SelfIDSteam3);
			PrintToChat(client, "%sSteam64 ID: %s%s\n", b_text, b_var, SelfIDSteam64);
		}
	}
	else
	{
		char arguments[24];
		GetCmdArg(1, arguments, sizeof(arguments));
		int iTarget = FindTarget(client, arguments, true, false);
		GetClientName(iTarget, cName, sizeof(cName));
		char SIDSteamEngine[32];
		GetClientAuthId(iTarget, AuthId_Engine, SIDSteamEngine, 32);
		char SIDSteam2[32];
		GetClientAuthId(iTarget, AuthId_Steam2, SIDSteam2, 32);
		char SIDSteam3[32];
		GetClientAuthId(iTarget, AuthId_Steam3, SIDSteam3, 32);
		char SIDSteam64[32];
		GetClientAuthId(iTarget, AuthId_SteamID64, SIDSteam64, 32);
		if(Engine == Engine_CSS)
		{
			SayText2(client, "%s - Player: %s\nSteam2 ID: %s%s\n%sSteam3 ID: %s%s\n%sSteam64 ID: %s%s", b_prefix, cName, b_var, SIDSteam2, b_text, b_var, SIDSteam3, b_text, b_var, SIDSteam64);
		}
		else if(Engine == Engine_CSGO)
		{
			PrintToChat(client, "%s - Player: %s\n", b_prefix, cName);
			PrintToChat(client, "Steam2 ID: %s%s\n", b_var, SIDSteam2);
			PrintToChat(client, "%sSteam3 ID: %s%s\n", b_text, b_var, SIDSteam3);
			PrintToChat(client, "%sSteam64 ID: %s%s\n", b_text, b_var, SIDSteam64);
		}
	}
}

stock SayText2(int client, char[] message, any:...)
{
	Handle hBf = StartMessageOne("SayText2", client, USERMSG_RELIABLE);
	if (!hBf) return;
	char buffer[2048];
	VFormat(buffer, sizeof(buffer), message, 3);
	BfWriteByte(hBf, client);
	BfWriteByte(hBf, true);
	BfWriteString(hBf, buffer);
	EndMessage();
}