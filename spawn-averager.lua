
-- Part to instantiate
local spawnPoint = Instance.new("Part")


-- Center point for the part
local x0 = spawnPoint.Size.X/2
local z0 = spawnPoint.Size.Z/2

-- Given the width of the part and how wide each player is, determines how many players can fit on the width axis
local maxPlayersPerX = math.floor(spawnPoint.Size.X / vars.spawnLengthDist.Value)

-- axis iterators
local cycler = 0
local zCycle = 0

-- iterates through an array of players
for i,player in ipairs(players) do
	local slicedx
	local slicedz
	local offset  = 0
	local zoffset = 0
	
	cycler = cycler + 1
	

    -- if # of players is greater than the max width on one axis, then start calculation for Z axis. otherwise just do X axis
	if #players > maxPlayersPerX then
		if cycler > maxPlayersPerX then
			cycler = 1
			zCycle = zCycle + 1
		end
		

        -- averaging math
		determinedZs = math.ceil(#players/maxPlayersPerX)
		
		zoffset = ((spawnPoint.Size.Z - (vars.spawnWidthDist.Value*determinedZs))/2)
		
        -- check if the number of players on this axis is less than the max
		if (#players - maxPlayersPerX) < (maxPlayersPerX * zCycle) then
			local remnant = #players % maxPlayersPerX
			offset = ((spawnPoint.Size.X - (vars.spawnLengthDist.Value*remnant))/2)	
		else
			offset = ((spawnPoint.Size.X - (vars.spawnLengthDist.Value*maxPlayersPerX))/2)
		end 
		
		slicedx = -x0 + offset + (vars.spawnLengthDist.Value * (cycler-1)) + (vars.spawnLengthDist.Value/2)
		slicedz = z0 - zoffset - (vars.spawnWidthDist.Value * (zCycle-1)) - (vars.spawnWidthDist.Value/2)
	else
		offset = ((spawnPoint.Size.X - (vars.spawnLengthDist.Value*#players))/2)
		slicedx = -x0 + offset + (vars.spawnLengthDist.Value * (cycler-1)) + (vars.spawnLengthDist.Value/2)
		slicedz = 0
	end

    -- spawn player
	player.character.HumanoidRootPart.CFrame = spawnPoint.CFrame * CFrame.new(Vector3.new(slicedx,vars.distAboveSpawn.Value,slicedz)) * CFrame.Angles(0,0,0)

end