require "Common/define"
require "Common/protocal"
local json = require "cjson"

SignUpPanelCtrl = {}
local this = SignUpPanelCtrl

local LuaBehaviour
local transform
local gameObject

local text		-- 验证码倒计时文本
local timer		-- 计时器
local counting	-- 计时器Flag

-- 构造函数
function SignUpPanelCtrl.New()
	-- logWarn("SignUpPanelCtrl.New--->>")
	return this
end

function SignUpPanelCtrl.Awake()
	-- logWarn("SignUpPanelCtrl.Awake--->>")	
	panelMgr:CreatePanel('SignUp', this.OnCreate)	
end

-- 初始化面板
function SignUpPanelCtrl.OnCreate(obj)	
	gameObject = obj
	transform = obj.transform
		
	LuaBehaviour = transform:GetComponent('LuaBehaviour')
	
	LuaBehaviour:AddClick(SignUpPanel.skipBtn, this.OnSkipClick)
	LuaBehaviour:AddClick(SignUpPanel.identifyBtn, this.OnIdentifyClick)			
	LuaBehaviour:AddClick(SignUpPanel.nextBtn, this.OnNextClick)			
	LuaBehaviour:AddClick(SignUpPanel.loginBtn, this.OnLoginClick)	
	
	text = SignUpPanel.identifyBtn.transform:GetChild(0):GetComponent('Text')
	timer = Timer.New(this.OnTimerCallFunc, 1, -1, true)	

	gameObject:SetActive(false)
end
		
-- 按键响应
-- 1. 跳过
function SignUpPanelCtrl.OnSkipClick()
	this.OnResetFunc()
	
	Util.Peer(transform, PanelNames[1]):SetActive(true)	
	gameObject:SetActive(false)
end

-- 2. 获取验证码
function SignUpPanelCtrl.OnIdentifyClick()					
	FetchPwdPanel.wrongPhone:SetActive(false)	
	
	if string.len(SignUpPanel.phone.text) == 0 then
		return
	elseif not this.CheckMobile(SignUpPanel.phone.text) then
		SignUpPanel.wrongPhone:SetActive(true)	
		return
	end
	
	if not counting then
		coroutine.start(this.SendSMS)
		text.text = 60
		text.color = Color(39/255, 199/255, 153/255)
		timer:Start()		
	end	
end

-- 3. 下一步
function SignUpPanelCtrl.OnNextClick()		
	SignUpPanel.noPhone:SetActive(false)
	SignUpPanel.noPassword:SetActive(false)
	SignUpPanel.noIdentify:SetActive(false)
	SignUpPanel.wrongPhone:SetActive(false)
	SignUpPanel.accountAdded:SetActive(false)	
	SignUpPanel.wrongIdentify:SetActive(false)			
	
	if string.len(SignUpPanel.phone.text) == 0 then
		SignUpPanel.noPhone:SetActive(true)
		return	
	elseif not this.CheckMobile(SignUpPanel.phone.text) then
		SignUpPanel.wrongPhone:SetActive(true)
		-- this.OnTimerResetFunc()
		return
	elseif string.len(SignUpPanel.identify.text) == 0 then		
		SignUpPanel.noIdentify:SetActive(true)		
		return
	elseif string.len(SignUpPanel.password.text) == 0 then		
		SignUpPanel.noPassword:SetActive(true)		
		return	
	end
	
	-- 注册			
	coroutine.start(this.SignUp)	
end

-- 4. 去登录
function SignUpPanelCtrl.OnLoginClick()	
	this.OnResetFunc()

	Util.Peer(transform, PanelNames[5]):SetActive(true)	
	gameObject:SetActive(false)
end

-- 接口方法
-- 1. 注册接口
function SignUpPanelCtrl.SignUp()
	local data = UnityEngine.WWWForm()
	data:AddField("account", SignUpPanel.phone.text)
	data:AddField("password", Util.md5(SignUpPanel.password.text))
	data:AddField("code", SignUpPanel.identify.text)
	
	-- print('signup: '..Util.md5(SignUpPanel.password.text))
	
	local www = WWW(Urls.SignUp, data)
	coroutine.www(www)
	log(www.text)
	
	LuaHelper.OnJsonCallFunc(www.text, this.OnJsonCall)
end

function SignUpPanelCtrl.OnJsonCall(text)
	local obj = json.decode(text)
    
	local message = obj['Message']	
	if message == Protocal.Success then	
		print(message)									-- 注册成功操作
	elseif message == Protocal.AccountExsited then
		SignUpPanel.accountAdded:SetActive(true)
	elseif message == Protocal.CheckFailed then
		SignUpPanel.wrongIdentify:SetActive(true)			
	end
end

-- 2. 发送手机验证码
function SignUpPanelCtrl.SendSMS()	
	local data = UnityEngine.WWWForm()
	data:AddField("phone", SignUpPanel.phone.text)
	data:AddField("type", "1")
	
	local www = WWW(Urls.SendSMS, data)
	
	coroutine.www(www)		
	-- log(www.text)
	
	LuaHelper.OnJsonCallFunc(www.text, this.OnSMSJsonCall)
end

function SignUpPanelCtrl.OnSMSJsonCall(text)
	local obj = json.decode(text)
    
	local code = obj['Code']
	if code == 0 then	
		-- 临时方法
		SignUpPanel.identify.text = obj['Result']['Captcha']
	-- elseif code == -1 then
		-- returnError.text = obj['Message']		
	end
end

-- 匹配手机号
function SignUpPanelCtrl.CheckMobile(str)
	return string.match(str,"[1][3,4,5,7,8]%d%d%d%d%d%d%d%d%d") == str
end

-- 计时器响应
-- 1. 计时器调用
function SignUpPanelCtrl.OnTimerCallFunc()
	text.text = text.text - 1
	counting = true
	if text.text == '0' then
		timer:Stop()
		counting = false
		
		text.text = "重新获取"
	end
end

-- 2. 计时器重置
function SignUpPanelCtrl.OnTimerResetFunc()
	timer:Stop()
	counting = false
	text.text = "获取验证码"
	text.color = Color(187/255, 187/255, 187/255)
end

-- 重置
function SignUpPanelCtrl.OnResetFunc()
	SignUpPanel.phone.text = ""
	SignUpPanel.identify.text = ""
	SignUpPanel.password.text = ""	
	
	this.OnTimerResetFunc()
	
	SignUpPanel.noPhone:SetActive(false)
	SignUpPanel.noPassword:SetActive(false)
	SignUpPanel.noIdentify:SetActive(false)
	SignUpPanel.wrongPhone:SetActive(false)
	SignUpPanel.accountAdded:SetActive(false)	
	SignUpPanel.wrongIdentify:SetActive(false)			
end