-- 1. STARTUP PRINT
print("|cff00ff00[CDM Dark Mode]|r: Loaded. Default is 95%.")

local addonName, ns = ...

-- 2. DEFAULT SETTINGS
local defaults = {
    enabled = true,
    removeDesaturation = true, 
    swipeColor = {r = 0, g = 0, b = 0, a = 0.95}, -- Default: 95% (Almost Pure Black)
}

-- 3. THE LOGIC
local function ApplyDarkSwipe(self)
    -- Safety check
    if not ns.db then return end
    if not ns.db.enabled then return end

    -- Apply Dark Swipe
    local c = ns.db.swipeColor
    pcall(self.SetSwipeColor, self, c.r, c.g, c.b, c.a)

    -- Keep Icon Colorful
    if ns.db.removeDesaturation then
        local parent = self:GetParent()
        if parent then
            local icon = parent.icon or parent.Icon or parent.texture
            if icon and icon.SetDesaturated then
                icon:SetDesaturated(false)
            end
        end
    end
end

-- 4. SECURE HOOKS
local cooldownFrame = CreateFrame("Cooldown", nil, nil, "CooldownFrameTemplate")
local methods = getmetatable(cooldownFrame).__index

if methods and methods.SetCooldown then
    hooksecurefunc(methods, "SetCooldown", ApplyDarkSwipe)
    
    -- Force our color back if the UI tries to change it
    hooksecurefunc(methods, "SetSwipeColor", function(self, r, g, b, a)
        if ns.db and ns.db.enabled then
            local c = ns.db.swipeColor
            if r ~= c.r or a ~= c.a then
                ApplyDarkSwipe(self)
            end
        end
    end)
end

-- 5. INITIALIZATION & SLASH COMMAND
local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
    if name == addonName then
        -- Load Saved Variables
        CDMDarkModeDB = CDMDarkModeDB or CopyTable(defaults)
        ns.db = CDMDarkModeDB

        -- REGISTER SLASH COMMAND (Fixed Case Sensitivity)
        SLASH_CDMDARKMODE1 = "/cdmdm"
        SlashCmdList["CDMDARKMODE"] = function(msg)
            -- Trim spaces
            msg = msg:match("^%s*(.-)%s*$")
            
            -- If empty, show help
            if msg == "" then
                print("|cff00ff00[CDM Dark Mode]|r Current Opacity: " .. (ns.db.swipeColor.a * 100) .. "%")
                print("Usage: /cdmdm 50  (for 50%)")
                print("Usage: /cdmdm 98  (for 98%)")
                return
            end

            local val = tonumber(msg)
            if val then
                -- Logic: "98" becomes 0.98, "0.98" stays 0.98
                if val > 1 then val = val / 100 end
                if val > 1 then val = 1 end
                if val < 0 then val = 0 end
                
                ns.db.swipeColor.a = val
                print("|cff00ff00[CDM]|r Darkness set to: " .. (val * 100) .. "%")
                print("(Cast a spell to see the update)")
            else
                print("|cffff0000[CDM]|r Invalid number.")
            end
        end

        self:UnregisterEvent("ADDON_LOADED")
    end
end)