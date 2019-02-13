using LuaInterface;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class UntiyCallLua : MonoBehaviour {

	// Use this for initialization
	void Start () {
        LuaState state = new LuaState();
        state.DoString("print('hello lua')");
        string path = Application.dataPath + "/ulua/Lua/Scripts/UnityCallLua.lua";
        state.DoFile(path);
        // 获取全局表，变量，函数
        LuaFunction function = state.GetFunction("myPrint");
        function.Call(22);
        LuaTable table = state.GetTable("mytable");
        print(table["name"] + " " + table["age"]);
        string str = state.GetString("sex");
        print(str);
	}
	
	// Update is called once per frame
	void Update () {
		
	}
}
