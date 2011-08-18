--[[
	Project.: LUI NextGenWoWUserInterface
	File....: LUI.lua
	Version.: 3.403
	Rev Date: 13/02/2011
	Author..: Louí [EU-Das Syndikat] <In Fidem>
]] 

local addonname, LUI = ...
local L = LUI.L

local AceAddon = LibStub("AceAddon-3.0")
AceAddon:EmbedLibraries(LUI, "AceComm-3.0", "AceConsole-3.0", "AceEvent-3.0", "AceHook-3.0")

-- this is a temp globalization (should make it check for alpha verion to globalize or not once all other files dont need global)
_G.LUI = LUI
_G.oUF = LUI.oUF

local Media = LibStub("LibSharedMedia-3.0")
local widgetLists = AceGUIWidgetLSMlists
local ACD = LibStub("AceConfigDialog-3.0")
local ACR = LibStub("AceConfigRegistry-3.0")

LUI.Versions = {lui = 3403}

LUI.oUF_LUI = {}

LUI.dummy = function() return end

-- REGISTER FONTS
Media:Register("font", "vibrocen", [[Interface\Addons\LUI\media\fonts\vibrocen.ttf]])
Media:Register("font", "vibroceb", [[Interface\Addons\LUI\media\fonts\vibroceb.ttf]])
Media:Register("font", "Prototype", [[Interface\Addons\LUI\media\fonts\prototype.ttf]])
Media:Register("font", "neuropol", [[Interface\AddOns\LUI\media\fonts\neuropol.ttf]])
Media:Register("font", "AvantGarde_LT_Medium", [[Interface\AddOns\LUI\media\fonts\AvantGarde_LT_Medium.ttf]])
Media:Register("font", "Arial Narrow", [[Interface\AddOns\LUI\media\fonts\ARIALN.TTF]])
Media:Register("font", "Pepsi", [[Interface\AddOns\LUI\media\fonts\pepsi.ttf]])

-- REGISTER BORDERS
Media:Register("border", "glow", [[Interface\Addons\LUI\media\textures\borders\glow.tga]])
Media:Register("border", "Stripped", [[Interface\Addons\LUI\media\textures\borders\Stripped.tga]])
Media:Register("border", "Stripped_hard", [[Interface\Addons\LUI\media\textures\borders\Stripped_hard.tga]])
Media:Register("border", "Stripped_medium", [[Interface\Addons\LUI\media\textures\borders\Stripped_medium.tga]])

-- REGISTER STATUSBARS
Media:Register("statusbar", "oUF LUI", [[Interface\AddOns\LUI\media\textures\statusbars\oUF_LUI.tga]])
Media:Register("statusbar", "LUI_Gradient", [[Interface\AddOns\LUI\media\textures\statusbars\gradient32x32.tga]])
Media:Register("statusbar", "LUI_Minimalist", [[Interface\AddOns\LUI\media\textures\statusbars\Minimalist.tga]])
Media:Register("statusbar", "LUI_Ruben", [[Interface\AddOns\LUI\media\textures\statusbars\Ruben.tga]])
Media:Register("statusbar", "Smelly", [[Interface\AddOns\LUI\media\textures\statusbars\Smelly.tga]])
Media:Register("statusbar", "Neal", [[Interface\AddOns\LUI\media\textures\statusbars\Neal]])
Media:Register("statusbar", "RenaitreMinion", [[Interface\AddOns\LUI\media\textures\statusbars\RenaitreMinion.tga]])

local fdir = "Interface\\AddOns\\LUI\\media\\templates\\v3\\"

LUI.Media = {
	["blank"] = [[Interface\AddOns\LUI\media\textures\blank]],
	["normTex"] = [[Interface\AddOns\LUI\media\textures\statusbars\normTex]], -- texture used for nameplates healthbar
	["glowTex"] = [[Interface\AddOns\LUI\media\textures\statusbars\glowTex]], -- the glow texture around some frame.
	["chatcopy"] = [[Interface\AddOns\LUI\media\textures\icons\chatcopy]], -- the copy icon in your chatframe.
	["cross"] = [[Interface\AddOns\LUI\media\textures\icons\cross]], -- Worldmap Move Button.
	["party"] = [[Interface\AddOns\LUI\media\textures\icons\Party]], -- Worldmap Party Icon.
	["raid"] = [[Interface\AddOns\LUI\media\textures\icons\Raid]], -- Worldmap Raid Icon.
	["mail"] = [[Interface\AddOns\LUI\media\textures\icons\mail]], -- Minimap Mail Icon.
	["btn_normal"] = [[Interface\AddOns\LUI\media\textures\buttons\Normal]], -- Standard Button Texture example: Auras
	["btn_border"] = [[Interface\AddOns\LUI\media\textures\buttons\Border]], -- Button Border
	["btn_gloss"] = [[Interface\AddOns\LUI\media\textures\buttons\Gloss]], -- Button Overlay
}

local screen_height = string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)")
local screen_width = string.match(({GetScreenResolutions()})[GetCurrentResolution()], "(%d+)x%d+")
local _, class = UnitClass("player")

------------------------------------------------------
-- / CREATING DEFAULTS / --
------------------------------------------------------

LUI.defaults = {   
	profile = {
		General = {
			IsConfigured = false,
			HideErrors = false,
			HideTalentSpam = false,
			AutoInvite = false,
			AutoInviteKeyword = "",
			AutoAcceptInvite = false,
			BlizzFrameScale = 1,
			ModuleMessages = true,
			DamageFont = "neuropol",
			DamageFontSize = 25,
			DamageFontSizeCrit = 34,
		},
		Recount = {
			FontHack = true,
			FontSize = 13,
		},
	}
}

local db_
local db = setmetatable({}, {
	__index = function(t, k)
		return db_[k]
	end,
	__newindex = function(t, k, v)
		db_[k] = v
	end
})

function CheckResolution()
	local ScreenWidth = string.match(({GetScreenResolutions()})[GetCurrentResolution()], "(%d+)x%d+")
	local ScreenHeight = string.match(({GetScreenResolutions()})[GetCurrentResolution()], "%d+x(%d+)")
	
	if ScreenWidth == "1280" and ScreenHeight == "1024" then
		-- Repostion Info Texts
		local Infotext = LUI:Module("Infotext", true)
		if Infotext and false then -- broken with false until propper positions have been determinied
			Infotext.db.defaults.profile.Bags.X = -100
			Infotext.db.defaults.profile.Durability.X = 10
			Infotext.db.defaults.profile.FPS.X = 120
			Infotext.db.defaults.profile.Memory.X = 190
		end
		
		LUI.defaults.profile.Frames.Dps.X = -968
		LUI.defaults.profile.Frames.Dps.Y = 863
		
		LUI.defaults.profile.Frames.Tps.X = 5
		LUI.defaults.profile.Frames.Tps.Y = 882
		
		-- Repositon Auras
		LUI.defaults.profile.Auras.Spacing = "-12"
		LUI.defaults.profile.Auras.Anchor = "TOPRIGHT"
		LUI.defaults.profile.Auras.Growth = "LEFT"
		LUI.defaults.profile.Auras.Buffs.X = "-170"
		LUI.defaults.profile.Auras.Buffs.Y = "-75"
		LUI.defaults.profile.Auras.Debuffs.X = "-170"
		LUI.defaults.profile.Auras.Debuffs.Y = "-185"
	end
end

local function RGBToHex(r, g, b)
	r = r <= 255 and r >= 0 and r or 0
	g = g <= 255 and g >= 0 and g or 0
	b = b <= 255 and b >= 0 and b or 0
	return string.format("%02x%02x%02x", r, g, b)
end

function LUI:Kill(object)
	object.Show = LUI.dummy
	object:Hide()
end

local function scale(x)
	scaleUI = UIParent:GetEffectiveScale()
	mult = 768/screen_height/scaleUI
	LUI.mult = mult
	return mult*math.floor(x/mult+.5)
end

function LUI:Scale(x) return scale(x) end

function LUI:CreatePanel(f, w, h, a1, p, a2, x, y)
	sh = scale(h)
	sw = scale(w)
	f:SetFrameLevel(1)
	f:SetHeight(sh)
	f:SetWidth(sw)
	f:SetFrameStrata("BACKGROUND")
	f:SetPoint(a1, p, a2, x, y)
	f:SetBackdrop({
		bgFile = LUI.Media.blank, 
		edgeFile = LUI.Media.blank, 
		tile = false, tileSize = 0, edgeSize = LUI.mult, 
		insets = { left = -LUI.mult, right = -LUI.mult, top = -LUI.mult, bottom = -LUI.mult}
	})
	f:SetBackdropColor(.1,.1,.1,1)
	f:SetBackdropBorderColor(.6,.6,.6,1)
end

function LUI:StyleButton(b, checked) 
    local name = b:GetName()
 
    local button          = _G[name]
    local icon            = _G[name.."Icon"]
    local count           = _G[name.."Count"]
    local border          = _G[name.."Border"]
    local hotkey          = _G[name.."HotKey"]
    local cooldown        = _G[name.."Cooldown"]
    local nametext        = _G[name.."Name"]
    local flash           = _G[name.."Flash"]
    local normaltexture   = _G[name.."NormalTexture"]
	local icontexture     = _G[name.."IconTexture"]

	local hover = b:CreateTexture("frame", nil, self) -- hover
	hover:SetTexture(1,1,1,0.2)
	hover:SetHeight(button:GetHeight())
	hover:SetWidth(button:GetWidth())
	hover:SetPoint("TOPLEFT",button,2,-2)
	hover:SetPoint("BOTTOMRIGHT",button,-2,2)
	button:SetHighlightTexture(hover)

	local pushed = b:CreateTexture("frame", nil, self) -- pushed
	pushed:SetTexture(0.9,0.8,0.1,0.3)
	pushed:SetHeight(button:GetHeight())
	pushed:SetWidth(button:GetWidth())
	pushed:SetPoint("TOPLEFT",button,2,-2)
	pushed:SetPoint("BOTTOMRIGHT",button,-2,2)
	button:SetPushedTexture(pushed)
	
	local Infotext = self:Module("Infotext", true)
	count:SetFont(Media:Fetch("font", (Infotext and Infotext.db.profile.FPS.Font or "vibroceb")), (Infotext and Infotext.db.profile.FPS.FontSize or 12), "OUTLINE")
 
	if checked then
		local checked = b:CreateTexture("frame", nil, self) -- checked
		checked:SetTexture(0,1,0,0.3)
		checked:SetHeight(button:GetHeight())
		checked:SetWidth(button:GetWidth())
		checked:SetPoint("TOPLEFT",button,2,-2)
		checked:SetPoint("BOTTOMRIGHT",button,-2,2)
		button:SetCheckedTexture(checked)
	end
end

------------------------------------------------------
-- / CREATE ME A FRAME FUNC / --
------------------------------------------------------

function LUI:CreateMeAFrame(fart,fname,fparent,fwidth,fheight,fscale,fstrata,flevel,fpoint,frelativeFrame,frelativePoint,fofsx,fofsy,falpha,finherit)
	local f = CreateFrame(fart,fname,fparent,finherit)
	local sw = scale(fwidth)
	local sh = scale(fheight)
	local sx = scale(fofsx)
	local sy = scale(fofsy)
	f:SetWidth(sw)
	f:SetHeight(sh)
	--f:SetScale(fscale)
	f:SetFrameStrata(fstrata)
	f:SetFrameLevel(flevel)
	f:SetPoint(fpoint,frelativeFrame,frelativePoint,sx,sy)
	f:SetAlpha(falpha)
	return f  
end

------------------------------------------------------
-- / SYNC ADDON VERSION / --
------------------------------------------------------

