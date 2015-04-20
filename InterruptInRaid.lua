-- InterruptInRaid 30300-0.1
-- chaodhib@gmail.com

---------------------------------------------------------------------------------
-- Initializing locale
---------------------------------------------------------------------------------
local function defaultFunc(L, key)
 return key;
end
MyLocalizationTable = setmetatable({}, {__index=defaultFunc});

local L = MyLocalizationTable;

-----------------------------------------------------------------------------------
-- Initializing variables
-----------------------------------------------------------------------------------
if (isActive == nil) then isActive = true; end
if (shortOutput == nil) then shortOutput = false; end
-----------------------------------------------------------------------------------

local InterruptInRaid = CreateFrame('Frame')

local function OnEvent(self, event, ...)

	if not isActive then return end -- check if addon active
	if GetNumRaidMembers()==0 then return end -- check if the player is in a raid group
	if select(2,...) ~= "SPELL_INTERRUPT" then return end -- we only care about spell interrupt events
	--if select(4,...) ~= UnitName("player") then return end

	local targetSpellID=select(12,...);
	local targetName=select(7,...);
	local sourceSpellID=select(9,...);
	local sourceName=select(4,...);

	if not shortOutput then
		SendChatMessage("Interruption OF "..GetSpellLink(targetSpellID).." made ON "..targetName.." WITH "..GetSpellLink(sourceSpellID) .." BY "..sourceName, "RAID")
	else
		SendChatMessage("Interruption OF "..GetSpellLink(targetSpellID) .." BY "..sourceName, "RAID")
	end
end

-- Slash Commands
SLASH_InterruptInRaid1 = '/iir'; 
function SlashCmdList.InterruptInRaid(msg, editbox)
	if (msg == "on") then isActive = true; print("InterruptInraid is now: Active"); return end
	if (msg == "off") then isActive = false; print("InterruptInraid is now: Inactive"); return end
	if (msg == "short") then shortOutput = true; print("The output is now set on: Short"); return end
	if (msg == "normal") then shortOutput = false; print("The output is now set on: Normal"); return end

 print("----------------------------------------------------------");
 print("InterruptInRaid commands");
 print("----------------------------------------------------------");
 print("/iir on - activate the addon");
 print("/iir off- desactivate the addon");
 print("/iir short - use the short output");
 print("/iir normal- use the normal output");
 print("----------------------------------------------------------");
  if (isActive == true) then print("InterruptInRaid is currently: Active"); end 
  if (isActive == false) then print("InterruptInRaid is currently: Inactive"); end
  if (shortOutput == true) then print("and the output is set on: Short"); end
  if (shortOutput == false) then print("and the output is set on: Normal"); end
 print("----------------------------------------------------------");
end

InterruptInRaid:SetScript('OnEvent', OnEvent)
InterruptInRaid:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED')