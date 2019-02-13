using LuaInterface;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LuaCallUnity : MonoBehaviour {

	// Use this for initialization
	void Start () {
        LuaState state = new LuaState();
        SetLuaData(state);
        string path = Application.dataPath + "/ulua/Lua/Scripts/LuaCallUnity.lua";
        state.DoFile(path);
        LuaFunction f = state.GetFunction("myPrint");
        f.Call();
	}

    private void SetLuaData(LuaState state)
    {
        state["gameObject"] = gameObject;
    }

    // Update is called once per frame
    void Update () {
		
	}
}
