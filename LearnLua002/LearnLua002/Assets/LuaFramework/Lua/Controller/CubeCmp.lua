CubeCmp = 
{
	Hp = 100,
	att = 50,
	name = "good cube"
}

function CubeCmp:Awake()
	print("CubeCmp Awake name = " .. self.name)
end

function CubeCmp:Start()
	print("CubeCmp Start name = " .. self.name)
end

function CubeCmp:Update(gameObject)
	print("CubeCmp Update name = " .. self.name)
	
	LuaFramework.Util.Log("每帧执行")

	local Input = UnityEngine.Input
	local horizontal = Input.GetAxis("Horizontal")
	local vertical = Input.GetAxis("Vertical")
	
	local x = gameObject.transform.position.x + horizontal
	local z = gameObject.transform.position.z + vertical
	gameObject.transform.position = Vector3.New(x, 0, z)	
end

-- 创建对象
function CubeCmp:New(obj)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	return o
end