function LUI:SyncAddonVersion()
	local luiversion, version, newVersion = GetAddOnMetadata(addonname, "Version"), "", ""
	local myRealm, myFaction, inGroup = GetRealmName(), (UnitFactionGroup("player") == "Horde" and 0 or 1), false
	
	while luiversion ~= nil do
		local pos = strfind(luiversion, "%.")
		if pos then
			version = version .. format("%03d.", strsub(luiversion, 1, pos-1))
			
			
			luiversion = strsub(luiversion, pos+1)
		else
			version = version .. format("%03d", luiversion)
			luiversion = nil
			newVersion = version
		end
	end
	
	local function sendVersion(distribution, target) -- (distribution [, target])
		if distribution == "WHISPER" and not target then
			return
		elseif distribution == "RAID" then
			local zoneType = select(2, IsInInstance())
			if zoneType == "pvp" or zoneType == "arena" then
				distribution = "BATTLEGROUND"
			end
		end
		
		LUI:SendCommMessage("LUI_Version", version, distribution, target)
	end
	
	local function checkVersion(prefix, text, distribution, from)
		if version < text and newVersion < text then -- your version out of date (only print once)
			newVersion = text
			LUI:Print(format(L["Version %s available for download."], gsub(text, "%d+", tonumber)))
		elseif version > text and distribution ~= "WHISPER" then -- their version out of date (tell them)
			sendVersion("WHISPER", from)
		end
	end
	
	local function groupUpdate(groupType)
		if not groupType then return end
		if groupType == "Party" and GetNumRaidMembers() > 0 then return end
		
		if (groupType == "Party" and (GetNumPartyMembers() >= 1) or (GetNumRaidMembers() >= 1)) then
			if inGroup then return end
			inGroup = true
			sendVersion("Raid")
		else
			inGroup = false
		end
	end
	
	LUI:RegisterComm("LUI_Version", checkVersion)
	
	for i = 1, GetNumFriends() do -- send to friends via whisper on login
		local name, _, _, _, connected = GetFriendInfo(i)
		if name and connected then
			sendVersion("WHISPER", name)
		end
	end
	for i = 1, BNGetNumFriends() do -- send to BN friends (on your realm) via whisper on login
		local _, _, _, toonName, toonID, client, isOnline = BNGetFriendInfo(i)
		if toonName and isOnline and client == "WoW" then
			local _, _, _, realmName, _, faction = BNGetToonInfo(toonID or 0)
			if realmName == myRealm and faction == myFaction then
				sendVersion("WHISPER", toonName)
			end
		end
	end
	sendVersion("GUILD") -- send to guild on login
	LUI:RegisterEvent("PARTY_MEMBERS_CHANGED", groupUpdate, "Party") -- send to party on join party
	LUI:RegisterEvent("RAID_ROSTER_UPDATE", groupUpdate, "Raid") -- send to raid on join raid
end

------------------------------------------------------
-- / SET DAMAGE FONT / --
------------------------------------------------------

function LUI:SetDamageFont()
	local DamageFont = Media:Fetch("font", db.General.DamageFont)

	COMBAT_TEXT_SCROLLSPEED = 1.9
	COMBAT_TEXT_FADEOUT_TIME = 1.3
	DAMAGE_TEXT_FONT = DamageFont
	COMBAT_TEXT_HEIGHT = db.General.DamageFontSize
	COMBAT_TEXT_CRIT_MAXHEIGHT = db.General.DamageFontSizeCrit
	COMBAT_TEXT_CRIT_MINHEIGHT = db.General.DamageFontSizeCrit - 2
end

------------------------------------------------------
-- / LOAD EXTRA MODULES / --
------------------------------------------------------

function LUI:LoadExtraModules()
	for i=1, GetNumAddOns() do
		local name, _, _, enabled, loadable = GetAddOnInfo(i)
		if strfind(name, "LUI_") and enabled and loadable then
			LoadAddOn(i)
		end
	end
end

------------------------------------------------------
-- / UPDATE / --
------------------------------------------------------

function LUI:Update()
	local updateBG = LUI:CreateMeAFrame("FRAME","updateBG",UIParent,2400,2000,1,"HIGH",5,"CENTER",UIParent,"CENTER",0,0,1)
	updateBG:SetBackdrop({bgFile="Interface\\Tooltips\\UI-Tooltip-Background", edgeFile="Interface\\Tooltips\\UI-Tooltip-Border", tile=0, tileSize=0, edgeSize=1, insets={left=0, right=0, top=0, bottom=0}})
	updateBG:SetBackdropColor(0,0,0,1)
	updateBG:SetBackdropBorderColor(0,0,0,0)
	updateBG:SetAlpha(1)
	updateBG:Show() 
	
	local updatelogo = LUI:CreateMeAFrame("FRAME","updatelogo",UIParent,512,512,1,"HIGH",6,"CENTER",UIParent,"CENTER",0,150,1)
	updatelogo:SetBackdrop({bgFile=fdir.."logo", edgeFile="Interface\\Tooltips\\UI-Tooltip-Border", tile=0, tileSize=0, edgeSize=1, insets={left=0, right=0, top=0, bottom=0}})
	updatelogo:SetBackdropBorderColor(0,0,0,0)
	updatelogo:Show()
	
	local update = LUI:CreateMeAFrame("FRAME","update",updatelogo,512,512,1,"HIGH",6,"BOTTOM",updatelogo,"BOTTOM",0,-130,1)
	update:SetBackdrop({bgFile=fdir.."update", edgeFile="Interface\\Tooltips\\UI-Tooltip-Border", tile=0, tileSize=0, edgeSize=1, insets={left=0, right=0, top=0, bottom=0}})
	update:SetBackdropColor(1,1,1,1)
	update:SetBackdropBorderColor(0,0,0,0)
	update:Show()
	
	local update_hover = LUI:CreateMeAFrame("FRAME","update_hover",updatelogo,512,512,1,"HIGH",7,"BOTTOM",updatelogo,"BOTTOM",0,-130,1)
	update_hover:SetBackdrop({bgFile=fdir.."update_hover", edgeFile="Interface\\Tooltips\\UI-Tooltip-Border", tile=0, tileSize=0, edgeSize=1, insets={left=0, right=0, top=0, bottom=0}})
	update_hover:SetBackdropColor(1,1,1,1)
	update_hover:SetBackdropBorderColor(0,0,0,0)
	update_hover:Hide()
	
	local update_frame = LUI:CreateMeAFrame("BUTTON","update_frame",updatelogo,310,80,1,"HIGH",8,"BOTTOM",updatelogo,"BOTTOM",-5,90,1)
	update_frame:SetBackdrop({bgFile="Interface\\Tooltips\\UI-Tooltip-Background", edgeFile="Interface\\Tooltips\\UI-Tooltip-Border", tile=0, tileSize=0, edgeSize=1, insets={left=0, right=0, top=0, bottom=0}})
	update_frame:SetBackdropColor(1,1,1,0)
	update_frame:SetBackdropBorderColor(0,0,0,0)
	update_frame:Show()
	
	update_frame:SetScript("OnEnter", function(self)
		update:Hide()
		update_hover:Show()
	end)
	
	update_frame:SetScript("OnLeave", function(self)
		update_hover:Hide()
		update:Show()
	end)

	update_frame:RegisterForClicks("AnyUp")
	update_frame:SetScript("OnClick", function(self)
		
		if IsAddOnLoaded("Grid") then
			LUICONFIG.Versions.grid = nil
			LUI:InstallGrid()
		end
		
		if IsAddOnLoaded("Recount") then
			LUICONFIG.Versions.recount = nil
			LUI:InstallRecount()
		end
		
		if IsAddOnLoaded("Omen") or IsAddOnLoaded("Omen3") then
			LUICONFIG.Versions.omen = nil
			LUI:InstallOmen()
		end
		
		if IsAddOnLoaded("Forte_Core") then
			LUICONFIG.Versions.forte = nil
			LUI:InstallForte()
		end
	
		LUICONFIG.Versions.lui = LUI.Versions.lui
		ReloadUI()
	end)
