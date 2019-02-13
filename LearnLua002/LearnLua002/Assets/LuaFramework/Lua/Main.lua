require "Network"

local go

--主入口函数。从这里开始lua逻辑
function Main()						
	-- LuaFramework.Util.Log("Hello World!")	
	
	-- 生成空物体go
	-- local go = UnityEngine.GameObject('go')
	-- go.transform.position = Vector3.one
	
	-- 加载cube
	local LuaHelper = LuaFramework.LuaHelper
	local resMgr = LuaHelper.GetResManager();
	resMgr:LoadPrefab('cube', {'Cube'}, OnLoadCubeFinish);	
	
	-- 加载panel
	resMgr:LoadPrefab('Panel', {'Panel'}, OnLoadPanelFinish)
	
	-- 网络测试
	local NetworkMgr = LuaHelper.GetNetManager()
	local AppConst = LuaFramework.AppConst
	
	AppConst.SocketPort = 1234
	AppConst.SocketAddress = "127.0.0.1"
	NetworkMgr:SendConnect();
end

-- 加载Cube完成后的回调
function OnLoadCubeFinish(objs)
	go = UnityEngine.GameObject.Instantiate(objs[0])
	LuaFramework.Util.Log("LoadFinish")
	
	-- LuaComponent.Add(go, CubeCmp)
	UpdateBeat:Add(CubeUpdate, self)
	
	-- 测试自定义API
	Test.Log()
end

-- 加载Panel完成后的回调
function OnLoadPanelFinish(objs)
	local panel = UnityEngine.GameObject.Instantiate(objs[0])
	local parent = UnityEngine.GameObject.FindWithTag("Canvas")
	panel.transform:SetParent(parent.transform)	
	panel.transform.position = Vector3(90,165.5,0)
	
	local button = panel.transform:Find("Button").gameObject
	ButtonEvent.AddClick(button, OnClick)
	
	LuaFramework.Util.Log("LoadFinish")	
end

-- 每帧执行
function CubeUpdate()
	LuaFramework.Util.Log("每帧执行")

	local Input = UnityEngine.Input
	local horizontal = Input.GetAxis("Horizontal")
	local vertical = Input.GetAxis("Vertical")
	
	local x = go.transform.position.x + horizontal
	local z = go.transform.position.z + vertical
	go.transform.position = Vector3.New(x, 0, z)	
end

-- Button Event
function OnClick()
	LuaFramework.Util.Log("Clicked")
end


--场景切换通知
function OnLevelWasLoaded(level)
	collectgarbage("collect")
	Time.timeSinceLevelLoad = 0
end

function OnApplicationQuit()
end