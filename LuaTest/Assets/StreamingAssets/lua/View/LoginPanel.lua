local transform
local gameObject

LoginPanel = {}
local this = LoginPanel

-- 启动事件
function LoginPanel.Awake(obj)
	gameObject = obj
	transform = obj.transform
	
	this.InitPanel()	
end

-- 初始化面板
function LoginPanel.InitPanel()	
	this.skipBtn = transform:Find("SkipBtn").gameObject
	this.image = transform:Find("Image"):GetComponent("Image")
	this.phone = transform:Find("Account/Phone"):GetComponent("InputField")
	this.password = transform:Find("Account/Password"):GetComponent("InputField")
	
	this.noPhone = transform:Find("Message/NoPhone").gameObject
	this.noPassword = transform:Find("Message/NoPassword").gameObject
	this.wrongPassword = transform:Find("Message/WrongPassword").gameObject
	this.wrongPhone = transform:Find("Message/WrongPhone").gameObject
	this.noAccount = transform:Find("Message/NoAccount").gameObject
	
	this.nextBtn = transform:Find("NextBtn").gameObject
	this.signUpBtn = transform:Find("SignUpBtn").gameObject
	this.forgetPwdBtn = transform:Find("ForgetPwdBtn").gameObject	
end

function LoginPanel.OnDestroy()
	logWarn("OnDestroy--->>")
end