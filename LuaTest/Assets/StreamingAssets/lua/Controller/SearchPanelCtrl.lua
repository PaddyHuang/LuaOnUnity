require "Common/define"

SearchPanelCtrl = {}
local this = SearchPanelCtrl

local LuaBehaviour
local transform
local gameObject

-- local mainPanel

-- 构造函数
function SearchPanelCtrl.New()
	-- logWarn("SearchPanelCtrl.New--->>")
	return this
end

function SearchPanelCtrl.Awake()
	-- logWarn("SearchPanelCtrl.Awake--->>")	
	panelMgr:CreatePanel('Search', this.OnCreate)	
end

-- 初始化面板
function SearchPanelCtrl.OnCreate(obj)	
	gameObject = obj
	transform = obj.transform
	-- mainPanel = Util.Peer(transform, PanelNames[1])
	
	LuaBehaviour = transform:GetComponent('LuaBehaviour')
	
	LuaBehaviour:AddClick(SearchPanel.backBtn, this.OnBackClick)
	LuaBehaviour:AddClick(SearchPanel.searchBtn, this.OnSearchClick)
			
	SearchPanel.inputField.onValueChanged:AddListener(this.OnInputChange)
		
	gameObject:SetActive(false)
end

-- 按键响应
-- 1. 返回
function SearchPanelCtrl.OnBackClick()	
	-- mainPanel:SetActive(true)
	gameObject:SetActive(false)	
end

-- 2. 搜索
function SearchPanelCtrl.OnSearchClick()	
	if string.len(SearchPanel.inputField.text) == 0 then 
		return	
	end		
	
	SearchPanel.dropDown:Show()
end

-- 输入响应
function SearchPanelCtrl.OnInputChange()		
	this.Match(SearchPanel.inputField.text)	
end

-- 匹配
function SearchPanelCtrl.Match(text)	
	if string.len(text) == 0 then
		return
	end
	
	SearchPanel.dropDown.options:Clear()	-- 清除前一次搜索的列表
	
	for i = 1, #ProductNames do						-- 在列表里匹配	
		if string.match(ProductNames[i], text) then 			
			local option = UnityEngine.UI.Dropdown.OptionData.New()
			option.text = ProductNames[i]
			
			SearchPanel.dropDown.options:Add(option)				
		end			
	end			
	
	if SearchPanel.dropDown.options.Count == 0 then 				
		local option = UnityEngine.UI.Dropdown.OptionData.New()
		option.text = "暂时没有此产品哦~"		
		SearchPanel.dropDown.options:Add(option)	
		SearchPanel.dropDown:Show()
		return
	end
	
	SearchPanel.dropDown.onValueChanged:AddListener(this.OnDropdownSelect)	
	SearchPanel.dropDown:Show()	
end

-- 选择dropdown响应
function SearchPanelCtrl.OnDropdownSelect()
	SearchPanel.inputField.text = SearchPanel.dropDown.options[SearchPanel.dropDown.value].text			
end
