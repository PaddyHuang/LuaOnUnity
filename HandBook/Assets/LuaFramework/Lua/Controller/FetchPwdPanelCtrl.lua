require "Common/define"
require "Common/protocal"
local json = require "cjson"

FetchPwdPanelCtrl = {}
local this = FetchPwdPanelCtrl

local LuaBehaviour
local transform
local gameObject

local text		-- 验证码倒计时文本
local timer		-- 计时器
local counting	-- 计时器Flag

-- 构造函数
function FetchPwdPanelCtrl.New()
	-- logWarn("FetchPwdPanelCtrl.New--->>")
	return this
end

function FetchPwdPanelCtrl.Awake()
	-- logWarn("FetchPwdPanelCtrl.Awake--->>")	
	panelMgr:CreatePanel('FetchPwd', this.OnCreate)	
end

-- 初始化面板
function FetchPwdPanelCtrl.OnCreate(obj)	
	gameObject = obj
	transform = obj.transform
		
	LuaBehaviour = transform:GetComponent('LuaBehaviour')
	
	LuaBehaviour:AddClick(FetchPwdPanel.backBtn, this.OnBackClick)
	LuaBehaviour:AddClick(FetchPwdPanel.skipBtn, this.OnSkipClick)						
	LuaBehaviour:AddClick(FetchPwdPanel.identifyBtn, this.OnIdentifyClick)			
	LuaBehaviour:AddClick(FetchPwdPanel.nextBtn, this.OnNextClick)			
	LuaBehaviour:AddClick(FetchPwdPanel.loginBtn, this.OnLoginClick)		
	
	text = FetchPwdPanel.identifyBtn.transform:GetChild(0):GetComponent('Text')
	timer = Timer.New(this.OnTimerCallFunc, 1, -1, true)	

	gameObject:SetActive(false)
end

-- 按键响应
-- 1. 返回
function FetchPwdPanelCtrl.OnBackClick()
	this.OnResetFunc()

	Util.Peer(transform, PanelNames[5]):SetActive(true)	
	gameObject:SetActive(false)
end

-- 2. 跳过
function FetchPwdPanelCtrl.OnSkipClick()	
	this.OnResetFunc()

	Util.Peer(transform, PanelNames[1]):SetActive(true)	
	gameObject:SetActive(false)
end

-- 3. 获取验证码
function FetchPwdPanelCtrl.OnIdentifyClick()	
	FetchPwdPanel.wrongPhone:SetActive(false)	
	
	if string.len(FetchPwdPanel.phone.text) == 0 then
		return
	elseif not this.CheckMobile(FetchPwdPanel.phone.text) then
		FetchPwdPanel.wrongPhone:SetActive(true)
		return
	end
	
	if not counting then
		coroutine.start(this.SendSMS)
		text.text = 60
		text.color = Color(39/255, 199/255, 153/255)
		timer:Start()		
	end	
end

-- 4. 下一步
function FetchPwdPanelCtrl.OnNextClick()	
	FetchPwdPanel.noPhone:SetActive(false)
	FetchPwdPanel.noPassword:SetActive(false)
	FetchPwdPanel.noIdentify:SetActive(false)
	FetchPwdPanel.wrongPhone:SetActive(false)	
	FetchPwdPanel.samePassword:SetActive(false)	
	FetchPwdPanel.wrongPassword:SetActive(false)
	FetchPwdPanel.noAccount:SetActive(false)	
		
	if string.len(FetchPwdPanel.phone.text) == 0 then
		FetchPwdPanel.noPhone:SetActive(true)
		return	
	elseif not this.CheckMobile(FetchPwdPanel.phone.text) then
		FetchPwdPanel.wrongPhone:SetActive(true)
		return
	elseif string.len(FetchPwdPanel.identify.text) == 0 then		
		FetchPwdPanel.noIdentify:SetActive(true)		
		return
	elseif string.len(FetchPwdPanel.oldPassword.text) == 0 or string.len(FetchPwdPanel.newPassword.text) == 0 then		
		FetchPwdPanel.noPassword:SetActive(true)		
		return	
	elseif FetchPwdPanel.oldPassword.text == FetchPwdPanel.newPassword.text then		
		FetchPwdPanel.samePassword:SetActive(true)		
		return	
	end
	
	coroutine.start(this.UpdatePassword)		
