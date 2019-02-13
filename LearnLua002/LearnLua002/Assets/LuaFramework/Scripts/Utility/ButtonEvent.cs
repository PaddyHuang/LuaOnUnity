using LuaInterface;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ButtonEvent {

    /// <summary>
    /// 添加按键监听
    /// </summary>
    /// <param name="go"></param>
    /// <param name="function"></param>
	public static void AddClick(GameObject go, LuaFunction function)
    {
        if (go == null || function == null)
            return;

        Button button = go.GetComponent<Button>();
        if (button == null)
            return;

        button.onClick.AddListener
            (
                delegate ()
                {
                    function.Call(go);
                }
            );
    }

    /// <summary>
    /// 清除监听
    /// </summary>
    /// <param name="go"></param>
    public static void ClearClick(GameObject go)
    {
        if (go == null)
            return;

        Button button = go.GetComponent<Button>();
        if (button == null)
            return;

        button.onClick.RemoveAllListeners();
    }
}
