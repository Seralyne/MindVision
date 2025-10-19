MindVision = LibStub("AceAddon-3.0"):NewAddon("MindVision", "AceConsole-3.0", "AceEvent-3.0") -- Add extra mixins as you need them

--MindVision:RegisterEvent("ZONE_CHANGED_NEW_AREA")



function MindVision:GetMessage(info)
    return messageVar
end

function MindVision:SetMessasge(info, input)
    messageVar = input
end

function MindVision:ZONE_CHANGED_NEW_AREA()
    local zone =  GetZoneText()
    self:Print("Zone Changed to " .. zone)


    -- This is a crude solution. But it works for testing purposes. 
    if zone == "The Great Sea" then
        SetCVar("gamma", 2.8)
        self:Print("Gamma Set to 2.8")
    else
        SetCVar("gamma", 1.0)
        self:Print("Gamma Set to 1.0")
    end

end

function MindVision:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("MindVisionDB")
    self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
    self:Print("Mind Vision Gamma Addon Loaded!")
end



local options = {
    name = "MindVision",
    handler = MindVision,
    type = 'group',
    args = {
        newZones = {
            name = "Add New Zones",
            type = "group",
            args = {
                msg = {
                    type = 'input',
                    name = 'My message',
                    desc = "The message for my addon",
                    set = "SetMessage",
                    get = "GetMessage"
                }  
            }
        },
        existingZones = {
            name = "Existing Zones",
            type = "group",
            args = {

            }
        }
    }
}

LibStub("AceConfig-3.0"):RegisterOptionsTable("MindVision", options, {"getmessage", "setmessage"})
LibStub("AceConfigDialog-3.0"):AddToBlizOptions("MindVision","MindVision")

