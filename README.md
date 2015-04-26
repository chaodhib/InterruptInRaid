Simple interrupt annoncer for pve encounters compatible with 3.3.5. It's based on a similiar addon called Pare! Interrupt (http://www.curse.com/addons/wow/pare). This addon had no support for 3.3.5, only 4.0 and up. So I made a retrograded version myself. And in the process, I slightly changed the goal of the addon.

The addon aims at tracking any spell-interrupt made by a player against an NPC while in raid group. When such event does occur, the addon announces it on the raid channel.

The syntax used is the following:

A)Normal version: "Interruption OF XXX made on YYY with AAA BY ZZZ"

with: 

XXX = target cast name (link)

YYY = target name

ZZZ = source name

AAA = source interrupter spell name

B)Short version: "XXX interrupted by YYY

with: 
XXX = target cast name (link)

YYY = source name
