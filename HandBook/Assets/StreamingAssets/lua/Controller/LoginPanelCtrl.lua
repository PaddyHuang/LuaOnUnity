require "Common/define"
require "Common/protocal"
local json = require "cjson"

LoginPanelCtrl = {}
local this = LoginPanelCtrl

local LuaBehaviour
local transform
local gameObject

-- 构造函数
function LoginPanelCtrl.New()
	-- logWarn("LoginPanelCtrl.New--->>")
	return this
end

function LoginPanelCtrl.Awake()
	-- logWarn("LoginPanelCtrl.Awake--->>")	
	panelMgr:CreatePanel('Login', this.OnCreate)	
end

-- 初始化面板
function LoginPanelCtrl.OnCreate(obj)	
	gameObject = obj
	transform = obj.transform

	LuaBehaviour = transform:GetComponent('LuaBehaviour')
	
	LuaBehaviour:AddClick(LoginPanel.skipBtn, this.OnSkipClick)	
	LuaBehaviour:AddClick(LoginPanel.nextBtn, this.OnNextClick)			
	LuaBehaviour:AddClick(LoginPanel.signUpBtn, this.OnSignUpClick)			
	LuaBehaviour:AddClick(LoginPanel.forgetPwdBtn, this.OnForgetPwdClick)	
end

-- 按键响应
-- 1. 跳过
function LoginPanelCtrl.OnSkipClick()	
	this.OnResetFunc()
	
	Util.Peer(transform, PanelNames[1]):SetActive(true)	
	gameObject:SetActive(false)
end

-- 2. 下一步
function LoginPanelCtrl.OnNextClick()			
	LoginPanel.noPhone:SetActive(false)
	LoginPanel.noPassword:SetActive(false)
	LoginPanel.wrongPassword:SetActive(false)
	LoginPanel.wrongPhone:SetActive(false)
	LoginPanel.noAccount:SetActive(false)
	
	if string.len(LoginPanel.phone.text) == 0 then
		LoginPanel.noPhone:SetActive(true)
		return
	elseif not this.CheckMobile(LoginPanel.phone.text) then 
		LoginPanel.wrongPhone:SetActive(true)		
		return
	elseif string.len(LoginPanel.password.text) == 0 then		
		LoginPanel.noPassword:SetActive(true)		
		return	
	end
	
	coroutine.start(this.Login)					
end

-- 匹配手机号
function LoginPanelCtrl.CheckMobile(str)
	return string.match(str,"[1][3,4,5,7,8]%d%d%d%d%d%d%d%d%d") == str
end

-- 接口方法
function LoginPanelCtrl.Login()
	local data = UnityEngine.WWWForm()
	data:AddField("account", LoginPanel.phone.text)
	data:AddField("password", Util.md5(LoginPanel.password.text))	
	
	local www = WWW(Urls.Login, data)
	coroutine.www(www)
	-- log(www.text)
	
	LuaHelper.OnJsonCallFunc(www.text, this.OnJsonCall)
end

function LoginPanelCtrl.OnJsonCall(text)
	local obj = json.decode(text)
    
	local message = obj['Message']
	
	if message == Protocal.Success then	
		print(message)									-- 登录成功操作
	elseif message == Protocal.WorongPassword then
		LoginPanel.wrongPassword:SetActive(true)
	elseif message == Protocal.NoAccount then
		LoginPanel.noAccount:SetActive(true)			
	end
end

-- 3. 去注册
function LoginPanelCtrl.OnSignUpClick()	
	this.OnResetFunc()
	
	Util.Peer(transform, PanelNames[6]):SetActive(true)	
	gameObject:SetActive(false)
end

-- 4. 忘记密码
function LoginPanelCtrl.OnForgetPwdClick()	
	this.OnResetFunc()

	Util.Peer(transform, PanelNames[4]):SetActive(true)	
	gameObject:SetActive(false)
end

-- 重置
function LoginPanelCtrl.OnResetFunc()
	LoginPanel.phone.text = ""
	LoginPanel.password.text = ""
	
	LoginPanel.noPhone:SetActive(false)
	LoginPanel.noPassword:SetActive(false)
	LoginPanel.wrongPhone:SetActive(false)
	LoginPanel.wrongPassword:SetActive(false)
	LoginPanel.noAccount:SetActive(false)
end