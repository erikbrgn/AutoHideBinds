local _G = _G
local _, AHB = ...
_G.AutoHideBinds = AHB

local AHBFrame = CreateFrame("Frame", nil, UIParent)

function AHB:HookBinds()
    local ef = function () end
    for n,bar in ipairs({"Action", "MultiBarBottomLeft", "MultiBarBottomRight", "MultiBarRight", "MultiBarLeft"}) do
		for btnnum=1, 12 do
			local btn = bar.."Button"..btnnum
			if _G[btn] then
                self:StyleBind(_G[btn.."HotKey"])

                -- Hide binds and disable :Show()
                _G[btn.."HotKey"]:Hide()
                _G[btn.."HotKey"].Show = ef

                -- Hide macro names
                _G[btn.."Name"]:Hide()
				_G[btn.."Name"].Show = ef

                _G[btn]:HookScript("OnEnter", function ()
                    -- :Show() has been "unbound" because it's run all the time for some reason,
                    -- making it impossible to hide binds. We use the alternative function to show binds.
                    _G[btn.."HotKey"]:SetShown(true)
                    _G[btn.."Name"]:SetShown(true)
                end)
                _G[btn]:HookScript("OnLeave", function ()
                    _G[btn.."HotKey"]:Hide()
                    _G[btn.."Name"]:Hide()
                end)
			end
		end
	end
end

function AHB:StyleBind(frame)
    if frame then
        frame:ClearAllPoints()
        frame:SetPoint("CENTER")
        frame:SetJustifyH("CENTER")
        frame:SetFont("Fonts\\FRIZQT__.TTF", 24, "OUTLINE") 
    end
end

AHBFrame:RegisterEvent("ADDON_LOADED")
AHBFrame:SetScript("OnEvent", function (self, event, ...)
    local name = ...
    if event == "ADDON_LOADED" and name == "AutoHideBinds" then
        AHB:HookBinds()
    end
end)
