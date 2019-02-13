require "Common/define"
-- require "Controller/PromptCtrl"
-- require "Controller/MessageCtrl"
require "Controller/MainPanelCtrl"
require "Controller/ListPanelCtrl"
require "Controller/SearchPanelCtrl"
require "Controller/FetchPwdPanelCtrl"
require "Controller/LoginPanelCtrl"
require "Controller/SignUpPanelCtrl"

CtrlManager = {}
local this = CtrlManager
local ctrlList = {}	--控制器列表--

function CtrlManager.Init()
	logWarn("CtrlManager.Init----->>>")
	-- ctrlList[CtrlNames.Prompt] = PromptCtrl.New()
	-- ctrlList[CtrlNames.Message] = MessageCtrl.New()
	ctrlList[CtrlNames.MainPanel] = MainPanelCtrl.New()
	ctrlList[CtrlNames.ListPanel] = ListPanelCtrl.New()
	ctrlList[CtrlNames.SearchPanel] = SearchPanelCtrl.New()	
	ctrlList[CtrlNames.FetchPwdPanel] = FetchPwdPanelCtrl.New()			
	ctrlList[CtrlNames.SignUpPanel] = SignUpPanelCtrl.New()	
	ctrlList[CtrlNames.LoginPanel] = LoginPanelCtrl.New()
	return this
end

--添加控制器--
function CtrlManager.AddCtrl(ctrlName, ctrlObj)
	ctrlList[ctrlName] = ctrlObj
end

--获取控制器--
function CtrlManager.GetCtrl(ctrlName)
	return ctrlList[ctrlName]
end

--移除控制器--
function CtrlManager.RemoveCtrl(ctrlName)
	ctrlList[ctrlName] = nil
end

--关闭控制器--
function CtrlManager.Close()
	logWarn('CtrlManager.Close---->>>')
end
