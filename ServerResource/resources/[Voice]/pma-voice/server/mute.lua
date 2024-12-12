local mutedPlayers = {}

RegisterCommand('muteply', function(source, args)
	local mutePly = args[0]
	local duration = args[1] or 900
	if mutePly and exports[GetCurrentResourceName()]:isValidPlayer(mutePly) then
		local isMuted = not MumbleIsPlayerMuted(mutePly)
		Player(mutePly).state.muted = isMuted
		MumbleSetPlayerMuted(mutePly, isMuted)
		TriggerEvent('pma-voice:playerMuted', mutePly, source, isMuted, duration)
		if mutedPlayers[mutePly] then
			mutedPlayers[mutePly] = nil
			MumbleSetPlayerMuted(mutePly, isMuted)
			Player(mutePly).state.muted = isMuted
			return
		end
		mutedPlayers[mutePly] = 1
		SetTimeout(duration * 1000, function()
			if not mutedPlayers[mutePly] then return end
			MumbleSetPlayerMuted(mutePly, not isMuted)
			Player(mutePly).state.muted = not isMuted
			mutedPlayers[mutePly] = nil
		end)
	end
end)