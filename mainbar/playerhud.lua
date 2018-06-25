local _, GW = ...
local GetBuffs = GW.GetBuffs
local GetDebuffs = GW.GetDebuffs
local AuraAnimateIn = GW.AuraAnimateIn
local SetBuffData = GW.SetBuffData
local CommaValue = GW.CommaValue
local PowerBarColorCustom = GW.PowerBarColorCustom
local bloodSpark = GW.BLOOD_SPARK
local DODGEBAR_SPELLS = GW.DODGEBAR_SPELLS
local CreateAuraFrame = GW.CreateAuraFrame
local animations = GW.animations
local AddToAnimation = GW.AddToAnimation
local AddToClique = GW.AddToClique
local Self_Hide = GW.Self_Hide

local function updateBuffLayout(self, event)
    local minIndex = 1
    local maxIndex = 80

    if self.displayBuffs ~= true then
        minIndex = 40
    end
    if self.displayDebuffs ~= true then
        maxIndex = 40
    end

    local marginX = 3
    local marginY = 20

    local usedWidth = 0
    local usedHeight = 0

    local smallSize = 20
    local bigSize = 28
    local lineSize = smallSize
    local maxSize = self.auras:GetWidth()

    local auraList = GetBuffs(self.unit)
    local debuffList = GetDebuffs(self.unit, self.debuffFilter)

    local saveAuras = {}

    saveAuras["buff"] = {}
    saveAuras["debuff"] = {}

    for frameIndex = minIndex, maxIndex do
        local index = frameIndex
        local list = auraList
        local newAura = true

        if frameIndex > 40 then
            index = frameIndex - 40
        end

        local frame = _G["Gw" .. self.unit .. "buffFrame" .. index]

        if frameIndex > 40 then
            frame = _G["Gw" .. self.unit .. "debuffFrame" .. index]
            list = debuffList
        end

        if frameIndex == 41 then
            usedWidth = 0
            usedHeight = usedHeight + lineSize + marginY
            lineSize = smallSize
        end

        if SetBuffData(frame, list, index) then
            if not frame:IsShown() then
                frame:Show()
            end

            local isBig = frame.typeAura == "bigBuff"

            local size = smallSize
            if isBig then
                size = bigSize
                lineSize = bigSize

                for k, v in pairs(self.saveAuras[frame.auraType]) do
                    if v == list[index]["name"] then
                        newAura = false
                    end
                end
                self.animating = false
                saveAuras[frame.auraType][#saveAuras[frame.auraType] + 1] = list[index]["name"]
            end
            frame:SetPoint("CENTER", self.auras, "BOTTOMRIGHT", -(usedWidth + (size / 2)), usedHeight + (size / 2))
            frame:SetSize(size, size)
            if newAura and isBig and event == "UNIT_AURA" then
                AuraAnimateIn(frame)
            end

            usedWidth = usedWidth + size + marginX
            if maxSize < usedWidth then
                usedWidth = 0
                usedHeight = usedHeight + lineSize + marginY
                lineSize = smallSize
            end
        else
            if frame:IsShown() then
                frame:Hide()
            end
        end
    end

    self.saveAuras = saveAuras
end

local function powerBar_OnUpdate(self)
    if self.lostKnownPower == nil or self.powerMax == nil or self.lastUpdate == nil or self.animating == true then
        return
    end
    if self.lostKnownPower >= self.powerMax then
        return
    end
    if self.textUpdate == nil then
        self.textUpdate = 0
    end

    local decayRate = 1
    local inactiveRegen, activeRegen = GetPowerRegen()

    local regen = inactiveRegen

    if InCombatLockdown() then
        regen = activeRegen
    end

    local addPower = regen * ((GetTime() - self.lastUpdate) / decayRate)

    local power = self.lostKnownPower + addPower
    local powerMax = self.powerMax
    local powerPrec = 0
    local powerBarWidth = self.powerBarWidth

    if power > 0 and powerMax > 0 then
        powerPrec = math.min(1, power / powerMax)
    end

    local bit = powerBarWidth / 15
    local spark = bit * math.floor(15 * (powerPrec))

    local spark_current = (bit * (15 * (powerPrec)) - spark) / bit

    local bI = math.min(16, math.max(1, math.floor(17 - (16 * spark_current))))

    self.powerCandySpark:SetTexCoord(
        bloodSpark[bI].left,
        bloodSpark[bI].right,
        bloodSpark[bI].top,
        bloodSpark[bI].bottom
    )
    self.powerCandySpark:SetPoint("LEFT", self.bar, "RIGHT", -2, 0)
    self.bar:SetPoint("RIGHT", self, "LEFT", spark, 0)
    self.powerBar:SetValue(0)
    self.powerCandy:SetValue(0)

    if self.textUpdate < GetTime() then
        self.powerBarString:SetText(CommaValue(powerMax * powerPrec))
        self.textUpdate = GetTime() + 0.2
    end

    self.animationCurrent = powerPrec
end

local function repair_OnEvent()
    local needRepair = false
    local gearBroken = false
    for i = 1, 23 do
        local current, maximum = GetInventoryItemDurability(i)
        if current ~= nil then
            dur = current / maximum
            if dur < 0.5 then
                needRepair = true
            end
            if dur == 0 then
                gearBroken = true
            end
        end
    end

    if gearBroken then
        GwHudArtFrameRepairTexture:SetTexCoord(0, 1, 0.5, 1)
    else
        GwHudArtFrameRepairTexture:SetTexCoord(0, 1, 0, 0.5)
    end

    if needRepair then
        GwHudArtFrameRepair:Show()
    else
        GwHudArtFrameRepair:Hide()
    end
end

local function UpdatePowerData(self, forcePowerType, powerToken, forceAnimationName)
    if forcePowerType == nil then
        forcePowerType, powerToken, altR, altG, altB = UnitPowerType("player")
        forceAnimationName = "powerBarAnimation"
    end

    self.animating = true

    local power = UnitPower("Player", forcePowerType)
    local powerMax = UnitPowerMax("Player", forcePowerType)
    local powerPrec = 0
    local powerBarWidth = _G[self:GetName() .. "Bar"]:GetWidth()

    self.powerType = forcePowerType
    self.lostKnownPower = power
    self.powerMax = powerMax
    self.lastUpdate = GetTime()
    self.powerBarWidth = powerBarWidth

    if power > 0 and powerMax > 0 then
        powerPrec = power / powerMax
    end

    if PowerBarColorCustom[powerToken] then
        local pwcolor = PowerBarColorCustom[powerToken]
        _G[self:GetName() .. "Bar"]:SetStatusBarColor(pwcolor.r, pwcolor.g, pwcolor.b)
        _G[self:GetName() .. "CandySpark"]:SetVertexColor(pwcolor.r, pwcolor.g, pwcolor.b)
        _G[self:GetName() .. "Candy"]:SetStatusBarColor(pwcolor.r, pwcolor.g, pwcolor.b)
        _G[self:GetName()].bar:SetVertexColor(pwcolor.r, pwcolor.g, pwcolor.b)
    end

    if self.animationCurrent == nil then
        self.animationCurren = 0
    end

    AddToAnimation(
        self:GetName(),
        self.animationCurrent,
        powerPrec,
        GetTime(),
        0.2,
        function()
            local powerPrec = animations[self:GetName()]["progress"]
            local bit = powerBarWidth / 15
            local spark = bit * math.floor(15 * (powerPrec))

            local spark_current = (bit * (15 * (powerPrec)) - spark) / bit

            local bI = math.min(16, math.max(1, math.floor(17 - (16 * spark_current))))

            _G[self:GetName() .. "CandySpark"]:SetTexCoord(
                bloodSpark[bI].left,
                bloodSpark[bI].right,
                bloodSpark[bI].top,
                bloodSpark[bI].bottom
            )
            _G[self:GetName() .. "CandySpark"]:SetPoint("LEFT", _G[self:GetName()].bar, "RIGHT", -2, 0)
            _G[self:GetName()].bar:SetPoint("RIGHT", self, "LEFT", spark, 0)
            _G[self:GetName() .. "Bar"]:SetValue(0)
            _G[self:GetName() .. "Candy"]:SetValue(0)

            _G[self:GetName() .. "BarString"]:SetText(CommaValue(powerMax * animations[self:GetName()]["progress"]))

            self.animationCurrent = powerPrec
        end,
        "noease",
        function()
            self.animating = false
        end
    )

    if self.lastPowerType ~= self.powerType and self == GwPlayerPowerBar then
        self.lastPowerType = self.powerType
        self.powerCandySpark = _G[self:GetName() .. "CandySpark"]
        self.powerBar = _G[self:GetName() .. "Bar"]
        self.powerCandy = _G[self:GetName() .. "Candy"]
        self.powerBarString = _G[self:GetName() .. "BarString"]
        if
            self.powerType == nil or self.powerType == 1 or self.powerType == 6 or self.powerType == 13 or
                self.powerType == 8
         then
            self:SetScript("OnUpdate", nil)
        else
            self:SetScript("OnUpdate", powerBar_OnUpdate)
        end
    end
end
GW.UpdatePowerData = UpdatePowerData

local function globeFlashComplete()
    GwPlayerHealthGlobe.animating = true
    local lerpTo = 0

    if GwPlayerHealthGlobe.animationPrecentage == nil then
        GwPlayerHealthGlobe.animationPrecentage = 0
    end

    if GwPlayerHealthGlobe.animationPrecentage <= 0 then
        lerpTo = 0.4
    end

    AddToAnimation(
        "healthGlobeFlash",
        GwPlayerHealthGlobe.animationPrecentage,
        lerpTo,
        GetTime(),
        0.8,
        function()
            local l = animations["healthGlobeFlash"]["progress"]

            GwPlayerHealthGlobe.background:SetVertexColor(l, l, l)
        end,
        nil,
        function()
            local health = UnitHealth("Player")
            local healthMax = UnitHealthMax("Player")
            local healthPrec = 0.00001
            if health > 0 and healthMax > 0 then
                healthPrec = health / healthMax
            end
            if healthPrec < 0.7 then
                GwPlayerHealthGlobe.animationPrecentage = lerpTo
                globeFlashComplete()
            else
                GwPlayerHealthGlobe.background:SetVertexColor(0, 0, 0)
                GwPlayerHealthGlobe.animating = false
            end
        end
    )
end

local function updateHealthText(text)
    local v = CommaValue(text)
    _G["GwPlayerHealthGlobeTextValue"]:SetText(v)
    for i = 1, 8 do
        _G["GwPlayerHealthGlobeTextShadow" .. i]:SetText(v)
    end
end

local function updateAbsorbText(text)
    local v
    if text <= 0 then
        v = ""
    else
        v = CommaValue(text)
    end

    _G["GwPlayerAbsorbGlobeTextValue"]:SetText(v)
    for i = 1, 8 do
        _G["GwPlayerAbsorbGlobeTextShadow" .. i]:SetText(v)
    end
end

local function updateHealthData()
    local health = UnitHealth("Player")
    local healthMax = UnitHealthMax("Player")
    local healthPrec = 0.00001
    local absorb = UnitGetTotalAbsorbs("Player")

    local absorbPrec = 0.00001

    if health > 0 and healthMax > 0 then
        healthPrec = math.max(0.0001, health / healthMax)
    end

    if absorb > 0 and healthMax > 0 then
        absorbPrec = math.min(math.max(0.0001, absorb / healthMax), 1)
    end

    if healthPrec < 0.7 and (GwPlayerHealthGlobe.animating == false or GwPlayerHealthGlobe.animating == nil) then
        globeFlashComplete()
    end

    GwPlayerHealthGlobe.stringUpdateTime = 0
    AddToAnimation(
        "healthGlobeAnimation",
        GwPlayerHealthGlobe.animationCurrent,
        healthPrec,
        GetTime(),
        0.2,
        function()
            local healthPrecCandy = math.min(1, animations["healthGlobeAnimation"]["progress"] + 0.02)

            if GwPlayerHealthGlobe.stringUpdateTime < GetTime() then
                updateHealthText(healthMax * animations["healthGlobeAnimation"]["progress"])
                updateAbsorbText(absorb)
                GwPlayerHealthGlobe.stringUpdateTime = GetTime() + 0.05
            end
            _G["GwPlayerHealthGlobeCandy"]:SetHeight(healthPrecCandy * _G["GwPlayerHealthGlobeHealthBar"]:GetWidth())
            _G["GwPlayerHealthGlobeCandyBar"]:SetTexCoord(0, 1, math.abs(healthPrecCandy - 1), 1)

            _G["GwPlayerHealthGlobeAbsorbBackdrop"]:SetHeight(
                math.min(1, animations["healthGlobeAnimation"]["progress"] + absorbPrec) *
                    _G["GwPlayerHealthGlobeHealthBar"]:GetWidth()
            )
            _G["GwPlayerHealthGlobeAbsorbBackdropBar"]:SetTexCoord(
                0,
                1,
                math.abs(math.min(1, animations["healthGlobeAnimation"]["progress"] + absorbPrec) - 1),
                1
            )

            _G["GwPlayerHealthGlobeHealth"]:SetHeight(
                animations["healthGlobeAnimation"]["progress"] * _G["GwPlayerHealthGlobeHealthBar"]:GetWidth()
            )
            _G["GwPlayerHealthGlobeHealthBar"]:SetTexCoord(
                0,
                1,
                math.abs(animations["healthGlobeAnimation"]["progress"] - 1),
                1
            )
        end,
        nil,
        function()
            updateHealthText(health)
            updateAbsorbText(absorb)
        end
    )
    GwPlayerHealthGlobe.animationCurrent = healthPrec

    local absorbPrecOverflow = (healthPrec + absorbPrec) - 1
    _G["GwPlayerHealthGlobeAbsorb"]:SetHeight(absorbPrecOverflow * _G["GwPlayerHealthGlobeHealthBar"]:GetWidth())
    _G["GwPlayerHealthGlobeAbsorbBar"]:SetTexCoord(0, 1, math.abs(absorbPrecOverflow - 1), 1)
end

local function updateDodgeBar(start, duration, chargesMax, charges)
    --  GwDodgeBar.spark.anim:SetDegrees(63)
    --   GwDodgeBar.spark.anim:SetDuration(1)
    --  GwDodgeBar.spark.anim:Play()

    if chargesMax == charges then
        return
    end

    AddToAnimation(
        "GwDodgeBar",
        0,
        1,
        start,
        duration,
        function()
            local p = animations["GwDodgeBar"]["progress"]
            local c = (charges + p) / chargesMax
            GwDodgeBar.fill:SetTexCoord(0, 1 * c, 0, 1)
            GwDodgeBar.fill:SetWidth(114 * c)
        end,
        "noease"
    )
    GwDodgeBar.animation = 0
end

local function dodgeBar_OnEvent(self, event, unit)
    if event == "SPELL_UPDATE_COOLDOWN" then
        if self.gwDashSpell then
            local charges, maxCharges, start, duration
            if self.gwMaxCharges > 1 then
                charges, maxCharges, start, duration = GetSpellCharges(self.gwDashSpell)
            else
                charges = 0
                maxCharges = 1
                start, duration, _ = GetSpellCooldown(self.gwDashSpell)
            end
            updateDodgeBar(start, duration, maxCharges, charges)
        end
    elseif
        event == "PLAYER_SPECIALIZATION_CHANGED" or event == "CHARACTER_POINTS_CHANGED" or
            event == "PLAYER_ENTERING_WORLD"
     then
        local foundADash = false
        local _, _, c = UnitClass("player")
        self.gwMaxCharges = nil
        self.gwDashSpell = nil
        if DODGEBAR_SPELLS[c] ~= nil then
            for k, v in pairs(DODGEBAR_SPELLS[c]) do
                local name = GetSpellInfo(v)
                if name ~= nil then
                    if IsPlayerSpell(v) then
                        self.gwDashSpell = v
                        local charges, maxCharges, start, duration = GetSpellCharges(v)
                        if charges ~= nil and charges <= maxCharges then
                            foundADash = true
                            GwDodgeBar.spellId = v
                            self.gwMaxCharges = maxCharges
                            updateDodgeBar(start, duration, maxCharges, charges)
                            break
                        else
                            local start, duration, enable = GetSpellCooldown(v)
                            foundADash = true
                            GwDodgeBar.spellId = v
                            self.gwMaxCharges = 1
                            updateDodgeBar(start, duration, 1, 0)
                        end
                    end
                end
            end
        end
        if foundADash then
            if self.gwMaxCharges > 1 and self.gwMaxCharges < 3 then
                _G["GwDodgeBarSep1"]:Show()
            else
                _G["GwDodgeBarSep1"]:Hide()
            end

            if self.gwMaxCharges > 2 then
                _G["GwDodgeBarSep2"]:SetRotation(0.55)
                _G["GwDodgeBarSep3"]:SetRotation(-0.55)

                _G["GwDodgeBarSep2"]:Show()
                _G["GwDodgeBarSep3"]:Show()
            else
                _G["GwDodgeBarSep2"]:Hide()
                _G["GwDodgeBarSep3"]:Hide()
            end
            GwDodgeBar:Show()
        else
            GwDodgeBar:Hide()
        end
    end
end

local function LoadPowerBar()
    local playerPowerBar = CreateFrame("Frame", "GwPlayerPowerBar", UIParent, "GwPlayerPowerBar")

    _G[playerPowerBar:GetName() .. "CandySpark"]:ClearAllPoints()

    playerPowerBar:SetScript(
        "OnEvent",
        function(self, event, unit)
            if (event == "UNIT_POWER_FREQUENT" or event == "UNIT_MAXPOWER") and unit == "player" then
                UpdatePowerData(GwPlayerPowerBar)
                return
            end
            if event == "UPDATE_SHAPESHIFT_FORM" or event == "ACTIVE_TALENT_GROUP_CHANGED" then
                GwPlayerPowerBar.lastPowerType = nil
                UpdatePowerData(GwPlayerPowerBar)
            end
        end
    )

    _G["GwPlayerPowerBarBarString"]:SetFont(DAMAGE_TEXT_FONT, 14)

    playerPowerBar:RegisterEvent("UNIT_POWER_FREQUENT")
    playerPowerBar:RegisterEvent("UNIT_MAXPOWER")
    playerPowerBar:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
    playerPowerBar:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
    playerPowerBar:RegisterEvent("PLAYER_ENTERING_WORLD")

    UpdatePowerData(GwPlayerPowerBar)

    -- show/hide stuff with override bar
    OverrideActionBar:HookScript(
        "OnShow",
        function()
            playerPowerBar:SetAlpha(0)
        end
    )
    OverrideActionBar:HookScript(
        "OnHide",
        function()
            playerPowerBar:SetAlpha(1)
        end
    )
end
GW.LoadPowerBar = LoadPowerBar

local function LoadPlayerHud()
    PlayerFrame:SetScript("OnEvent", nil)
    PlayerFrame:Hide()

    local playerHealthGLobaBg = CreateFrame("Button", "GwPlayerHealthGlobe", UIParent, "GwPlayerHealthGlobe")
    GwPlayerHealthGlobe.animationCurrent = 0

    playerHealthGLobaBg:EnableMouse(true)
    --  RegisterUnitWatch(playerHealthGLobaBg);

    --DELETE ME AFTER ACTIONBARS REWORK
    playerHealthGLobaBg:SetAttribute("*type1", "target")
    playerHealthGLobaBg:SetAttribute("*type2", "togglemenu")
    playerHealthGLobaBg:SetAttribute("unit", "player")

    AddToClique(playerHealthGLobaBg)

    --  RegisterUnitWatch(playerHealthGLobaBg)
    _G["GwPlayerHealthGlobeTextValue"]:SetFont(DAMAGE_TEXT_FONT, 16)
    _G["GwPlayerHealthGlobeTextValue"]:SetShadowColor(1, 1, 1, 0)

    _G["GwPlayerAbsorbGlobeTextValue"]:SetFont(DAMAGE_TEXT_FONT, 16)
    _G["GwPlayerAbsorbGlobeTextValue"]:SetShadowColor(1, 1, 1, 0)

    for i = 1, 8 do
        _G["GwPlayerHealthGlobeTextShadow" .. i]:SetFont(DAMAGE_TEXT_FONT, 16)
        _G["GwPlayerHealthGlobeTextShadow" .. i]:SetShadowColor(1, 1, 1, 0)
        _G["GwPlayerHealthGlobeTextShadow" .. i]:SetTextColor(0, 0, 0, 1 / i)

        _G["GwPlayerAbsorbGlobeTextShadow" .. i]:SetFont(DAMAGE_TEXT_FONT, 16)
        _G["GwPlayerAbsorbGlobeTextShadow" .. i]:SetShadowColor(1, 1, 1, 0)
        _G["GwPlayerAbsorbGlobeTextShadow" .. i]:SetTextColor(0, 0, 0, 1 / i)
    end
    _G["GwPlayerHealthGlobeTextShadow1"]:SetPoint("CENTER", -1, 0)
    _G["GwPlayerHealthGlobeTextShadow2"]:SetPoint("CENTER", 0, -1)
    _G["GwPlayerHealthGlobeTextShadow3"]:SetPoint("CENTER", 1, 0)
    _G["GwPlayerHealthGlobeTextShadow4"]:SetPoint("CENTER", 0, 1)
    _G["GwPlayerHealthGlobeTextShadow5"]:SetPoint("CENTER", -2, 0)
    _G["GwPlayerHealthGlobeTextShadow6"]:SetPoint("CENTER", 0, -2)
    _G["GwPlayerHealthGlobeTextShadow7"]:SetPoint("CENTER", 2, 0)
    _G["GwPlayerHealthGlobeTextShadow8"]:SetPoint("CENTER", 0, 2)

    _G["GwPlayerAbsorbGlobeTextShadow1"]:SetPoint("CENTER", -1, 0)
    _G["GwPlayerAbsorbGlobeTextShadow2"]:SetPoint("CENTER", 0, -1)
    _G["GwPlayerAbsorbGlobeTextShadow3"]:SetPoint("CENTER", 1, 0)
    _G["GwPlayerAbsorbGlobeTextShadow4"]:SetPoint("CENTER", 0, 1)
    _G["GwPlayerAbsorbGlobeTextShadow5"]:SetPoint("CENTER", -2, 0)
    _G["GwPlayerAbsorbGlobeTextShadow6"]:SetPoint("CENTER", 0, -2)
    _G["GwPlayerAbsorbGlobeTextShadow7"]:SetPoint("CENTER", 2, 0)
    _G["GwPlayerAbsorbGlobeTextShadow8"]:SetPoint("CENTER", 0, 2)

    playerHealthGLobaBg:SetScript(
        "OnEvent",
        function(self, event, unit)
            if unit == "player" then
                updateHealthData()
            end
        end
    )

    playerHealthGLobaBg:RegisterEvent("UNIT_HEALTH")
    playerHealthGLobaBg:RegisterEvent("UNIT_MAXHEALTH")
    playerHealthGLobaBg:RegisterEvent("PLAYER_ENTERING_WORLD")
    playerHealthGLobaBg:RegisterEvent("UNIT_ABSORB_AMOUNT_CHANGED")

    updateHealthData()

    local fmGDB = CreateFrame("Button", "GwDodgeBar", UIParemt, "GwDodgeBar")
    local fnGDB_OnEnter = function(self)
        self:SetScale(1.06)
        GameTooltip:SetOwner(self, "ANCHOR_PRESERVE")
        GameTooltip:ClearLines()
        GameTooltip:SetSpellByID(self.spellId)
        GameTooltip:Show()
    end
    local fnGDB_OnLeave = function(self)
        self:SetScale(1)
        GameTooltip_Hide()
    end
    fmGDB:SetScript("OnEnter", fnGDB_OnEnter)
    fmGDB:SetScript("Onleave", fnGDB_OnLeave)

    local ag = GwDodgeBar.spark:CreateAnimationGroup()
    local anim = ag:CreateAnimation("Rotation")
    GwDodgeBar.spark.anim = anim
    ag:SetLooping("REPEAT")

    GwDodgeBar.animation = 0

    GwDodgeBar:SetScript("OnEvent", dodgeBar_OnEvent)

    GwDodgeBar:RegisterEvent("SPELL_UPDATE_COOLDOWN")
    GwDodgeBar:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
    GwDodgeBar:RegisterEvent("CHARACTER_POINTS_CHANGED")
    GwDodgeBar:RegisterEvent("PLAYER_ENTERING_WORLD")

    dodgeBar_OnEvent(GwDodgeBar, "PLAYER_ENTERING_WORLD", "player")

    -- setup hooks for the repair icon (and disable default repair frame)
    DurabilityFrame:UnregisterAllEvents()
    DurabilityFrame:HookScript("OnShow", Self_Hide)
    DurabilityFrame:Hide()
    GwHudArtFrameRepair:SetScript("OnEvent", repair_OnEvent)
    GwHudArtFrameRepair:RegisterEvent("UPDATE_INVENTORY_DURABILITY")
    GwHudArtFrameRepair:SetScript(
        "OnEnter",
        function()
            GameTooltip:SetOwner(_G["GwHudArtFrameRepair"], "ANCHOR_CURSOR")
            GameTooltip:ClearLines()
            GameTooltip:AddLine(GwLocalization["DAMAGED_OR_BROKEN_EQUIPMENT"], 1, 1, 1)
            GameTooltip:Show()
        end
    )
    GwHudArtFrameRepair:SetScript("OnLeave", GameTooltip_Hide)
    repair_OnEvent()

    -- show/hide stuff with override bar
    OverrideActionBar:HookScript(
        "OnShow",
        function()
            GwPlayerHealthGlobe:SetAlpha(0)
            GwHudArtFrame:SetAlpha(0)
        end
    )
    OverrideActionBar:HookScript(
        "OnHide",
        function()
            GwPlayerHealthGlobe:SetAlpha(1)
            GwHudArtFrame:SetAlpha(1)
        end
    )
end
GW.LoadPlayerHud = LoadPlayerHud
