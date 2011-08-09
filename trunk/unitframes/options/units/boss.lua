--[[
	Project....: LUI NextGenWoWUserInterface
	File.......: boss.lua
	Description: oUF Boss Module
	Version....: 1.0
]] 

local _, ns = ...
local oUF = ns.oUF or oUF

local LUI = LibStub("AceAddon-3.0"):GetAddon("LUI")
local module = LUI:NewModule("oUF_Boss", "AceEvent-3.0")

local db

function module:ShowBossFrames()
	for k, v in next, oUF.objects do
		if v.unit and v.unit:find("boss") then
			v.unit_ = v.unit
			v:SetAttribute("unit", "player")
		end
	end
	
	local padding = oUF_LUI_boss:GetAttribute("Padding")
	local height = oUF_LUI_boss:GetAttribute("Height")
	oUF_LUI_boss:SetHeight(height * 4 + padding * 3)
	
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "HideBossFrames")
end

function module:HideBossFrames(event)
	self:UnregisterEvent("PLAYER_REGEN_DISABLED")
	
	for k, v in next, oUF.objects do
		if v.unit_ and v.unit_:find("boss") then
			v:SetAttribute("unit", v.unit_)
			v.unit_ = nil
		end
	end
	
	if event then
		LUI:Print("Dummy Boss Frames hidden due to combat")
	end
end