end

------------------------------------------------------
-- / CONFIGURE / --
------------------------------------------------------

function LUI:Configure()
	if InterfaceOptionsFrame:IsShown() then
		InterfaceOptionsFrame:Hide()
	end
	
	local configureBG = LUI:CreateMeAFrame("FRAME","configureBG",UIParent,2400,2000,1,"HIGH",5,"CENTER",UIParent,"CENTER",0,0,1)
	configureBG:SetBackdrop({bgFile="Interface\\Tooltips\\UI-Tooltip-Background", edgeFile="Interface\\Tooltips\\UI-Tooltip-Border", tile=0, tileSize=0, edgeSize=1, insets={left=0, right=0, top=0, bottom=0}})
	configureBG:SetBackdropColor(0,0,0,1)
	configureBG:SetBackdropBorderColor(0,0,0,0)
	configureBG:SetAlpha(1)
	configureBG:Show() 
	
	local logo = LUI:CreateMeAFrame("FRAME","logo",UIParent,512,512,1,"HIGH",6,"CENTER",UIParent,"CENTER",0,150,1)
	logo:SetBackdrop({bgFile=fdir.."logo", edgeFile="Interface\\Tooltips\\UI-Tooltip-Border", tile=0, tileSize=0, edgeSize=1, insets={left=0, right=0, top=0, bottom=0}})
	logo:SetBackdropBorderColor(0,0,0,0)
	logo:Show()
	
	local install = LUI:CreateMeAFrame("FRAME","install",logo,512,512,1,"HIGH",6,"BOTTOM",logo,"BOTTOM",0,-130,1)
	install:SetBackdrop({bgFile=fdir.."install", edgeFile="Interface\\Tooltips\\UI-Tooltip-Border", tile=0, tileSize=0, edgeSize=1, insets={left=0, right=0, top=0, bottom=0}})
	install:SetBackdropColor(1,1,1,1)
	install:SetBackdropBorderColor(0,0,0,0)
	install:Show()
	
	local install_hover = LUI:CreateMeAFrame("FRAME","install_hover",logo,512,512,1,"HIGH",7,"BOTTOM",logo,"BOTTOM",0,-130,1)
	install_hover:SetBackdrop({bgFile=fdir.."install_hover", edgeFile="Interface\\Tooltips\\UI-Tooltip-Border", tile=0, tileSize=0, edgeSize=1, insets={left=0, right=0, top=0, bottom=0}})
	install_hover:SetBackdropColor(1,1,1,1)
	install_hover:SetBackdropBorderColor(0,0,0,0)
	install_hover:Hide()
	
	local install_frame = LUI:CreateMeAFrame("BUTTON","install_frame",logo,310,80,1,"HIGH",8,"BOTTOM",logo,"BOTTOM",-5,90,1)
	install_frame:SetBackdrop({bgFile="Interface\\Tooltips\\UI-Tooltip-Background", edgeFile="Interface\\Tooltips\\UI-Tooltip-Border", tile=0, tileSize=0, edgeSize=1, insets={left=0, right=0, top=0, bottom=0}})
	install_frame:SetBackdropColor(1,1,1,0)
	install_frame:SetBackdropBorderColor(0,0,0,0)
	install_frame:Show()
	
	install_frame:SetScript("OnEnter", function(self)
		install:Hide()
		install_hover:Show()
	end)
	
	install_frame:SetScript("OnLeave", function(self)
		install_hover:Hide()
		install:Show()
	end)

	install_frame:RegisterForClicks("AnyUp")
	install_frame:SetScript("OnClick", function(self) 

		SetCVar("buffDurations", 1)
		SetCVar("consolidateBuffs", 0)
		SetCVar("scriptErrors", 1)
		SetCVar("uiScale", 0.6949)
		SetCVar("useUiScale", 1)
		SetCVar("chatMouseScroll", 1)
		SetCVar("chatStyle", "classic")
		
		if LUICONFIG.Versions then
			wipe(LUICONFIG.Versions)
		end
		
		LUI:InstallGrid()
		LUI:InstallRecount()
		LUI:InstallOmen()
		LUI:InstallBartender()
		LUI:InstallForte()

		LUICONFIG.Versions.lui = LUI.Versions.lui
		LUICONFIG.IsConfigured = true
		ReloadUI()
	end)
end

------------------------------------------------------
-- / MODULES / --
------------------------------------------------------

-- LUI:Module(name [, silent]) to get module
-- LUI:Module(name [, prototype] [, libs...]) -- to create module or add to module
function LUI:Module(name, prototype, ...)
	local i = 1
	local module = self:GetModule(name, true)
	if module then
		if type(prototype) == "string" then
			AceAddon:EmbedLibraries(module, prototype, ...)
		elseif type(prototype) == "table" then
			AceAddon:EmbedLibraries(module, ...)
			
			-- set prototype
			local mt = getmetatable(module)
			mt.__index = prototype
			setmetatable(module, mt)
		end
	elseif prototype ~= true then
		module = self:NewModule(name, prototype, ...)
	end
	
	return module
end

function LUI:Toggle()
	local success = self[self:IsEnabled() and "Disable" or "Enable"](self)
	if self.db and self.db.profile and self.db.profile.Enable ~= nil then
		self.db.profile.Enable = self:IsEnabled()
	end
	return success
end

local function conflictChecker(...)
	for i=1, select("#", ...) do
		if IsAddOnLoaded(select(i, ...)) then
			return select(i, ...)
		end
	end
end
function LUI:CheckConflict(...) -- self is module
	local conflict = false
	if type(self.conflicts) == "table" then
		conflict = conflictChecker(unpack(self.conflicts))
	else
		conflict = conflictChecker((";"):split(self.conflicts))
	end
	
	if conflict then
		-- disable without calling OnDisable function
		LibStub("AceAddon-3.0").statuses[self.name] = false
		self:SetEnabledState(false)
		if db.General.ModuleMessages then
			LUI:Print("|cffFF0000" .. self:GetName() .. " could not be enabled because of a conflicting addon: "..conflict..".")
		end
		return
	else
		return LUI.hooks[self].OnEnable(self, ...)
	end
end

LUI:SetDefaultModuleLibraries("LUIDevAPI")
LUI:SetDefaultModulePrototype({Toggle = LUI.Toggle})

------------------------------------------------------
-- / SCRIPTS / --
------------------------------------------------------

local scripts = {}

