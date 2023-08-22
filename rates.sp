#include <sourcemod>

#define MAXPLAYER MAXPLAYERS + 1

public Plugin myinfo = 
{
    name = "lemmunz",
    author = "lemmunz",
    description = "Rate Validator",
    version = "0.1",
    url = "https://github.com/mostafa-alq/rateChecker"
};

public void OnPluginStart()
{
    for(int i = 1; i <= MaxClients; i++)
    {
        if(IsClientInGame(i) == true)
        {
            OnClientPutInServer(i);
        }
    }
    RegConsoleCmd("sm_rate", fnPrintRate);
    RegConsoleCmd("sm_rates", fnPrintRate);
    RegConsoleCmd("sm_askkindly", fnAskKindly);
    RegConsoleCmd("sm_lerp", fnSetLerp);
    return;
}

public void OnClientPutInServer(int client)
{
    if(IsFakeClient(client) == false)
    {
        CreateTimer(5.0, fnSetRate, client, TIMER_FLAG_NO_MAPCHANGE);
    }
    return;
}

public Action fnSetLerp(int client, int args)
{
    if (args < 1)
    {
        ReplyToCommand(client, "[SM] Usage: sm_lerp <arg>");
        return Plugin_Handled;
    }
    ChangeClientTeam(client, 1);
    ClientCommand(client, "cl_interp %s", args)
    ClientCommand(client, "cl_interp_ratio 0")
    ClientCommand(client, "rate 300000")
    ClientCommand(client, "cl_updaterate 100")
    ClientCommand(client, "cl_cmdrate 100")
    ChangeClientTeam(client, 0);
    return Plugin_Handled
}

public Action fnSetRate(Handle timer, int client)
{
    ChangeClientTeam(client, 1);
    ClientCommand(client, "cl_interp 0")
    ClientCommand(client, "cl_interp_ratio 0")
    ClientCommand(client, "rate 300000")
    ClientCommand(client, "cl_updaterate 100")
    ClientCommand(client, "cl_cmdrate 100")
    ChangeClientTeam(client, 0);
    return Plugin_Handled
}

public Action fnAskKindly(int client, int args)
{
    
    char interp[8] = "";
    char interp_ratio[8] = "";
    char rate[32] = "";
    char updaterate[8] = "";
    char cmdrate[8] = "";
    

    GetClientInfo(client, "cl_interp", interp, sizeof(interp));
    GetClientInfo(client, "cl_interp_ratio", interp_ratio, sizeof(interp_ratio));
    GetClientInfo(client, "rate", rate, sizeof(rate));
    GetClientInfo(client, "cl_updaterate", updaterate, sizeof(updaterate));
    GetClientInfo(client, "cl_cmdrate", cmdrate, sizeof(cmdrate));
    
    float finterp = StringToFloat(interp);
    int finterp_ratio = StringToInt(interp_ratio);
    int frate = StringToInt(rate);
    int fupdaterate = StringToInt(updaterate);
    int fcmdrate = StringToInt(cmdrate);

    char finterpStr[32] = "";
    char finterp_ratioStr[32] = "";
    char frateStr[32] = "";
    char fupdaterateStr[32] = ""
    char fcmdrateStr[32] = ""

    if (finterp >= 0.01 || finterp_ratio > 0 || frate < 300000 || fupdaterate < 100 || fcmdrate < 100)
    {
        // If rates are incorrect, send client to spectate 
        PrintToChat(client, "Sent to spectate because one or more of your rate variables are incorrect.");
        ChangeClientTeam(client, 1);
    }
    if (finterp >= 0.0)
    {
        finterpStr = "cl_interp 0;"
    }
    if (finterp_ratio > 0)
    {
        finterp_ratioStr = "cl_interp_ratio 0;"
    }
    if (frate < 300000)
    {
        frateStr = "rate 300000;" 
    }
    if (fupdaterate < 100)
    {
        fupdaterateStr = "cl_updaterate 100;"
    }
    if (fcmdrate < 100)
    {
        fcmdrateStr = "cl_cmdrate 100;"
    }
    PrintToConsole(client, "Copy and paste this command: %s %s %s %s %s", finterpStr, finterp_ratioStr, frateStr, fupdaterateStr, fcmdrateStr)
    return Plugin_Handled
}

public Action fnPrintRate(int client, int args)
{
    char interp[8] = "";
    char interp_ratio[8] = "";
    char rate[32] = "";
    char updaterate[8] = "";
    char cmdrate[8] = "";

    GetClientInfo(client, "cl_interp", interp, sizeof(interp));
    GetClientInfo(client, "cl_interp_ratio", interp_ratio, sizeof(interp_ratio));
    GetClientInfo(client, "rate", rate, sizeof(rate));
    GetClientInfo(client, "cl_updaterate", updaterate, sizeof(updaterate));
    GetClientInfo(client, "cl_cmdrate", cmdrate, sizeof(cmdrate));

    PrintToConsole(client, "//////////////////////////////////////////////////////////////////////////////////////////////////////");
    PrintToConsole(client, "Interp: %s. Interp ratio: %s. Rate: %s. Update rate: %s. CMD rate: %s", interp, interp_ratio, rate, updaterate, cmdrate);
    PrintToConsole(client, "//////////////////////////////////////////////////////////////////////////////////////////////////////");
    return Plugin_Handled
}
