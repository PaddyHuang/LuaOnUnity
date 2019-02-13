require "Common/define"

MainPanelCtrl = {}
local this = MainPanelCtrl

local LuaBehaviour
local transform
local gameObject

-- 构造函数
function MainPanelCtrl.New()
	-- logWarn("MainPanelCtrl.New--->>")
	return this
end

function MainPanelCtrl.Awake()
	-- logWarn("MainPanelCtrl.Awake--->>")	
	panelMgr:CreatePanel('Main', this.OnCreate)	
end

-- 初始化面板
function MainPanelCtrl.OnCreate(obj)	
	gameObject = obj
	transform = obj.transform
		
	LuaBehaviour = transform:GetComponent('LuaBehaviour')
	
	LuaBehaviour:AddClick(MainPanel.productListBtn, this.OnListClick)
	LuaBehaviour:AddClick(MainPanel.searchBtn, this.OnSearchClick)	

	gameObject:SetActive(false)
end

-- 按键响应
-- 1. 列表
function MainPanelCtrl.OnListClick()
	Util.Peer(transform, PanelNames[2]):SetActive(true)	
	-- gameObject:SetActive(false)		
end

-- 2. 搜索
function MainPanelCtrl.OnSearchClick()	
	Util.Peer(transform, PanelNames[3]):SetActive(true)	
	-- gameObject:SetActive(false)
end