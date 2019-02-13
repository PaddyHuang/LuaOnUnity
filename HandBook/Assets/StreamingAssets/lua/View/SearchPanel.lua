local transform
local gameObject

SearchPanel = {}
local this = SearchPanel

--启动事件--
function SearchPanel.Awake(obj)
	gameObject = obj
	transform = obj.transform

	this.InitPanel()	
end

-- 初始化面板
function SearchPanel.InitPanel()
	this.backBtn = transform:Find("BackBtn").gameObject
	this.dropDown = transform:Find("Dropdown"):GetComponent("Dropdown")
	this.inputField = transform:Find("InputField"):GetComponent("InputField")
	this.searchBtn = this.inputField.transform:Find("SearchBtn").gameObject
end

--单击事件--
function SearchPanel.OnDestroy()
	logWarn("OnDestroy---->>>")
end