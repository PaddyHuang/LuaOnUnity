-- 加载的Cube
local go

--主入口函数。从这里开始lua逻辑
function Main()						
	-- LuaFramework.Util.Log("Hello World!")	
	
	-- 生成空物体go
	-- local go = UnityEngine.GameObject('go')
	-- go.transform.position = Vector3.one
	
	-- 加载cube
	LuaHelper = LuaFramework.LuaHelper
	resMgr = LuaHelper.GetResManager();
	resMgr:LoadPrefab('cube', {'Cube'}, OnLoadFinish);	
	
end

-- 加载完成后的回调
function OnLoadFinish(objs)
	go = UnityEngine.GameObject.Instantiate(objs[0])
	LuaFramework.Util.Log("LoadFinish")
	
	LuaComponent.Add(go, CubeCmp)
	-- UpdateBeat:Add(Update, self)
	
	-- 测试自定义API
	Test.Log()
end

-- 每帧执行
-- function Update()
	-- LuaFramework.Util.Log("每帧执行")

	-- local Input = UnityEngine.Input
	-- local horizontal = Input.GetAxis("Horizontal")
	-- local vertical = Input.GetAxis("Vertical")
	
	-- local x = go.transform.position.x + horizontal
	-- local z = go.transform.position.z + vertical
	-- go.transform.position = Vector3.New(x, 0, z)	
-- end

--场景切换通知
function OnLevelWasLoaded(level)
	collectgarbage("collect")
	Time.timeSinceLevelLoad = 0
end

function OnApplicationQuit()
end