function LUI:NewScript(name, ...)
	local script = {}
	scripts[name] = script

	local errormsg
	for i=1, select("#", ...) do
		local lib = select(i, ...)
		if type(lib) ~= "string" then
			errormsg = "Error generating script: "..name.." - library names must be string values!"
		elseif not LibStub(lib, true) then
			errormsg = "Error generating script: "..name.." - '"..lib.."' library does not exist!"
		elseif type(LibStub(lib).Embed) ~= "function" then
			errormsg = "Error generating script: "..name.." - '"..lib.."' library is not Embedable!"
		end
		if errormsg then
			return self:Print(errormsg)
		end

		LibStub(lib):Embed(script)
	end

	return script
end

function LUI:FetchScript(name)
	return scripts[name]
end

------------------------------------------------------
-- / OPTIONS MENU / --
------------------------------------------------------

local options, moduleList, moduleOptions, newModuleOptions, frameOptions, unitframeOptions = nil, {}, {}, {}, {}, {}

function LUI:MergeOptions(target, source, sort)
	if type(target) ~= "table" then target = {} end
	for k,v in pairs(target) do
		if k == "type" and v ~= "group" then
			target = {}
			break
		end
	end
	for k,v in pairs(source) do
		if type(v) == "table" then
			target[k] = self:MergeOptions(target[k], v)
			
			-- Sort modules by name if they don't have an order.
			if sort then target[k].order = target[k].order or 10 end
		else
			target[k] = v
		end
	end
	return target
end

