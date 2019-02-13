local transform
local gameObject

ListPanel = {}
local this = ListPanel

-- 启动事件
function ListPanel.Awake(obj)
	gameObject = obj
	transform = obj.transform
	
	this.InitPanel()
end

-- 初始化面板
function ListPanel.InitPanel()
	this.backBtn = transform:Find("BackBtn").gameObject
	this.content = transform:Find("List/Viewport/Content")
	-- 1. 厨房
	this.chuFang = this.content:Find("ChuFangBtn").gameObject	
	-- 2. 电脑
	this.dianNao = this.content:Find("DianNaoBtn").gameObject	
	-- 3. 工业
	this.gongYe = this.content:Find("GongYeBtn").gameObject	
	-- 4. 家电
	this.jiaDian = this.content:Find("JiaDianBtn").gameObject		
end

--单击事件--
function ListPanel.OnDestroy()
	logWarn("OnDestroy---->>>")
end