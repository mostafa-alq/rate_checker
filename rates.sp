// cl_interp 0
// cl_interp_ratio 0
// rate 300000
// cl_updaterate 100
// cl_cmdrate 100

#include <sourcemod>

public void OnPluginStart()
{
  for(int i = 0; i < MAXPLAYERS; i++) {
    int client = i;
    QueryClientConVar(client, cl_interp, fetchInterp);
    QueryClientConVar(client, cl_interp_ratio, fetchInterpRatio);
    QueryClientConVar(client, rate, fetchRate);
    QueryClientConVar(client, cl_updaterate, fetchUpdateRate);
    QueryClientConVar(client, cl_cmdrate, fetchCmdRate);
  }
  int crate[5] = {0, 0, 300000, 100, 100}
}
public void fetchInterp(QueryCookie cookie, int client, ConVarQueryResult result, const char[] cvarName, const char[] cvarValue)
{
  int linterp = StringToInt(cvarValue)
}
public void fetchInterpRatio(QueryCookie cookie, int client, ConVarQueryResult result, const char[] cvarName, const char[] cvarValue)
{
  int linterpRatio = StringToInt(cvarValue)
}
public void fetchRate(QueryCookie cookie, int client, ConVarQueryResult result, const char[] cvarName, const char[] cvarValue)
{
  int lrate = StringToInt(cvarValue)
}
public void fetchUpdateRate(QueryCookie cookie, int client, ConVarQueryResult result, const char[] cvarName, const char[] cvarValue)
{
  int lupdateRate = StringToInt(cvarValue)
}
public void fetchCmdRate(QueryCookie cookie, int client, ConVarQueryResult result, const char[] cvarName, const char[] cvarValue)
{
  int lcmdRate = StringToInt(cvarValue)
}


public Action sm_ratechecks(int client, int args)
{
  if (linterp != crate[0] && linterpRatio != crate[1] && lrate != crate[2] && lupdateRate != crate[3] && lcmdRate != crate[4])
  {
    // If rates are incorrect, send client to spectate 
    PrintToChat(client, "Sent to spec because one or more of your rate variables are incorrect.");
    ChangeClientTeam(client, 1)
  }
  if (rate[0] != crate[0])
  {
    PrintToConsole(client, "Type cl_interp 0 in the console.");
  }
  if (rate[1] != crate[1])
  {
    PrintToConsole(client, "Type cl_interp_ratio 0 in the console.");
  }
  if (rate[2] != crate[2])
  {
    PrintToConsole(client, "Type rate 300000 in the console.");
  }
  if (rate[3] != crate[3])
  {
    PrintToConsole(client, "Type cl_updaterate 100 in the console.");
  }
  if (rate[4] != crate[4])
  {
    PrintToConsole(client, "Type cl_cmdrate 100 in the console.");
  }
  return Plugin_Handled
}
