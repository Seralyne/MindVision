MindVision = LibStub("AceAddon-3.0"):NewAddon("MindVision", "AceConsole-3.0") -- Add extra mixins as you need them


function MindVision:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("MindVisionDB")
    MindVision:Print("Mind Vision Gamma Addon Loaded!")
end

function MindVision:GetMessage(info)
    return messageVar
end

function MindVision:SetMessasge(info, input)
    messageVar = input
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