end

-- 5. 去登录
function FetchPwdPanelCtrl.OnLoginClick()	
	this.OnResetFunc()

	Util.Peer(transform, PanelNames[5]):SetActive(true)	
	gameObject:SetActive(false)
end
	
-- 接口方法
-- 1. 修改密码
function FetchPwdPanelCtrl.UpdatePassword()
	local data = UnityEngine.WWWForm()
	data:AddField("code", FetchPwdPanel.identify.text)
	data:AddField("account", FetchPwdPanel.phone.text)	
	data:AddField("oldpassword", Util.md5(FetchPwdPanel.oldPassword.text))
	data:AddField("newpassword", Util.md5(FetchPwdPanel.newPassword.text))
	
	-- print('old: '..Util.md5(FetchPwdPanel.oldPassword.text))
	-- print('new: '..Util.md5(FetchPwdPanel.newPassword.text))
	
	local www = WWW(Urls.UpdatePassword, data)
	
	coroutine.www(www)	
	log(www.text)
	
	LuaHelper.OnJsonCallFunc(www.text, this.OnJsonCall)
end

function FetchPwdPanelCtrl.OnJsonCall(text)
	local obj = json.decode(text)
    
	local message = obj['Message']
	
	if message == Protocal.Success then	
		print(message)								-- 修改密码成功操作
	elseif message == Protocal.CheckFailed then
		FetchPwdPanel.wrongPassword:SetActive(true)
	elseif message == Protocal.NoAccount then
		FetchPwdPanel.noAccount:SetActive(true)			
	end
end

-- 2. 发送手机验证码
function FetchPwdPanelCtrl.SendSMS()	
	local data = UnityEngine.WWWForm()
	data:AddField("phone", FetchPwdPanel.phone.text)
	data:AddField("type", "2")
	
	local www = WWW(Urls.SendSMS, data)
	
	coroutine.www(www)		
	log(www.text)
	
	LuaHelper.OnJsonCallFunc(www.text, this.OnSMSJsonCall)
end

function FetchPwdPanelCtrl.OnSMSJsonCall(text)
	local obj = json.decode(text)
    
	local code = obj['Code']
	if code == 0 then	
		-- 临时方法
		FetchPwdPanel.identify.text = obj['Result']['Captcha']
	-- elseif code == -1 then
		-- returnError.text = obj['Message']		
	end
end
	
-- 匹配手机号
function FetchPwdPanelCtrl.CheckMobile(str)
	return string.match(str,"[1][3,4,5,7,8]%d%d%d%d%d%d%d%d%d") == str
end

-- 计时器响应
-- 1. 计时器调用
function FetchPwdPanelCtrl.OnTimerCallFunc()
	text.text = text.text - 1
	counting = true
	if text.text == '0' then
		timer:Stop()
		counting = false
		
		text.text = "重新获取"
	end
end

-- 重置
function FetchPwdPanelCtrl.OnResetFunc()
	FetchPwdPanel.phone.text = ""
	FetchPwdPanel.identify.text = ""
	FetchPwdPanel.oldPassword.text = ""	
	FetchPwdPanel.newPassword.text = ""	
	
	timer:Stop()
	counting = false
	text.text = "获取验证码"
	text.color = Color(187/255, 187/255, 187/255)
	
	FetchPwdPanel.noPhone:SetActive(false)
	FetchPwdPanel.noPassword:SetActive(false)
	FetchPwdPanel.noIdentify:SetActive(false)
	FetchPwdPanel.wrongPhone:SetActive(false)
	FetchPwdPanel.noAccount:SetActive(false)	
	FetchPwdPanel.wrongPassword:SetActive(false)
	FetchPwdPanel.samePassword:SetActive(false)	
end
	
	
	