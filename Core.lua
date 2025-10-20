MindVision = LibStub("AceAddon-3.0"):NewAddon("MindVision", "AceConsole-3.0", "AceEvent-3.0") -- Add extra mixins as you need them

--MindVision:RegisterEvent("ZONE_CHANGED_NEW_AREA")

local defaults = {
    profile = {
        defaultGamma = 1.0,
        ['*'] = {
            zoneName = nil,
            enabled = true,
            gamma = 1.0
        }
    }
}

function MindVision:GetMessage(info)
    return messageVar
end

function MindVision:SetMessasge(info, input)
    messageVar = input
end

function MindVision:ZONE_CHANGED_NEW_AREA()
    -- Getting it through GetBestMapForUnit is better. I avoid duplicate zone issues.
    -- This behaviour might need to be changed later depending on feedback.
    local zone =  C_Map.GetBestMapForUnit("player")
    self:ChangeGamma(zone)
    --[[self:Print("Zone Changed to " .. zone)


    -- This is a crude solution. But it works for testing purposes. 
    if zone == "The Great Sea" then
        SetCVar("gamma", 2.8)
        self:Print("Gamma Set to 2.8")
    else
        SetCVar("gamma", 1.0)
        self:Print("Gamma Set to 1.0")
    end]]

end

function MindVision:GetGamma(profile, zone)
    local gamma = 1.0
    local profileDefaultGamma = profile.defaultGamma
    self:Print("Default Gamma is " .. profile.defaultGamma)
    local zoneInProfile = profile[zone]
    self:Print("Getting Zone Gamma")
    -- Return Default Profile Gamma if Zone does not exist or is not enabled.
    if not zoneInProfile then gamma = profileDefaultGamma end
    self:Print("Zone in Profile, testing for ")
    if not profile[zone].enabled then gamma = profileDefaultGamma end
    self:Print("Gamma Change is Enabled for Zone")
    gamma = zoneInProfile.gamma 
    self:Print("Gamma is " .. gamma)
    return gamma
end

--Entering" .. zone .. ", 
function MindVision:ChangeGamma(zone)
    local currentGamma = tonumber(GetCVar("gamma"))
    local profileGamma = tonumber(self:GetGamma(self.db.profile, zone))
    self:Print("Profile Gamma is " .. profileGamma)
    if profileGamma ~= currentGamma then
        self:Print("Current Gamma is " .. currentGamma .. ". Profile Gamma is " .. profileGamma)
        self:Print("Gamma Different. Setting Gamma to " .. profileGamma)
        SetCVar("gamma", profileGamma)
    end
end


function MindVision:ProfileChanged(db, newProfile)
    local zone = GetZoneText()
    self:Print("Entering zone" .. zone)
    self:ChangeGamma(zone)
end

function MindVision:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("MindVisionDB", defaults, true)
    self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
    self.db.RegisterCallback(self, "OnProfileChanged", "ProfileChanged")
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

