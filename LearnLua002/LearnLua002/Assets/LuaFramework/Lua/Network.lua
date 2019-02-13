Network = {}

-- 协议
Protocal = {
	Connect = '101';		-- 连接服务器
	Exception = '102';	-- 异常掉线
	Disconnect = '103';	-- 正常掉线
	Message = '104';		-- 接收信息
}

-- Socket消息
function Network.OnSocket(key, data)
	if key == 101 then 
		Luaframework.Util.Log('Socket Connect')
	else
		Luaframework.Util.Log('OnSocket other')
	end

end