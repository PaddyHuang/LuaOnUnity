local transform
local gameObject

FetchPwdPanel = {}
local this = FetchPwdPanel

-- 启动事件
function FetchPwdPanel.Awake(obj)
	gameObject = obj
	transform = obj.transform
	
	this.InitPanel()	
end

-- 初始化面板
function FetchPwdPanel.InitPanel()
	this.backBtn = transform:Find("BackBtn").gameObject
	this.skipBtn = transform:Find("SkipBtn").gameObject
	this.image = transform:Find("Image"):GetComponent("Image")
	this.phone = transform:Find("Account/Phone"):GetComponent("InputField")
	this.identify = transform:Find("Account/Identify"):GetComponent("InputField")
	this.identifyBtn = transform:Find("Account/IdentifyBtn").gameObject
	this.oldPassword = transform:Find("Account/OldPassword"):GetComponent("InputField")
	this.newPassword = transform:Find("Account/NewPassword"):GetComponent("InputField")
	
	this.noPhone = transform:Find("Message/NoPhone").gameObject
	this.noPassword = transform:Find("Message/NoPassword").gameObject	
	this.noIdentify = transform:Find("Message/NoIdentify").gameObject
	this.wrongPhone = transform:Find("Message/WrongPhone").gameObject
	this.wrongPassword = transform:Find("Message/WrongPassword").gameObject
	this.noAccount = transform:Find("Message/NoAccount").gameObject	
	this.samePassword = transform:Find("Message/SamePassword").gameObject
	
	this.nextBtn = transform:Find("NextBtn").gameObject
	this.loginBtn = transform:Find("LoginBtn").gameObject
end

function FetchPwdPanel.OnDestroy()
	logWarn("OnDestroy--->>")
end