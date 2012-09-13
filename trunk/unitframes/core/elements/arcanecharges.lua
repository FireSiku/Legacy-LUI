if(select(2, UnitClass('player')) ~= 'WARLOCK') then return end

local parent, ns = ...
local oUF = ns.oUF

local SPELL_POWER_MANA = SPELL_POWER_MANA 

local Update = function(self, event, unit, powerType)
	if(self.unit ~= unit or (powerType and powerType ~= 'MANA')) then return end
	
	local ac = self.ArcaneCharges
	if(ac.PreUpdate) then ac:PreUpdate(unit) end

	local _, _, _, num = UnitDebuff(unit, GetSpellInfo(36032)) -- Arcane Charge
	for i = 1, 6 do
		if(i <= num) then
			ac[i]:SetAlpha(1)
		else
			ac[i]:SetAlpha(0)
		end
	end

	if(ac.PostUpdate) then
		return ac:PostUpdate(unit)
	end
end

local Path = function(self, ...)
	return (self.ArcaneCharges.Override or Update) (self, ...)
end

local ForceUpdate = function(element)
	return Path(element.__owner, 'ForceUpdate', element.__owner.unit, 'MANA')
end

local function Enable(self)
	local ac = self.ArcaneCharges
	if(ac) then
		ac.__owner = self
		ac.ForceUpdate = ForceUpdate

		self:RegisterEvent('UNIT_POWER', Path)

		return true
	end
end

local function Disable(self)
	local ac = self.ArcaneCharges
	if(ac) then
		self:UnregisterEvent('UNIT_POWER', Path)
	end
end

oUF:AddElement('ArcaneCharges', Path, Enable, Disable)
