using LuaInterface;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class _001_Echo : MonoBehaviour {

    //private string path = Application.dataPath + "/ulua/Lua/Scripts/001_Echo/_001_Echo.lua";

    string source = @"
        Echo.echo();
    ";

	// Use this for initialization
	void Start () {
        //LuaScriptMgr mgr = new LuaScriptMgr();
        //mgr.Start();
        //LuaState state = mgr.lua;
        LuaState state = new LuaState();
        state.DoString(source);

	}
	
	// Update is called once per frame
	void Update () {
		
	}        
}