local function getOptions()
	if not LUI.options then
		LUI.options = {
			name = "LUI",
			type = "group",
			args = {
				General = {
					name = "General",
					order = 1,
					type = "group",
					childGroups = "tab",
					args = {
						Welcome = {
							name = "Welcome",
							type = "group",
							order = 1,
							args = {
								IntroImage = {
									order = 1,
									image = [[Interface\AddOns\LUI\media\textures\logo]],
									imageWidth = 512,
									width = "full",
									imageHeight = 128,
									imageCoords = { 0, 1, 0, 1 },
									type = "description",
									name = " ",
								},
								empty5 = {
									name = "   ",
									width = "full",
									type = "description",
									order = 2,
								},
								IntroText = {
									order = 3,
									width = "full",
									type = "description",
									name = L["Welcome to LUI v3"].."\n\n"..L["Please read the FAQ"].."\n\n\n",
								},
								VerText = {
									order = 4,
									width = "full",
									type = "description",
									name = L["Version: "]..GetAddOnMetadata(addonname, "Version"),
								},
								RevText = {
									order = 5,
									width = "full",
									type = "description",
									name = function()
											local revision = GetAddOnMetadata(addonname, "X-Curse-Packaged-Version")
											return L["Revision: "]..(revision or "???")
										end,
								},
							},
						},
						Settings = {
							name = "Settings",
							type = "group",
							order = 2,
							args = {
								header2 = {
									name = "General Options",
									type = "header",
									order = 1,
								},
								empty5 = {
									name = "   ",
									width = "full",
									type = "description",
									order = 2,
								},
								empty512s = {
									name = "   ",
									width = "full",
									type = "description",
									order = 3,
								},
								AlwaysShowDesc = {
									order = 4,
									width = "full",
									type = "description",
									name = "LUI will show automaticly all Frames which were shown after logging out.\n\nYou can set some Rules here that LUI should always show some Frames regardless of how you are logging off."
								},
								empty6 = {
									name = "   ",
									width = "full",
									type = "description",
									order = 5,
								},
								alwaysShowMinimap = {
									name = "Show Minimap",
									desc = "Whether you want to show the Minimap by entering World or not.\n",
									type = "toggle",
									get = function() return db.Frames.AlwaysShowMinimap end,
									set = function()
												db.Frames.AlwaysShowMinimap = not db.Frames.AlwaysShowMinimap
											end,
									order = 6,
								},
								alwaysShowChat = {
									name = "Show Chat",
									desc = "Whether you want to show the Chat by entering World or not.\n",
									type = "toggle",
									get = function() return db.Frames.AlwaysShowChat end,
									set = function()
												db.Frames.AlwaysShowChat = not db.Frames.AlwaysShowChat
											end,
									order = 7,
								},
								alwaysShowOmen = {
									name = "Show Omen",
									desc = "Whether you want to show Omen by entering World or not.\n",
									type = "toggle",
									get = function() return db.Frames.AlwaysShowOmen end,
									set = function()
												db.Frames.AlwaysShowOmen = not db.Frames.AlwaysShowOmen
											end,
									order = 8,
								},
								alwaysShowRecount = {
									name = "Show Recount",
									desc = "Whether you want to show Recount by entering World or not.\n",
									type = "toggle",
									get = function() return db.Frames.AlwaysShowRecount end,
									set = function()
												db.Frames.AlwaysShowRecount = not db.Frames.AlwaysShowRecount
											end,
									order = 9,
								},
								alwaysShowGrid = {
									name = "Show Grid",
									desc = "Whether you want to show Grid by entering World or not.\n",
									type = "toggle",
									get = function() return db.Frames.AlwaysShowGrid end,
									set = function()
												db.Frames.AlwaysShowGrid = not db.Frames.AlwaysShowGrid
											end,
									order = 10,
								},
								alwaysShowMicroMenu = {
									name = "Show MicroMenu",
									desc = "Whether you want to show the Micromenu by entering World or not.\n",
									type = "toggle",
									get = function() return db.Frames.AlwaysShowMicroMenu end,
									set = function()
												db.Frames.AlwaysShowMicroMenu = not db.Frames.AlwaysShowMicroMenu
											end,
									order = 12,
								},
								empty22225 = {
									name = "   ",
									width = "full",
									type = "description",
									order = 13,
								},
								header90 = {
									name = "Misc Options",
									type = "header",
									order = 30,
								},
								BlizzFrameScale = {
									name = "Blizzard Frame Scale",
									desc = "Set the scale of the Blizzard Frames.\nEx: CharacterFrame, SpellBookFrame, etc...",
									type = "range",
									min = 0.5,
									max = 2.0,
									step = 0.05,
									isPercent = true,
									width = "double",
									get = function() return db.General.BlizzFrameScale end,
									set = function(info, value)
											if scale == nil or scale == "" then scale = 1 end
											db.General.BlizzFrameScale = value
											LUI:FetchScript("BlizzScale"):SetBlizzScale()
										end,
									order = 32,
								},
								empty3 = {
									name = " ",
									width = "full",
									type = "description",
									order = 33,
								},
								BlockErrors = {
									name = "Hide Blizzard Error Messages",
									desc = "Hide Blizzard Errors like: Not enough energy or Not enough Mana",
									type = "toggle",
									width = "full",
									get = function() return db.General.HideErrors end,
									set = function(info, value)
											db.General.HideErrors = value
											LUI:FetchScript("ErrorHider"):ErrorMessageHandler()
										end,
									order = 34,
								},
								HideTalentSpam = {
									name = "Hide Talent Change Spam",
									desc = "Filters out the chat window spam that occurs when you switch specs",
									type = "toggle",
									width = "full",
									get = function() return db.General.HideTalentSpam end,
									set = function(info, value)
											db.General.HideTalentSpam = value
											LUI:FetchScript("TalentSpam"):SetTalentSpam()
										end,
									order = 35,
								},
								ModuleMessages = {
									name = "Show Module Messages",
									desc = "Show messages when LUI modules are enabled or disabled",
									type = "toggle",
									width = "full",
									get = function() return db.General.ModuleMessages end,
									set = function() db.General.ModuleMessages = not db.General.ModuleMessages end,
									order = 36,
								},
								AutoAcceptInvite = {
									name = "Enable Auto Accept Invites",
									desc = "Choose if you want to accept all Invites from Guildmembers/Friends or not.",
									type = "toggle",
									width = "full",
									get = function() return db.General.AutoAcceptInvite end,
									set = function(info, value)
											db.General.AutoAcceptInvite = value
											LUI:FetchScript("AutoInvite"):SetAutoAccept()
										end,
									order = 37,
								},
								AutoInvite = {
									name = "Enable Autoinvite",
									desc = "Choose if you want to Enable Autoinvite or not.",
									type = "toggle",
									width = "full",
									get = function() return db.General.Autoinvite end,
									set = function(info, value)
											db.General.Autoinvite = value
											LUI:FetchScript("AutoInvite"):SetAutoInvite()
										end,
									order = 38,
								},
								AutoInviteKeyword = {
									name = "Auto Invite Keyword",
									desc = "Choose any Keyword for Auto Invite",
									type = "input",
									disabled = function() return not db.General.Autoinvite end,
									get = function() return db.General.AutoInviteKeyword end,
									set = function(info, value)
											if value == nil then AutoInviteKeyword = "" end
											db.General.AutoInviteKeyword = value
										end,
									order = 39,
								},
								header91 = {
									name = "Damage Font/Size",
									type = "header",
									order = 45,
								},
								DamageFont = {
									name = "Font",
									desc = "Choose your Font!\n\nNote:\nYou have to Relog!.\nType /rl\n\nDefault: neuropol",
									type = "select",
									dialogControl = "LSM30_Font",
									values = widgetLists.font,
									get = function()
											return db.General.DamageFont
										end,
									set = function(self, DamageFont)
											db.General.DamageFont = DamageFont
										end,
									order = 46,
								},
								empty3445 = {
									name = "   ",
									width = "full",
									type = "description",
									order = 47,
								},
								DamageFontSize = {
									name = "Fontsize",
									desc = "Choose your Fontsize!\n\nNote:\nYou have to Relog!.\nType /rl\n\nDefault: 38",
									type = "range",
									min = 20,
									max = 60,
									step = 1,
									get = function() return db.General.DamageFontSize end,
									set = function(_, DamageFontSize) 
												db.General.DamageFontSize = DamageFontSize
											end,
									order = 48,
								},
								empty34456 = {
									name = "   ",
									width = "full",
									type = "description",
									order = 49,
								},
								DamageFontSizeCrit = {
									name = "Fontsize Crits",
									desc = "Choose your Fontsize for Crits!\n\nNote:\nYou have to Relog!.\nType /rl\n\nDefault: 41",
									type = "range",
									min = 20,
									max = 60,
									step = 1,
									get = function() return db.General.DamageFontSizeCrit end,
									set = function(_, DamageFontSizeCrit) 
												db.General.DamageFontSizeCrit = DamageFontSizeCrit
											end,
									order = 50,
								},
							},
						},
						Addons = {
							name = "Addons",
							type = "group",
							order = 4,
							args = {
								Header1 = {
									name = "Restore Addon Defaults",
									type = "header",
									order = 1,
								},
								ResetBartender = {
									order = 2,
									type = "execute",
									name = "Restore Bartender",
									func = function()
										LUICONFIG.Versions.bartender = nil
										LUI:InstallBartender()
										StaticPopup_Show("RELOAD_UI")
									end,
								},
								ResetForte = {
									order = 2,
									type = "execute",
									name = "Restore ForteXorcist",
									func = function()
										LUICONFIG.Versions.forte = nil
										LUI:InstallForte()
										StaticPopup_Show("RELOAD_UI")
									end,
								},
								ResetGrid = {
									order = 2,
									type = "execute",
									name = "Restore Grid",
									func = function()
										LUICONFIG.Versions.grid = nil
										LUI:InstallGrid()
										StaticPopup_Show("RELOAD_UI")
									end,
								},
								ResetOmen = {
									order = 2,
									type = "execute",
									name = "Restore Omen",
									func = function()
										LUICONFIG.Versions.omen = nil
										LUI:InstallOmen()
										StaticPopup_Show("RELOAD_UI")
									end,
								},
								ResetRecount = {
									order = 2,
									type = "execute",
									name = "Restore Recount",
									func = function()
										LUICONFIG.Versions.recount = nil
										LUI:InstallRecount()
										StaticPopup_Show("RELOAD_UI")
									end,
								},
								Header2 = {
									name = "Recount Settings",
									type = "header",
									order = 3,
									hidden = function() return not IsAddOnLoaded("Recount") end,
								},
								RecountHack = {
									name = "Force Font Size",
									desc = "Whether or not to apply a font size fix to Recount.",
									type = "toggle",
									order = 4,
									disabled = function() return not IsAddOnLoaded("Recount") end,
									hidden = function() return not IsAddOnLoaded("Recount") end,
									get = function() return db.Recount.FontHack end,
									set = function() LUI.RecountFontHack:Toggle() end,								
								},
								RecountFontSize = {
									name = "Font Size",
									desc = "Set the font size for Recount's bars.",
									type = "range",
									min = 6,
									max = 32,
									step = 1,
									disabled = function() return not IsAddOnLoaded("Recount") or not db.Recount.FontHack end,
									hidden = function() return not IsAddOnLoaded("Recount") end,
									get = function() return db.Recount.FontSize end,
									set = function(self, size)
											db.Recount.FontSize = size
											Recount:BarsChanged()
										end,
									order = 5,
								},
								Header3 = {
									name = "Restore ALL Addon Defaults",
									type = "header",
									order = 6,
								},
								ResetDesc = {
									order = 7,
									width = "full",
									type = "description",
									name = "ATTENTION:\nAll SavedVariables from Grid, Recount, Omen, Bartender and ForteXorcist will be resetted!"
								},
								Reset = {
									order = 8,
									type = "execute",
									name = "Restore Defaults",
									func = function()
										StaticPopup_Show("RESTORE_DETAULTS")
									end,
								},
							},
						},
					},
				},
				Space = {
					name = "",
					order = 8,
					type = "group",
					args = {},
				},
				Modules = {
					name = "|cffffffffModules:|r",
					order = 9,
					type = "group",
					args = {
						Header = LUI:NewHeader("Module List", 1),
						UpdatedModules = LUI:NewHeader("New Style Modules", 75),
					},
				},
			},
		}
		LUI.options.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(LUI.db)
		LUI.options.args.profiles.order = 4
		
		LUI.options.args.profiles.args.new.disabled = true -- remove once all modules are using namespaces
		LUI.options.args.profiles.args.choose.disabled = true -- remove once all modules are using namespaces
		
		for k,v in pairs(moduleList) do
			LUI.options.args.Modules.args = LUI:MergeOptions(LUI.options.args.Modules.args, (type(v) == "function") and v() or v)
		end
		
		for k,v in pairs(moduleOptions) do
			LUI.options.args = LUI:MergeOptions(LUI.options.args, (type(v) == "function") and v() or v, true)
		end
		
		for k,v in pairs(newModuleOptions) do -- all modules need to be converted over to this
			local module = type(v) == "string" and LUI:Module(v) or v
			LUI.options.args[module:GetName()] = module:NewGroup(module.optionsName or module:GetName(), module.order or 10, module.childGroups or "tab", module.getter or "skip", module.setter or "skip", 
				false, function() return not module:IsEnabled() end, type(module.LoadOptions) == "function" and module:LoadOptions() or module.options)
		end
		
		for k,v in pairs(frameOptions) do
			LUI.options.args.Frames.args = LUI:MergeOptions(LUI.options.args.Frames.args, (type(v) == "function") and v() or v)
		end
		
		for k,v in pairs(unitframeOptions) do
			LUI.options.args.UnitFrames.args = LUI:MergeOptions(LUI.options.args.UnitFrames.args, (type(v) == "function") and v() or v)
		end
	end
	
	return LUI.options
