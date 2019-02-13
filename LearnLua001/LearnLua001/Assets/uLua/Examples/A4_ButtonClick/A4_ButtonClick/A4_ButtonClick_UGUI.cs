using UnityEngine;
using System.Collections;
using LuaInterface;
using UnityEngine.UI;

public class A4_ButtonClick_UGUI : MonoBehaviour
{
    private Button button;

    private string script =
    @"
        function doClick()
            print('Button Click:>>>')
        end

        function TestClick(button)
            button.onClick.AddListener(doClick)
        end
    ";

    private string script1 =
        @" function doClick()
            print('Button Click:>>>')
        end

        function TestClick(button)
            button.onClick = doClick;
        end";

    // Use this for initialization
    void Start () {
        LuaScriptMgr mgr = new LuaScriptMgr();
        mgr.Start();
        mgr.DoString(script1);

        button = transform.Find("Button").GetComponent<Button>();

        LuaFunction func = mgr.GetLuaFunction("TestClick");
        func.Call(button);
        
	}

	// Update is called once per frame
	void Update () {

	}
}
