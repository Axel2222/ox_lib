if not lib.player then lib.player() end

return function(resource)
	local Framework = exports[resource]:GetCoreObject()
	local PlayerData

	RegisterNetEvent('Framework:Client:OnPlayerLoaded', function()
		PlayerData = Framework.Functions.GetPlayerData()
	end)

	RegisterNetEvent('Framework:Client:OnJobUpdate', function(job)
		PlayerData.job = job
	end)

	RegisterNetEvent('Framework:Client:OnGangUpdate', function(gang)
		PlayerData.gang = gang
	end)

	local CPlayer = lib.getPlayer()

	function lib.getPlayer()
		return setmetatable({
			id = cache.playerId,
			serverId = cache.serverId,
		}, CPlayer)
	end

	local groups = { 'job', 'gang' }

	function CPlayer:hasGroup(filter)
		local type = type(filter)

		if type == 'string' then
			for i = 1, #groups do
				local data = PlayerData[groups[i]]

				if data.name == filter then
					return data.name, data.grade.level
				end
			end
		else
			local tabletype = table.type(filter)

			if tabletype == 'hash' then
				for i = 1, #groups do
					local data = PlayerData[groups[i]]
					local grade = filter[data.name]

					if grade and grade <= data.grade.level then
						return data.name, data.grade.level
					end
				end
			elseif tabletype == 'array' then
				for i = 1, #filter do
					local group = filter[i]

					for j = 1, #groups do
						local data = PlayerData[groups[j]]

						if data.name == group then
							return data.name, data.grade.level
						end
					end
				end
			end
		end
	end

	player = lib.getPlayer()

	return Framework
end