end

function LUI:RegisterOptions(module)
	table.insert(moduleOptions, module.LoadOptions)
end

function LUI:RegisterAddon(module, addon)
	if IsAddOnLoaded(addon) then
		LUI:RegisterOptions(module)
	end
end

function LUI:RegisterUnitFrame(module)
	table.insert(unitframeOptions, module.LoadOptions)
end

function LUI:RegisterFrame(module)
	table.insert(frameOptions, module.LoadOptions)
end

function LUI:RegisterModule(module, moduledb, addFunc)
	local mName = module:GetName()
	local moduledb = moduledb and moduledb or mName
	
	table.insert(moduleList, {
		[mName] = {
			type = "execute",
			name = function() return (mName .. ": |cff" .. (db[moduledb].Enable and "00FF00Enabled" or "FF0000Disabled") .. "|r") end,
			order = 50,
			func = function()
				db[moduledb].Enable = not db[moduledb].Enable
				if db[moduledb].Enable then
					--module:Enable()
					if db.General.ModuleMessages then LUI:Print(mName.." Module Enabled") end
				else
					--module:Disable()
					if db.General.ModuleMessages then LUI:Print(mName.." Module Disabled") end
				end
				if addFunc ~= nil then addFunc() end
				--LUI:Print("The reload UI in the LUI:RegisterModule function can be removed once all the modules have an OnDisable function added and formatted correctly")
				StaticPopup_Show("RELOAD_UI")
			end,
		},
	})
	
	LUI:RegisterOptions(module)
	
	module:SetEnabledState(db[moduledb].Enable)
end

local function mergeOldDB(dest, src)
	if type(dest) ~= "table" then dest = {} end
	for k,v in pairs(src) do
		if type(v) == type(dest[k]) then
			if type(v) == "table" then
				dest[k] = mergeOldDB(dest[k], v)
			else
				dest[k] = v
			end
		end
	end
	return dest
end

