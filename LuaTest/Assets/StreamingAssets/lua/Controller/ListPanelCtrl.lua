require "Common/define"

ListPanelCtrl = {} 
local this = ListPanelCtrl 

local LuaBehaviour 
local transform 
local gameObject 

-- local mainPanel 

-- Flags
local isShowingProducts = true

-- 构造函数
function ListPanelCtrl.New()
	-- logWarn("ListPanelCtrl.New--->>") 
	return this 
end

function ListPanelCtrl.Awake()
	-- logWarn("ListPanelCtrl.Awake--->>") 	
	panelMgr:CreatePanel('List', this.OnCreate) 	
end

-- 初始化面板
function ListPanelCtrl.OnCreate(obj)	
	gameObject = obj 
	transform = obj.transform 
	-- mainPanel = Util.Peer(transform, PanelNames[1]) 
		
	LuaBehaviour = transform:GetComponent('LuaBehaviour') 
	
	-- coroutine.start(this.GetProductTypeList)		-- 获取产品类别列表
	-- coroutine.start(this.GetProductList)			-- 获取产品列表
	
	resMgr:LoadPrefab('Items', {'Item'}, this.OnLoadItemsFinish) 
	
	LuaBehaviour:AddClick(ListPanel.backBtn, this.OnBackClick) 
	LuaBehaviour:AddClick(ListPanel.chuFang, this.OnChuFangClick) 	
	LuaBehaviour:AddClick(ListPanel.dianNao, this.OnDianNaoClick) 	
	LuaBehaviour:AddClick(ListPanel.gongYe, this.OnGongYeClick) 	
	LuaBehaviour:AddClick(ListPanel.jiaDian, this.OnJiaDianClick) 	
	
	gameObject:SetActive(false) 
end

-- 接口方法
-- 1. 获取产品类别列表
function ListPanelCtrl.GetProductTypeList()
	local www = WWW(Urls.GetAllProductTypes)
	coroutine.www(www)
	log(www.text)
end

-- 2. 获取产品列表
function ListPanelCtrl.GetProductList()
	local www = WWW(Urls.GetList)
	coroutine.www(www)
	log(www.text)
end

-- 按键响应
-- 1. 返回
function ListPanelCtrl.OnBackClick()	
	-- mainPanel:SetActive(true) 
	gameObject:SetActive(false) 	
end

-- 2. 厨房
function ListPanelCtrl.OnChuFangClick(go)
	print(go.name) 	
end

-- 3. 电脑
function ListPanelCtrl.OnDianNaoClick(go)
	print(go.name) 
end

-- 4. 工业
function ListPanelCtrl.OnGongYeClick()
	if isShowingProducts then 		
		this.huanReQi:SetActive(true)
		
		isShowingProducts = false
	elseif not isShowingProducts then		
		this.huanReQi:SetActive(false)	
		
		isShowingProducts = true
	end
end

-- 5. 家电
function ListPanelCtrl.OnJiaDianClick(go)
	print(go.name) 
end

-- 6. items: 换热器
function ListPanelCtrl.OnLoadItemsFinish(objs)
	this.huanReQi = GameObject.Instantiate(objs[0]) 
	
	this.huanReQi.transform:SetParent(ListPanel.content) 
	this.huanReQi.transform.localScale = Vector3.one 			
	this.huanReQi.transform:SetSiblingIndex(ListPanel.gongYe.transform:GetSiblingIndex() + 1)
	
	LuaBehaviour:AddClick(this.huanReQi, this.OnItemClick) 

	this.huanReQi:SetActive(false)
end

function ListPanelCtrl.OnItemClick(go)
	print(go.name)
end

