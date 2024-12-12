local _export = exports["game.player"]
game_player = setmetatable({}, {
    __index = function(self, index)
        self[index] = function(...)
            return _export[index](nil, ...)
        end
        return self[index]
    end
})