function LUI:NewNamespace(module, enableButton)
	local mName = module:GetName()
	
	-- Add options loader function to list
	if (not module.addon) or IsAddOnLoaded(module.addon) then
		table.insert(newModuleOptions, mName)
	end
	
	-- Register namespace
	local mdb = self.db:RegisterNamespace(mName, module.defaults)
	
	-- Create db metatable
	module.db = setmetatable({}, {
		__index = function(t, k)
			if mdb[k] then
				return mdb[k]
			else
				return mdb.profile[k]
			end
		end,
		__newindex = function(t, k, v)
			if mdb[k] then
				mdb[k] = v
			else
				mdb.profile[k] = v
			end
		end,
		__call = function(t, info, value)
			local dbloc = mdb.profile
			for i=2, #info-1 do
				dbloc = dbloc[info[i]]
				if type(dbloc) ~= "table" then
					error("Error accessing db:\nCould not access "..strjoin(".", info[1], "db.profile", unpack(info, 2, dbloc == nil and i or i+1)).."\ndb layout must be the same as info", 2)
				end
			end
			if value ~= nil then
				dbloc[info[#info]] = value
			else
				return dbloc[info[#info]]
			end
		end,
	})
	
	-- Create defaults metatable (the module.defaults table was handed off to AceDB and now exists as module.db.defaults)
	module.defaults = setmetatable({}, {
		__index = function(t, k)
			if mdb.defaults[k] then
				return mdb.defaults[k]
			else
				return mdb.defaults.profile[k]
			end
		end,
		__newindex = function(t, k, v)
			if mdb.defaults[k] then
				mdb.defaults[k] = v
			else
				mdb.defaults.profile[k] = v
			end
		end,
		__call = function(t, info, value)
			local dbloc = mdb.defaults.profile
			for i=2, #info-1 do
				dbloc = dbloc[info[i]]
				if type(dbloc) ~= "table" then
					error("Error accessing db:\nCould not access "..strjoin(".", info[1], "db.defaults.profile", unpack(info, 2, dbloc == nil and i or i+1)).."\ndb layout must be the same as info", 2)
				end
			end
			if value ~= nil then
				dbloc[info[#info]] = value
			else
				return dbloc[info[#info]]
			end
		end,
	})
	
	-- Look for outdated db vars and transfer them over
	if LUI.db.profile[mName] then
		mergeOldDB(module.db.profile, LUI.db.profile[mName])
		LUI.db.profile[mName] = nil
	end
	
	-- Set module enabled state
	if LUI.defaultModuleState ~= false and module.db.profile.Enable ~= nil then
		module:SetEnabledState(module.db.profile.Enable)
	end
	
	-- Hook conflicting addon checker
	if module.conflicts then
		LUI:RawHook(module, "OnEnable", LUI.CheckConflict)
	end
	
	-- Register Callbacks
	if type(module.Refresh) == "function" then
		module.db.RegisterCallback(module, "OnProfileChanged", LUI.RefreshModule, module)
		module.db.RegisterCallback(module, "OnProfileCopied", LUI.RefreshModule, module)
		module.db.RegisterCallback(module, "OnProfileReset", LUI.RefreshModule, module)
	end
	
	-- Create Enable button for module if applicable
	if enableButton then
		table.insert(moduleList, {
			[mName] = {
				type = "execute",
				name = function() return (mName .. ": |cff" .. (module:IsEnabled() and "00FF00Enabled" or "FF0000Disabled") .. "|r") end,
				desc = function() return ("Left Click: " .. (module:IsEnabled() and "Enable" or "Disable") .. " this module.\nShift Click: Reset modules settings.") end,
				func = function()
					if IsShiftKeyDown() then
						local enabled = module.db.profile.Enable
						module.db:ResetProfile()
						module.db.profile.Enable = enabled -- keep enabled/disabled state (callback from ResetProfile is based on modules enabled state, not the db var)
						
						if db.General.ModuleMessages then
							LUI:Print(mName .. " module settings reset.")
						end
					else
						if module:Toggle() and db.General.ModuleMessages then
							LUI:Print(mName .. " module |cff" .. (module.db.profile.Enable and "00FF00enabled" or "FF0000disabled") .. "|r.")
						end
					end
				end,
			},
		})
	end
	
	return module.db, module.defaults
end



------------------------------------------------------
-- / SETUP LUI / --
------------------------------------------------------

function LUI:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("LUIDB", LUI.defaults, true)
	db_ = self.db.profile
	
	self.db.RegisterCallback(self, "OnProfileChanged", "Refresh")
	self.db.RegisterCallback(self, "OnProfileCopied", "Refresh")
	self.db.RegisterCallback(self, "OnProfileReset", "Refresh")
	
	self:RegisterChatCommand(addonname, "ChatCommand")
	
	LUICONFIG = LUICONFIG or {}
	LUICONFIG.Versions = LUICONFIG.Versions or {}
	
	if LUICONFIG.IsConfigured and LUICONFIG.Versions.lui == LUI.Versions.lui then
		self:RegisterEvent("ADDON_LOADED", "SetDamageFont", self)
		self:LoadExtraModules()
	else
		self.defaultModuleState = false
		for name, module in self:IterateModules() do
			module:SetEnabledState(false)
		end
	end
	
	StaticPopupDialogs["RELOAD_UI"] = {
		text = L["The UI needs to be reloaded!"],
		button1 = ACCEPT,
		button2 = CANCEL,
		OnAccept = ReloadUI,
		timeout = 0,
		whileDead = 1,
		hideOnEscape = 1
	}
	
	StaticPopupDialogs["RESTORE_DETAULTS"] = {
		text = "Do you really want to restore all defaults. All your settings will be lost!",
		button1 = ACCEPT,
		button2 = CANCEL,
		OnAccept = Configure,
		timeout = 0,
		whileDead = 1,
		hideOnEscape = 1
	}
end

function LUI:OnEnable()
	db_ = self.db.profile
	CheckResolution()
	
	if not LUICONFIG.IsConfigured then
		self.db.UnregisterAllCallbacks(self)
		self.db:SetProfile(UnitName("player").." - "..GetRealmName())
		self:Configure()
	elseif LUICONFIG.Versions.lui ~= LUI.Versions.lui then
		self:Update()
	else
		local LoginMsg = false
		if(LoginMsg==true) then
			print(" ")
			print("Welcome on |c0090ffffLUI v3|r for Patch 3.3.5 !")
			print("For more Information visit www.wow-lui.com")
		end
		
		self:SyncAddonVersion()
	end
end

function LUI:MergeDefaults(target, source)
	if type(target) ~= "table" then target = {} end
	for k,v in pairs(source) do
		if type(v) == "table" then
			target[k] = self:MergeDefaults(target[k], v)
		elseif not target[k] then
			target[k] = v
		end
	end
	return target
end

function LUI:RefreshDefaults()
	self.db:RegisterDefaults(LUI.defaults)
end

function LUI:Refresh(dbEvent)
	db_ = self.db.profile
	
	if not IsLoggedIn() then return end -- in case db callbacks fire before the OnEnable function
	
	if dbEvent then -- remove once all modules are using namespaces
		return ReloadUI()
	end
	
	for name, module in self:IterateModules() do
		if module.db and module.db.profile and module.db.profile.Enable ~= nil then
			module[module.db.profile.Enable and "Enable" or "Disable"](module)
		end
	end
end

function LUI:RefreshModule(...) -- LUI.RefreshModule(module, callback_event, db, ...)
	if AceAddon.statuses[self.name] then -- check if self is enabled and if OnEnable script has ran
		self:Refresh(...)
	end
end

function LUI:Open(force)
	function LUI:Open(force)
		if ACD.OpenFrames.LUI and not force then
			ACD:Close("LUI")
		else
			ACD:Open("LUI")
			ACD.OpenFrames.LUI.frame:SetScale(db.General.BlizzFrameScale)
			ACD.OpenFrames.LUI:SetCallback("OnClose", function(widget, event)
				widget.frame:SetScale(1)
				local appName = widget:GetUserData("appName")
				ACD.OpenFrames[appName] = nil
				LibStub("AceGUI-3.0"):Release(widget)
			end)
		end
	end
	
	self.optionsFrames = {}
	LibStub("AceConfig-3.0"):RegisterOptionsTable(addonname, getOptions)
	ACD:SetDefaultSize("LUI", 720,525)
	
	local function refreshOptions()
		if ACD.OpenFrames.LUI then
			ACR:NotifyChange("LUI")
		end
	end
	self:RegisterEvent("PLAYER_REGEN_ENABLED", refreshOptions)
	self:RegisterEvent("PLAYER_REGEN_DISABLED", refreshOptions)
	
	return LUI:Open(force)
end

function LUI:ChatCommand(input)
	if not input or input:trim() == "" then
		LUI:Open()
	else
		local arg = self:GetArgs(input)
		if arg:lower() == "debug" then
			self:Debug()
		else
			LibStub("AceConfigCmd-3.0").HandleCommand(LUI, "lui", "LUI", input)
		end
	end
end