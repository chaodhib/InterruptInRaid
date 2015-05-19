-- InterruptInRaid 30300-1.0
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
if (IIR_isActive == nil) then IIR_isActive = true; end
if (IIR_shortOutput == nil) then IIR_shortOutput = false; end
-----------------------------------------------------------------------------------

local InterruptInRaid = CreateFrame('Frame')

local function UnitIsPlayerByGUID(GUID)
	local typeFlag=tonumber(GUID:sub(5,5), 16) % 8;
	return (typeFlag==0) -- 0=player, 1=world object, 3=NPC, 4 permanent pet, 5 vehicule. 
end

local function OnEvent(self, event, ...)

	if not IIR_isActive then return end -- check if the addon is active
	if GetNumRaidMembers()==0 then return end -- check if we are in a raid group
	if select(2,...) ~= "SPELL_INTERRUPT"  then return end -- we only care about spell interrupt events
	
	local sourceGUID=select(3,...)
	if not UnitIsPlayerByGUID(sourceGUID) then return end -- check if the source of the interupt is indeed a player
	local targetGUID=select(6,...)
	if UnitIsPlayerByGUID(targetGUID) then return end -- check if the target of the interupt is indeed NOT a player

	local targetSpellID=select(12,...);
	local targetName=select(7,...);
	local sourceSpellID=select(9,...);
	local sourceName=select(4,...);

	if not IIR_shortOutput then
		SendChatMessage("Interruption OF "..GetSpellLink(targetSpellID).." made ON "..targetName.." WITH "..GetSpellLink(sourceSpellID) .." BY "..sourceName, "RAID")
	else
		SendChatMessage(GetSpellLink(targetSpellID) .." interrupted by " ..sourceName, "RAID")
	end

end

-- Slash Commands
SLASH_InterruptInRaid1 = '/iir'; 
function SlashCmdList.InterruptInRaid(msg, editbox)
	if (msg == "on") then IIR_isActive = true; print("InterruptInraid is now: Active"); return end
	if (msg == "off") then IIR_isActive = false; print("InterruptInraid is now: Inactive"); return end
	if (msg == "short") then IIR_shortOutput = true; print("The output is now set on: Short"); return end
	if (msg == "normal") then IIR_shortOutput = false; print("The output is now set on: Normal"); return end

 print("----------------------------------------------------------");
 print("InterruptInRaid commands");
 print("----------------------------------------------------------");
 print("/iir on - activate the addon");
 print("/iir off- desactivate the addon");
 print("/iir short - use the short output");
 print("/iir normal- use the normal output");
 print("----------------------------------------------------------");
  if (IIR_isActive == true) then print("InterruptInRaid is currently: Active"); end 
  if (IIR_isActive == false) then print("InterruptInRaid is currently: Inactive"); end
  if (IIR_shortOutput == true) then print("and the output is set on: Short"); end
  if (IIR_shortOutput == false) then print("and the output is set on: Normal"); end
 print("----------------------------------------------------------");
end

InterruptInRaid:SetScript('OnEvent', OnEvent)
InterruptInRaid:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED')