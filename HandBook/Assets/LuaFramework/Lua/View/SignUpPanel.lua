local transform
local gameObject

SignUpPanel = {}
local this = SignUpPanel

-- 启动事件
function SignUpPanel.Awake(obj)
	gameObject = obj
	transform = obj.transform
	
	this.InitPanel()	
end

-- 初始化面板
function SignUpPanel.InitPanel()
	this.skipBtn = transform:Find("SkipBtn").gameObject
	this.image = transform:Find("Image"):GetComponent("Image")
	this.phone = transform:Find("Account/Phone"):GetComponent("InputField")
	this.identify = transform:Find("Account/Identify"):GetComponent("InputField")
	this.identifyBtn = transform:Find("Account/IdentifyBtn").gameObject
	this.password = transform:Find("Account/Password"):GetComponent("InputField")
	
	this.noPhone = transform:Find("Message/NoPhone").gameObject
	this.noPassword = transform:Find("Message/NoPassword").gameObject	
	this.noIdentify = transform:Find("Message/NoIdentify").gameObject
	this.wrongPhone = transform:Find("Message/WrongPhone").gameObject
	this.accountAdded = transform:Find("Message/AccountAdded").gameObject	
	this.wrongIdentify = transform:Find("Message/WrongIdentify").gameObject	
	
	this.nextBtn = transform:Find("NextBtn").gameObject
	this.loginBtn = transform:Find("LoginBtn").gameObject	
end

function SignUpPanel.OnDestroy()
	logWarn("OnDestroy--->>")
end