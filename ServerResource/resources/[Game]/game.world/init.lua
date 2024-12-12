local _export = exports["game.world"]
game_world = setmetatable({}, {
    __index = function(self, index)
        self[index] = function(...)
            return _export[index](...)
        end
        return self[index]
    end
})