using LuaInterface;
using System.Collections;
using UnityEngine;
using LuaFramework;

public class LuaComponent : MonoBehaviour {
        
    public LuaTable table;

    /// <summary>
    /// 添加Lua组件
    /// </summary>
    /// <param name="go"></param>
    /// <param name="tableClass"></param>
    /// <returns></returns>
    public static LuaTable Add(GameObject go, LuaTable tableClass)
    {
        LuaFunction function = tableClass.GetLuaFunction("New");
        if (function == null)
        {
            return null;
        }
        //object[] rets = function.Call(tableClass);
        //if (rets.Length != 1)
        //{
        //    return null;
        //}
        if (tableClass == null)
        {
            return null;
        }        
        LuaComponent component = go.AddComponent<LuaComponent>();
        //component.table = (LuaTable)rets[0];
        component.table = tableClass;
        component.CallAwake();
        return component.table;        
    }

    /// <summary>
    /// 获取Lua组件
    /// </summary>
    /// <param name="go"></param>
    /// <param name="table"></param>
    /// <returns></returns>
    public static LuaTable Get(GameObject go, LuaTable table)
    {
        LuaComponent[] components = go.GetComponents<LuaComponent>();
        foreach (LuaComponent component in components)
        {
            string mat1 = table.ToString();
            string mat2 = component.table.GetMetaTable().ToString();
            if (mat1 == mat2)
            {
                return component.table;
            }
        }
        return null;
    }

    void CallAwake()
    {
        LuaFunction function = table.GetLuaFunction("Awake");
        if (function != null)
        {
            function.Call(table, gameObject);
            Debug.LogWarning("Awake");
        }
    }

	// Use this for initialization
	void Start () {
        LuaFunction function = table.GetLuaFunction("Start");
        if (function != null)
        {
            function.Call(table, gameObject);
        }
        Debug.LogWarning("Start");
	}
	
	// Update is called once per frame
	void Update () {
        // 效率问题有待测试和优化
        // 可在Lua中调用UpdateBeat替代
        LuaFunction function = table.GetLuaFunction("Update");
        if (function != null)
        {
            function.Call(table, gameObject);
        }
    }
}
