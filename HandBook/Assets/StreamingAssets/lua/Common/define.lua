
CtrlNames = {
	-- Prompt = "PromptCtrl",
	-- Message = "MessageCtrl",
	MainPanel = "MainPanelCtrl",
	ListPanel = "ListPanelCtrl",
	SearchPanel = "SearchPanelCtrl",
	FetchPwdPanel = "FetchPwdPanelCtrl",
	LoginPanel = "LoginPanelCtrl",
	SignUpPanel = "SignUpPanelCtrl"
}

PanelNames = {
	-- "PromptPanel",		
	-- "MessagePanel",		
	"MainPanel",			-- 1
	"ListPanel",			-- 2
	"SearchPanel",			-- 3
	"FetchPwdPanel",		-- 4
	"LoginPanel",			-- 5
	"SignUpPanel"			-- 6
}

ProductNames = {
	"管壳式换热器", 
	"净水器",
	"吸顶灯"
}

Urls = {	
	-- 1. params: (1). account, (2). password(md5), (3). code; 
	-- method: Post
	SignUp = "http://192.168.10.139/Account/AddOrUpdate?", 		
	-- 2. params (1). account, (2). password(md5);
	-- method: Post
	Login = "http://192.168.10.139/Account/Login?", 		
	-- 3. params (1). code, (2). account, (3). oldpassword(md5), (4). newpassword(md5); 
	-- method: Post
	UpdatePassword = "http://192.168.10.139/Account/UpdatePassword?",
	-- 4. params (1). phone, (2). type('1': SingUp, '2': UpdatePassword)
	-- method: Post
	SendSMS = "http://192.168.10.139/CommonComponents/SendSMS?",	
	-- 5. params 
	-- method: Post
	GetAllProductTypes = "http://192.168.10.139/ProductType/GetAllProductTypes", 
	-- 6. params (1). Name, (2). cateid, (3). keywords
	-- method: Get
	GetList = "http://192.168.10.139/Product/GetList?", 
	-- 7. params (1). keywords
	-- method: Get
	GetModelInfo = "http://192.168.10.139/Product/GetModelInfo?", 
}

--协议类型--
ProtocalType = {
	BINARY = 0,
	PB_LUA = 1,
	PBC = 2,
	SPROTO = 3,
}
--当前使用的协议类型--
TestProtoType = ProtocalType.BINARY;

Util = LuaFramework.Util;
AppConst = LuaFramework.AppConst;
LuaHelper = LuaFramework.LuaHelper;
ByteBuffer = LuaFramework.ByteBuffer;

resMgr = LuaHelper.GetResManager();
panelMgr = LuaHelper.GetPanelManager();
soundMgr = LuaHelper.GetSoundManager();
networkMgr = LuaHelper.GetNetManager();

WWW = UnityEngine.WWW;
GameObject = UnityEngine.GameObject;
Screen = UnityEngine.Screen;