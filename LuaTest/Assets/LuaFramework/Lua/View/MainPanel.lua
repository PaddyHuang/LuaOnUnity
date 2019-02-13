local transform
local gameObject

MainPanel = {}
local this = MainPanel

-- 启动事件
function MainPanel.Awake(obj)
	gameObject = obj
	transform = obj.transform
	
	this.InitPanel()	
end

-- 初始化面板
function MainPanel.InitPanel()
	this.productListBtn = transform:Find("NavigationBar/ProductListBtn").gameObject
	this.searchBtn = transform:Find("NavigationBar/SearchBtn").gameObject
end

function MainPanel.OnDestroy()
	logWarn("OnDestroy--->>")
end