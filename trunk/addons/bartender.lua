--[[
	Project....: LUI NextGenWoWUserInterface
	File.......: bartender.lua
	Description: Bartender 4 Install Script
	Version....: 1.0
]]

local addonname, LUI = ...

LUI.Versions.bartender = 3300

function LUI:InstallBartender()
	if not IsAddOnLoaded("Bartender4") then return end

	local CharName = UnitName("player")
	local ServerName = GetRealmName()
	local ProfileName = CharName.." - "..ServerName

	if LUI.db.global.luiconfig[ProfileName] and LUI.db.global.luiconfig[ProfileName].Versions.bartender == LUI.Versions.bartender then return end

	_G.BagBarDefaults = {
		[CharName] = {
			["skin"] = {
				["Colors"] = {
					["Normal"] = {
						0.203921568627451, -- [1]
						0.203921568627451, -- [2]
						0.203921568627451, -- [3]
						1, -- [4]
					},
					["Pushed"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						0.3199999928474426, -- [4]
					},
					["Highlight"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["Gloss"] = {
						0.9803921568627451, -- [1]
						0.9803921568627451, -- [2]
						0.9803921568627451, -- [3]
						1, -- [4]
					},
					["Backdrop"] = {
						0.9803921568627451, -- [1]
						1, -- [2]
						0.9686274509803922, -- [3]
						1, -- [4]
					},
					["Border"] = {
						0.08235294117647059, -- [1]
						1, -- [2]
						0.04313725490196078, -- [3]
						1, -- [4]
					},
					["Checked"] = {
						0.9882352941176471, -- [1]
						1, -- [2]
						0.984313725490196, -- [3]
						1, -- [4]
					},
				},
				["ID"] = "Caith",
				["Backdrop"] = false,
			},
			["enabled"] = false,
			["show"] = "alwayshide",
			["version"] = 3,
			["position"] = {
				["y"] = 6.869293713785169,
				["x"] = 62.96281414890549,
				["point"] = "LEFT",
			},
		},
	}

	for k,v in pairs(BagBarDefaults) do
		Bartender4DB.namespaces.BagBar.profiles[k] = v
	end

	_G.RepBarDefaults = {
		[CharName] = {
			["position"] = {
				["y"] = 9.999978772832151,
				["x"] = 361.714377491161,
				["point"] = "LEFT",
			},
			["version"] = 3,
		},
	}

	for k,v in pairs(RepBarDefaults) do
		Bartender4DB.namespaces.RepBar.profiles[k] = v
	end

	_G.XPBarDefaults = {
		[CharName] = {
			["position"] = {
				["y"] = 218.9714880476636,
				["x"] = 398.3903171500545,
				["point"] = "BOTTOMLEFT",
				["scale"] = 0.9,
			},
			["visibility"] = {
				["possess"] = false,
			},
			["version"] = 3,
		},
	}

	for k,v in pairs(XPBarDefaults) do
		Bartender4DB.namespaces.XPBar.profiles[k] = v
	end

	_G.ActionBarsDefaults = {
		[CharName] = {
			["actionbars"] = {
				{
					["skin"] = {
						["Colors"] = {
							["Normal"] = {
								0.1333333333333333, -- [1]
								0.1333333333333333, -- [2]
								0.1333333333333333, -- [3]
								0.9500000029802322, -- [4]
							},
							["Pushed"] = {
								0.3215686274509804, -- [1]
								0.3215686274509804, -- [2]
								0.3215686274509804, -- [3]
								1, -- [4]
							},
							["Highlight"] = {
								0.403921568627451, -- [1]
								0.403921568627451, -- [2]
								0.403921568627451, -- [3]
								1, -- [4]
							},
							["Gloss"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["Backdrop"] = {
								0.1098039215686275, -- [1]
								0.1098039215686275, -- [2]
								0.1098039215686275, -- [3]
								1, -- [4]
							},
							["Flash"] = {
								1, -- [1]
								0, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["Border"] = {
								0.407843137254902, -- [1]
								0.403921568627451, -- [2]
								0.4117647058823529, -- [3]
								1, -- [4]
							},
							["Checked"] = {
								0.01176470588235294, -- [1]
								0.01176470588235294, -- [2]
								0.01176470588235294, -- [3]
								0, -- [4]
							},
							["Disabled"] = {
								0.9882352941176471, -- [1]
								1, -- [2]
								0.9490196078431372, -- [3]
								1, -- [4]
							},
						},
						["ID"] = "Darion",
						["Gloss"] = 0.3,
					},
					["version"] = 3,
					["position"] = {
						["y"] = 60,
						["x"] = -197,
						["point"] = "BOTTOM",
						["scale"] = 0.85,
					},
					["hidehotkey"] = true,
					["hidemacrotext"] = true,
					["visibility"] = {
						["always"] = false,
					},
					["states"] = {
						["actionbar"] = false,
					},
				}, -- [1]
				{
					["fadeoutdelay"] = 0,
					["skin"] = {
						["Colors"] = {
							["Normal"] = {
								0.1333333333333333, -- [1]
								0.1333333333333333, -- [2]
								0.1333333333333333, -- [3]
								0.9500000029802322, -- [4]
							},
							["Pushed"] = {
								0.3215686274509804, -- [1]
								0.3215686274509804, -- [2]
								0.3215686274509804, -- [3]
								1, -- [4]
							},
							["Highlight"] = {
								0.403921568627451, -- [1]
								0.403921568627451, -- [2]
								0.403921568627451, -- [3]
								1, -- [4]
							},
							["Gloss"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["Backdrop"] = {
								0.1098039215686275, -- [1]
								0.1098039215686275, -- [2]
								0.1098039215686275, -- [3]
								1, -- [4]
							},
							["Flash"] = {
								1, -- [1]
								0, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["Border"] = {
								0.407843137254902, -- [1]
								0.403921568627451, -- [2]
								0.4117647058823529, -- [3]
								1, -- [4]
							},
							["Checked"] = {
								0.01176470588235294, -- [1]
								0.01176470588235294, -- [2]
								0.01176470588235294, -- [3]
								0, -- [4]
							},
							["Disabled"] = {
								0.9882352941176471, -- [1]
								1, -- [2]
								0.9490196078431372, -- [3]
								1, -- [4]
							},
						},
						["ID"] = "Darion",
						["Gloss"] = 0.3,
					},
					["hidehotkey"] = true,
					["fadeoutalpha"] = 0,
					["version"] = 3,
					["position"] = {
						["y"] = 94,
						["x"] = -197,
						["point"] = "BOTTOM",
						["scale"] = 0.85,
					},
					["hidemacrotext"] = true,
					["visibility"] = {
						["possess"] = false,
						["always"] = false,
					},
				}, -- [2]
				{
					["skin"] = {
						["Colors"] = {
							["Normal"] = {
								0.1333333333333333, -- [1]
								0.1333333333333333, -- [2]
								0.1333333333333333, -- [3]
								0.9500000029802322, -- [4]
							},
							["Pushed"] = {
								0.3215686274509804, -- [1]
								0.3215686274509804, -- [2]
								0.3215686274509804, -- [3]
								1, -- [4]
							},
							["Disabled"] = {
								0.9882352941176471, -- [1]
								1, -- [2]
								0.9490196078431372, -- [3]
								1, -- [4]
							},
							["Highlight"] = {
								0.403921568627451, -- [1]
								0.403921568627451, -- [2]
								0.403921568627451, -- [3]
								1, -- [4]
							},
							["Gloss"] = {
								0.9803921568627451, -- [1]
								0.9803921568627451, -- [2]
								0.9803921568627451, -- [3]
								1, -- [4]
							},
							["Backdrop"] = {
								0.1098039215686275, -- [1]
								0.1098039215686275, -- [2]
								0.1098039215686275, -- [3]
								1, -- [4]
							},
							["Border"] = {
								0.407843137254902, -- [1]
								0.403921568627451, -- [2]
								0.4117647058823529, -- [3]
								1, -- [4]
							},
							["Checked"] = {
								0.01176470588235294, -- [1]
								0.01176470588235294, -- [2]
								0.01176470588235294, -- [3]
								0, -- [4]
							},
						},
						["ID"] = "Darion",
						["Gloss"] = 0.3,
					},
					["enabled"] = false,
					["hidehotkey"] = true,
					["show"] = "alwayshide",
					["version"] = 3,
					["position"] = {
						["y"] = 173.326953106798,
						["x"] = 344.0160633672025,
						["point"] = "LEFT",
						["scale"] = 0.8999999761581421,
					},
					["hidemacrotext"] = true,
					["visibility"] = {
						["possess"] = false,
						["always"] = false,
						["vehicleui"] = false,
					},
				}, -- [3]
				{
					["skin"] = {
						["Colors"] = {
							["Normal"] = {
								0.1333333333333333, -- [1]
								0.1333333333333333, -- [2]
								0.1333333333333333, -- [3]
								0.9500000029802322, -- [4]
							},
							["Pushed"] = {
								0.3215686274509804, -- [1]
								0.3215686274509804, -- [2]
								0.3215686274509804, -- [3]
								1, -- [4]
							},
							["Highlight"] = {
								0.403921568627451, -- [1]
								0.403921568627451, -- [2]
								0.403921568627451, -- [3]
								1, -- [4]
							},
							["Gloss"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["Backdrop"] = {
								0.1098039215686275, -- [1]
								0.1098039215686275, -- [2]
								0.1098039215686275, -- [3]
								1, -- [4]
							},
							["Flash"] = {
								1, -- [1]
								0, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["Border"] = {
								0.407843137254902, -- [1]
								0.403921568627451, -- [2]
								0.4117647058823529, -- [3]
								1, -- [4]
							},
							["Checked"] = {
								0.01176470588235294, -- [1]
								0.01176470588235294, -- [2]
								0.01176470588235294, -- [3]
								0, -- [4]
							},
							["Disabled"] = {
								0.9882352941176471, -- [1]
								1, -- [2]
								0.9490196078431372, -- [3]
								1, -- [4]
							},
						},
						["ID"] = "Darion",
						["Gloss"] = 0.3,
					},
					["hidehotkey"] = true,
					["show"] = "alwayshide",
					["version"] = 3,
					["position"] = {
						["y"] = -266.7948988830055,
						["x"] = 344.0160633672025,
						["point"] = "TOPLEFT",
						["scale"] = 0.8999999761581421,
					},
					["hidemacrotext"] = true,
					["visibility"] = {
						["possess"] = false,
						["always"] = true,
						["vehicleui"] = false,
					},
				}, -- [4]
				{
					["skin"] = {
						["Colors"] = {
							["Normal"] = {
								0.1333333333333333, -- [1]
								0.1333333333333333, -- [2]
								0.1333333333333333, -- [3]
								0.9500000029802322, -- [4]
							},
							["Pushed"] = {
								0.3215686274509804, -- [1]
								0.3215686274509804, -- [2]
								0.3215686274509804, -- [3]
								1, -- [4]
							},
							["Highlight"] = {
								0.403921568627451, -- [1]
								0.403921568627451, -- [2]
								0.403921568627451, -- [3]
								1, -- [4]
							},
							["Gloss"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["Backdrop"] = {
								0.1098039215686275, -- [1]
								0.1098039215686275, -- [2]
								0.1098039215686275, -- [3]
								1, -- [4]
							},
							["Flash"] = {
								1, -- [1]
								0, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["Border"] = {
								0.407843137254902, -- [1]
								0.403921568627451, -- [2]
								0.4117647058823529, -- [3]
								1, -- [4]
							},
							["Checked"] = {
								0.01176470588235294, -- [1]
								0.01176470588235294, -- [2]
								0.01176470588235294, -- [3]
								0, -- [4]
							},
							["Disabled"] = {
								0.9882352941176471, -- [1]
								1, -- [2]
								0.9490196078431372, -- [3]
								1, -- [4]
							},
						},
						["ID"] = "Darion",
						["Gloss"] = 0.3,
					},
					["enabled"] = false,
					["hidehotkey"] = true,
					["version"] = 3,
					["position"] = {
						["y"] = 209.326940513326,
						["x"] = 344.0160633672025,
						["point"] = "LEFT",
						["scale"] = 0.8999999761581421,
					},
					["hidemacrotext"] = true,
					["visibility"] = {
						["possess"] = false,

						["always"] = false,
						["vehicleui"] = false,
					},
				}, -- [5]
				{
					["skin"] = {
						["Colors"] = {
							["Normal"] = {
								0.1333333333333333, -- [1]
								0.1333333333333333, -- [2]
								0.1333333333333333, -- [3]
								0.9500000029802322, -- [4]
							},
							["Pushed"] = {
								0.3215686274509804, -- [1]
								0.3215686274509804, -- [2]
								0.3215686274509804, -- [3]
								1, -- [4]
							},
							["Highlight"] = {
								0.403921568627451, -- [1]
								0.403921568627451, -- [2]
								0.403921568627451, -- [3]
								1, -- [4]
							},
							["Gloss"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["Backdrop"] = {
								0.1098039215686275, -- [1]
								0.1098039215686275, -- [2]
								0.1098039215686275, -- [3]
								1, -- [4]
							},
							["Flash"] = {
								1, -- [1]
								0, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["Border"] = {
								0.407843137254902, -- [1]
								0.403921568627451, -- [2]
								0.4117647058823529, -- [3]
								1, -- [4]
							},
							["Checked"] = {
								0.01176470588235294, -- [1]
								0.01176470588235294, -- [2]
								0.01176470588235294, -- [3]
								0, -- [4]
							},
							["Disabled"] = {
								0.9882352941176471, -- [1]
								1, -- [2]
								0.9490196078431372, -- [3]
								1, -- [4]
							},
						},
						["ID"] = "Darion",
						["Gloss"] = 0.3,
					},
					["hidehotkey"] = true,
					["version"] = 3,
					["position"] = {
						["y"] = 245.3267011968378,
						["x"] = 344.0160633672025,
						["point"] = "LEFT",
						["scale"] = 0.8999999761581421,
					},
					["hidemacrotext"] = true,
					["visibility"] = {
						["possess"] = false,
						["always"] = true,
						["vehicleui"] = false,
					},
				}, -- [6]
				{
					["skin"] = {
						["Colors"] = {
							["Normal"] = {
								0.1333333333333333, -- [1]
								0.1333333333333333, -- [2]
								0.1333333333333333, -- [3]
								0.9500000029802322, -- [4]
							},
							["Pushed"] = {
								0.3215686274509804, -- [1]
								0.3215686274509804, -- [2]
								0.3215686274509804, -- [3]
								1, -- [4]
							},
							["Disabled"] = {
								0.9882352941176471, -- [1]
								1, -- [2]
								0.9490196078431372, -- [3]
								1, -- [4]
							},
							["Highlight"] = {
								0.403921568627451, -- [1]
								0.403921568627451, -- [2]
								0.403921568627451, -- [3]
								1, -- [4]
							},
							["Gloss"] = {
								0.9803921568627451, -- [1]
								0.9803921568627451, -- [2]
								0.9803921568627451, -- [3]
								1, -- [4]
							},
							["Backdrop"] = {
								0.1098039215686275, -- [1]
								0.1098039215686275, -- [2]
								0.1098039215686275, -- [3]
								1, -- [4]
							},
							["Border"] = {
								0.407843137254902, -- [1]
								0.403921568627451, -- [2]
								0.4117647058823529, -- [3]
								1, -- [4]
							},
							["Checked"] = {
								0.01176470588235294, -- [1]
								0.01176470588235294, -- [2]
								0.01176470588235294, -- [3]
								0, -- [4]
							},
						},
						["ID"] = "Darion",
						["Gloss"] = 0.3,
					},
					["hidehotkey"] = true,
					["version"] = 3,
					["position"] = {
						["y"] = 137.3269333112677,
						["x"] = 344.0160633672025,
						["point"] = "LEFT",
						["scale"] = 0.8999999761581421,
					},
					["hidemacrotext"] = true,
					["visibility"] = {
						["possess"] = false,
						["always"] = true,
					},
				}, -- [7]
				{
					["skin"] = {
						["Colors"] = {
							["Normal"] = {
								0.1333333333333333, -- [1]
								0.1333333333333333, -- [2]
								0.1333333333333333, -- [3]
								0.9500000029802322, -- [4]
							},
							["Pushed"] = {
								0.3215686274509804, -- [1]
								0.3215686274509804, -- [2]
								0.3215686274509804, -- [3]
								1, -- [4]
							},
							["Disabled"] = {
								0.9882352941176471, -- [1]
								1, -- [2]
								0.9490196078431372, -- [3]
								1, -- [4]
							},
							["Highlight"] = {
								0.403921568627451, -- [1]
								0.403921568627451, -- [2]
								0.403921568627451, -- [3]
								1, -- [4]
							},
							["Gloss"] = {
								0.9803921568627451, -- [1]
								0.9803921568627451, -- [2]
								0.9803921568627451, -- [3]
								1, -- [4]
							},
							["Backdrop"] = {
								0.1098039215686275, -- [1]
								0.1098039215686275, -- [2]
								0.1098039215686275, -- [3]
								1, -- [4]
							},
							["Border"] = {
								0.407843137254902, -- [1]
								0.403921568627451, -- [2]
								0.4117647058823529, -- [3]
								1, -- [4]
							},
							["Checked"] = {
								0.01176470588235294, -- [1]
								0.01176470588235294, -- [2]
								0.01176470588235294, -- [3]
								0, -- [4]
							},
						},
						["ID"] = "Darion",
						["Gloss"] = 0.3,
					},
					["hidehotkey"] = true,
					["version"] = 3,
					["position"] = {
						["y"] = 101.3269459047398,
						["x"] = 344.0160633672025,
						["point"] = "LEFT",
						["scale"] = 0.8999999761581421,
					},
					["hidemacrotext"] = true,
					["visibility"] = {
						["possess"] = false,
						["always"] = true,
					},
				}, -- [8]
				{
					["rows"] = 6,
					["fadeoutdelay"] = 0,
					["skin"] = {
						["Colors"] = {
							["Normal"] = {
								0.1333333333333333, -- [1]
								0.1333333333333333, -- [2]
								0.1333333333333333, -- [3]
								0.9500000029802322, -- [4]
							},
							["Pushed"] = {
								0.3215686274509804, -- [1]
								0.3215686274509804, -- [2]
								0.3215686274509804, -- [3]
								1, -- [4]
							},
							["Checked"] = {
								0.01176470588235294, -- [1]
								0.01176470588235294, -- [2]
								0.01176470588235294, -- [3]
								0, -- [4]
							},
							["Gloss"] = {
								1, -- [1]
								1, -- [2]
								1, -- [3]
								1, -- [4]
							},
							["Border"] = {
								0.407843137254902, -- [1]
								0.403921568627451, -- [2]
								0.4117647058823529, -- [3]
								1, -- [4]
							},
							["Flash"] = {
								1, -- [1]
								0, -- [2]
								0, -- [3]
								1, -- [4]
							},
							["Backdrop"] = {
								0.1098039215686275, -- [1]
								0.1098039215686275, -- [2]
								0.1098039215686275, -- [3]
								1, -- [4]
							},
							["Highlight"] = {
								0.403921568627451, -- [1]
								0.403921568627451, -- [2]
								0.403921568627451, -- [3]
								1, -- [4]
							},
							["Disabled"] = {
								0.9882352941176471, -- [1]
								1, -- [2]
								0.9490196078431372, -- [3]
								1, -- [4]
							},
						},
						["ID"] = "Darion",
						["Gloss"] = 0.3,
					},
					["enabled"] = true,
					["fadeoutalpha"] = 0,
					["version"] = 3,
					["hidehotkey"] = true,
					["position"] = {
						["y"] = 65.20006318506091,
						["x"] = 30.77499950488759,
						["point"] = "LEFT",
						["scale"] = 0.8500000238418579,
					},
					["hidemacrotext"] = true,
					["visibility"] = {
						["possess"] = false,
						["always"] = false,
						["vehicleui"] = false,
					},
				}, -- [9]
				{
					["rows"] = 6,
					["fadeoutdelay"] = 0,
					["skin"] = {
						["Colors"] = {
							["Normal"] = {
								0.1333333333333333, -- [1]
								0.1333333333333333, -- [2]
								0.1333333333333333, -- [3]
								0.9500000029802322, -- [4]
							},
							["Pushed"] = {
								0.3215686274509804, -- [1]
								0.3215686274509804, -- [2]
								0.3215686274509804, -- [3]
								1, -- [4]
							},
							["Checked"] = {
								0.01176470588235294, -- [1]
								0.01176470588235294, -- [2]
								0.01176470588235294, -- [3]
								0, -- [4]
							},
							["Highlight"] = {
								0.403921568627451, -- [1]
								0.403921568627451, -- [2]
								0.403921568627451, -- [3]
								1, -- [4]
							},
							["Backdrop"] = {
								0.1098039215686275, -- [1]
								0.1098039215686275, -- [2]
								0.1098039215686275, -- [3]
								1, -- [4]
							},
							["Border"] = {
								0.407843137254902, -- [1]
								0.403921568627451, -- [2]
								0.4117647058823529, -- [3]
								1, -- [4]
							},
						},
						["Gloss"] = 0.3,
						["ID"] = "Darion",
					},
					["enabled"] = true,
					["alpha"] = 0,
					["version"] = 3,
					["hidehotkey"] = true,
					["fadeoutalpha"] = 0,
					["position"] = {
						["y"] = 65.20006318506091,
						["x"] = -103.0250394585505,
						["point"] = "RIGHT",
						["scale"] = 0.8500000238418579,
					},
					["hidemacrotext"] = true,
					["visibility"] = {
						["custom"] = false,
						["customdata"] = "",
						["always"] = false,
						["possess"] = false,
						["vehicleui"] = false,
					},
				}, -- [10]
			},
		},
	}

	for k,v in pairs(ActionBarsDefaults) do
		Bartender4DB.namespaces.ActionBars.profiles[k] = v
	end

	_G.VehicleDefaults = {
		[CharName] = {
			["version"] = 3,
			["fadeoutalpha"] = 1,
			["skin"] = {
				["Colors"] = {
					["Normal"] = {
						0.1333333333333333, -- [1]
						0.1333333333333333, -- [2]
						0.1333333333333333, -- [3]
						0.9500000029802322, -- [4]
					},
					["Pushed"] = {
						0.3215686274509804, -- [1]
						0.3215686274509804, -- [2]
						0.3215686274509804, -- [3]
						1, -- [4]
					},
					["Highlight"] = {
						0.403921568627451, -- [1]
						0.403921568627451, -- [2]
						0.403921568627451, -- [3]
						1, -- [4]
					},
					["Checked"] = {
						0.01176470588235294, -- [1]
						0.01176470588235294, -- [2]
						0.01176470588235294, -- [3]
						0, -- [4]
					},
					["Gloss"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["Border"] = {
						0.407843137254902, -- [1]
						0.403921568627451, -- [2]
						0.4117647058823529, -- [3]
						1, -- [4]
					},
					["Backdrop"] = {
						0.1098039215686275, -- [1]
						0.1098039215686275, -- [2]
						0.1098039215686275, -- [3]
						1, -- [4]
					},
					["Flash"] = {
						1, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
				},
				["Gloss"] = 0.3,
				["ID"] = "Darion",
			},
			["fadeoutdelay"] = 1,
			["padding"] = 0,
			["visibility"] = {
				["nopet"] = false,
				["always"] = false,
				["possess"] = false,
			},
			["position"] = {
				["y"] = -184.1292338095927,
				["x"] = 432.4822981234832,
				["point"] = "LEFT",
				["scale"] = 0.9,
			},
		},
	}

	for k,v in pairs(VehicleDefaults) do
		Bartender4DB.namespaces.Vehicle.profiles[k] = v
	end

	_G.StanceBarDefaults = {
		[CharName] = {
			["position"] = {
				["y"] = -16.50000411188517,
				["x"] = -82.49990584837293,
				["point"] = "CENTER",
				["scale"] = 1,
			},
			["fadeoutalpha"] = 1,
			["skin"] = {
				["Colors"] = {
					["Normal"] = {
						0.1333333333333333, -- [1]
						0.1333333333333333, -- [2]
						0.1333333333333333, -- [3]
						0.9500000029802322, -- [4]
					},
					["Pushed"] = {
						0.3215686274509804, -- [1]
						0.3215686274509804, -- [2]
						0.3215686274509804, -- [3]
						1, -- [4]
					},
					["Highlight"] = {
						0.403921568627451, -- [1]
						0.403921568627451, -- [2]
						0.403921568627451, -- [3]
						1, -- [4]
					},
					["Gloss"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["Backdrop"] = {
						0.1098039215686275, -- [1]
						0.1098039215686275, -- [2]
						0.1098039215686275, -- [3]
						1, -- [4]
					},
					["Flash"] = {
						1, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["Border"] = {
						0.407843137254902, -- [1]
						0.403921568627451, -- [2]
						0.4117647058823529, -- [3]
						1, -- [4]
					},
					["Checked"] = {
						0.01176470588235294, -- [1]
						0.01176470588235294, -- [2]
						0.01176470588235294, -- [3]
						0, -- [4]
					},
					["Disabled"] = {
						0.9882352941176471, -- [1]
						1, -- [2]
						0.9490196078431372, -- [3]
						1, -- [4]
					},
				},
				["Gloss"] = 0.3,
				["ID"] = "Darion",
			},
			["fadeoutdelay"] = 1,
			["padding"] = 1,
			["visibility"] = {
				["possess"] = false,
				["always"] = true,
				["stance"] = {
					false, -- [1]
				},
			},
			["version"] = 3,
		},
	}

	for k,v in pairs(StanceBarDefaults) do
		Bartender4DB.namespaces.StanceBar.profiles[k] = v
	end

	_G.PetBarDefaults = {
		[CharName] = {
			["rows"] = 2,
			["hidemacrotext"] = true,
			["fadeoutalpha"] = 0,
			["position"] = {
				["y"] = 295,
				["x"] = -195,
				["point"] = "BOTTOMRIGHT",
				["scale"] = 0.8999999761581421,
			},
			["version"] = 3,
			["visibility"] = {
				["always"] = false,
			},
			["skin"] = {
				["Colors"] = {
					["Normal"] = {
						0.1333333333333333, -- [1]
						0.1333333333333333, -- [2]
						0.1333333333333333, -- [3]
						0.9500000029802322, -- [4]
					},
					["Pushed"] = {
						0.3215686274509804, -- [1]
						0.3215686274509804, -- [2]
						0.3215686274509804, -- [3]
						1, -- [4]
					},
					["Highlight"] = {
						0.4509803921568628, -- [1]
						0.4509803921568628, -- [2]
						0.4509803921568628, -- [3]
						1, -- [4]
					},
					["Gloss"] = {
						1, -- [1]
						1, -- [2]
						1, -- [3]
						1, -- [4]
					},
					["Backdrop"] = {
						0.1098039215686275, -- [1]
						0.1098039215686275, -- [2]
						0.1098039215686275, -- [3]
						1, -- [4]
					},
					["Flash"] = {
						1, -- [1]
						0, -- [2]
						0, -- [3]
						1, -- [4]
					},
					["Border"] = {
						0.407843137254902, -- [1]
						0.403921568627451, -- [2]
						0.4117647058823529, -- [3]
						1, -- [4]
					},
					["Checked"] = {
						0.6, -- [1]
						0.6, -- [2]
						0.6, -- [3]
						1, -- [4]
					},
					["Disabled"] = {
						0.9882352941176471, -- [1]
						1, -- [2]
						0.9490196078431372, -- [3]
						1, -- [4]
					},
				},
				["ID"] = "Darion",
				["Gloss"] = 0.3,
			},
		},
	}

	for k,v in pairs(PetBarDefaults) do
		Bartender4DB.namespaces.PetBar.profiles[k] = v
	end

	_G.MicroMenuDefaults = {
		[CharName] = {
			["enabled"] = false,
			["version"] = 3,
			["show"] = "alwayshide",
			["skin"] = {
				["Colors"] = {
					["Normal"] = {
						0.1333333333333333, -- [1]
						0.1333333333333333, -- [2]
						0.1333333333333333, -- [3]
						1, -- [4]
					},
					["Border"] = {
						0.392156862745098, -- [1]
						0.3882352941176471, -- [2]
						0.396078431372549, -- [3]
						1, -- [4]
					},
				},
				["ID"] = "Caith",
				["Backdrop"] = false,
			},
			["position"] = {
				["y"] = -257.398563614586,
				["x"] = 21.58512786494109,
				["point"] = "LEFT",
				["scale"] = 0.800000011920929,
			},
		},
	}

	for k,v in pairs(MicroMenuDefaults) do
		Bartender4DB.namespaces.MicroMenu.profiles[k] = v
	end

	_G.BTProfilesDefaults = {
		[CharName] = {
			["minimapIcon"] = {
				["minimapPos"] = 268,
				["radius"] = 80,
				["hide"] = true,
			},
			["buttonlock"] = true,
		},
	}

	for k,v in pairs(BTProfilesDefaults) do
		Bartender4DB.profiles[k] = v
	end

	if Bartender4DB.profileKeys[ProfileName] == nil then
		tinsert(Bartender4DB.profileKeys,ProfileName)
		Bartender4DB.profileKeys[ProfileName] = CharName
	elseif Bartender4DB.profileKeys[ProfileName] ~= CharName then
		Bartender4DB.profileKeys[ProfileName] = CharName
	end

	if LUI.db.global.luiconfig[ProfileName].Versions then LUI.db.global.luiconfig[ProfileName].Versions.bartender = LUI.Versions.bartender end
end