local defaults = {
	Boss = {
		Enable = true,
		UseBlizzard = false,
		Height = "24",
		Width = "130",
		X = "-25",
		Y = "-250",
		Scale = 1,
		Point = "TOPRIGHT",
		GrowDirection = "BOTTOM",
		Padding = "6",
		Border = {
			EdgeFile = "glow",
			EdgeSize = 5,
			Insets = {
				Left = "3",
				Right = "3",
				Top = "3",
				Bottom = "3",
			},
			Color = {
				r = "0",
				g = "0",
				b = "0",
				a = "1",
			},
		},
		Backdrop = {
			Texture = "Blizzard Tooltip",
			Padding = {
				Left = "-4",
				Right = "4",
				Top = "4",
				Bottom = "-4",
			},
			Color = {
				r = 0,
				g = 0,
				b = 0,
				a = 1,
			},
		},
		Health = {
			Height = "24",
			Width = "130",
			X = "0",
			Y = "0",
			Color = "Individual",
			Texture = "LUI_Gradient",
			TextureBG = "LUI_Gradient",
			BGAlpha = 1,
			BGMultiplier = 0.4,
			BGInvert = false,
			Smooth = true,
			IndividualColor = {
				r = 0.25,
				g = 0.25,
				b = 0.25,
			},
		},
		Power = {
			Enable = false,
			Height = "10",
			Width = "130",
			X = "0",
			Y = "-26",
			Color = "By Class",
			Texture = "LUI_Minimalist",
			TextureBG = "LUI_Minimalist",
			BGAlpha = 1,
			BGMultiplier = 0.4,
			BGInvert = false,
			Smooth = true,
			IndividualColor = {
				r = 0.8,
				g = 0.8,
				b = 0.8,
			},
		},
		Full = {
			Enable = false,
			Height = "14",
			Width = "130",
			X = "0",
			Y = "-36",
			Texture = "LUI_Minimalist",
			Alpha = 1,
			Color = {
				r = "0.11",
				g = "0.11",
				b = "0.11",
				a = "1",
			},
		},
		Aura = {
			buffs_colorbytype = false,
			buffs_playeronly = false,
			buffs_includepet = false,
			buffs_enable = false,
			buffs_auratimer = false,
			buffs_disableCooldown = false,
			buffs_cooldownReverse = true,
			buffsX = "0",
			buffsY = "-42",
			buffs_initialAnchor = "BOTTOMLEFT",
			buffs_growthY = "DOWN",
			buffs_growthX = "RIGHT",
			buffs_size = "26",
			buffs_spacing = "2",
			buffs_num = "8",
			debuffs_colorbytype = true,
			debuffs_playeronly = true,
			debuffs_includepet = false,
			debuffs_enable = true,
			debuffs_auratimer = false,
			debuffs_disableCooldown = false,
			debuffs_cooldownReverse = true,
			debuffsX = "35",
			debuffsY = "-5",
			debuffs_initialAnchor = "RIGHT",
			debuffs_growthY = "DOWN",
			debuffs_growthX = "RIGHT",
			debuffs_size = "26",
			debuffs_spacing = "2",
			debuffs_num = "36",
		},
		Castbar = {
			Enable = false,
			Height = "20",
			Width = "100",
			X = "-10",
			Y = "0",
			Texture = "LUI_Gradient",
			TextureBG = "LUI_Minimalist",
			IndividualColor = false,
			Icon = false,
			Text = {
				Name = {
					Enable = true,
					Font = "neuropol",
					Size = 13,
					OffsetX = "5",
					OffsetY = "1",
				},
				Time = {
					Enable = false,
					ShowMax = true,
					Font = "neuropol",
					Size = 13,
					OffsetX = "-5",
					OffsetY = "1",
				},
			},
			Border = {
				Texture = "glow",
				Thickness = "4",
				Inset = {
					left = "3",
					right = "3",
					top = "3",
					bottom = "3",
				},
			},
			Colors = {
				Bar = {
					r = 0.13,
					g = 0.59,
					b = 1,
					a = 0.68,
				},
				Background = {
					r = 0.15,
					g = 0.15,
					b = 0.15,
					a = 0.67,
				},
				Border = {
					r = 0,
					g = 0,
					b = 0,
					a = 0.7,
				},
				Shield = {
					Enable = true,
					r = 0.5,
					g = 0,
					b = 0,
					a = 0.1,
				},
				Name = {
					r = 0.9,
					g = 0.9,
					b = 0.9,
				},
				Time = {
					r = 0.9,
					g = 0.9,
					b = 0.9,
				},
			},
		},
		Portrait = {
			Enable = false,
			Height = "43",
			Width = "90",
			X = "0",
			Y = "0",
			Alpha = 1,
		},
		Icons = {
			Raid = {
				Enable = true,
				Size = 55,
				X = "0",
				Y = "0",
				Point = "CENTER",
			},
		},
		Texts = {
			Name = {
				Enable = true,
				Font = "Prototype",
				Size = 15,
				X = "0",
				Y = "0",
				IndividualColor = {
					r = 1,
					g = 1,
					b = 1,
				},
				Outline = "NONE",
				Point = "CENTER",
				RelativePoint = "CENTER",
				Format = "Name",
				Length = "Short",
				ColorNameByClass = false,
				ColorClassByClass = false,
				ColorLevelByDifficulty = false,
				ShowClassification = false,
				ShortClassification = false,
			},
			Health = {
				Enable = false,
				Font = "Prototype",
				Size = 24,
				X = "0",
				Y = "-43",
				Color = "Individual",
				ShowAlways = false,
				IndividualColor = {
					r = "0",
					g = "0",
					b = "0",
				},
				Outline = "NONE",
				Point = "BOTTOMLEFT",
				RelativePoint = "BOTTOMRIGHT",
				Format = "Absolut Short",
				ShowDead = false,
			},
			Power = {
				Enable = false,
				Font = "Prototype",
				Size = 24,
				X = "0",
				Y = "-66",
				Color = "By Class",
				ShowFull = true,
				ShowEmpty = true,
				IndividualColor = {
					r = "0",
					g = "0",
					b = "0",
				},
				Outline = "NONE",
				Point = "BOTTOMLEFT",
				RelativePoint = "BOTTOMRIGHT",
				Format = "Absolut Short",
			},
			HealthPercent = {
				Enable = false,
				Font = "Prototype",
				Size = 24,
				X = "0",
				Y = "0",
				Color = "Individual",
				ShowAlways = false,
				IndividualColor = {
					r = "0",
					g = "0",
					b = "0",
				},
				Outline = "NONE",
				Point = "CENTER",
				RelativePoint = "CENTER",
				ShowDead = true,
			},
			PowerPercent = {
				Enable = false,
				Font = "Prototype",
				Size = 24,
				X = "0",
				Y = "0",
				Color = "Individual",
				ShowFull = false,
				ShowEmpty = false,
				IndividualColor = {
					r = "0",
					g = "0",
					b = "0",
				},
				Outline = "NONE",
				Point = "CENTER",
				RelativePoint = "CENTER",
			},
			HealthMissing = {
				Enable = false,
				Font = "Prototype",
				Size = 24,
				X = "0",
				Y = "0",
				Color = "Individual",
				ShortValue = true,
				ShowAlways = false,
				IndividualColor = {
					r = "0",
					g = "0",
					b = "0",
				},
				Outline = "NONE",
				Point = "RIGHT",
				RelativePoint = "RIGHT",
			},
			PowerMissing = {
				Enable = false,
				Font = "Prototype",
				Size = 24,
				X = "0",
				Y = "0",
				Color = "Individual",
				ShortValue = true,
				ShowFull = false,
				ShowEmpty = false,
				IndividualColor = {
					r = "0",
					g = "0",
					b = "0",
				},
				Outline = "NONE",
				Point = "RIGHT",
				RelativePoint = "RIGHT",
			},
		},
		Fader = {
			Casting = true,
			Combat = true,
			Enable = false,
			Health = true,
			HealthClip = 1.0,
			Hover = true,
			HoverAlpha = 0.75,
			InAlpha = 1.0,
			OutAlpha = 0.1,
			OutDelay = 0.0,
			OutTime = 1.5,
			Power = true,
			PowerClip = 0.9,
			Targeting = true,
			UseGlobalSettings = true,
		},
	},
}

function module:LoadOptions()
	local ToggleBoss = function()
		if oUF_LUI_boss1 and oUF_LUI_boss1:IsShown() then
			module:HideBossFrames()
		else
			module:ShowBossFrames()
		end
	end
	
	local options = {
		Boss = {
			args = {
				General = {
					args = {
						General = {
							args = {
								empty = LUI:NewEmpty(3),
								toggle = LUI:NewExecute("Show/Hide", "Toggles the Boss Frames", 4, ToggleBoss, nil, function() return not db.oUF.Boss.Enable end),
							},
						},
					},
				},
			},
		},
	}
	
	return options
end

function module:OnInitialize()
	LUI:MergeDefaults(LUI.db.defaults.profile.oUF, defaults)
	LUI:RefreshDefaults()
	LUI:Refresh()
	
	self.db = LUI.db.profile
	db = self.db
	
	LUI:RegisterUnitFrame(self)
end

function module:OnEnable()
end