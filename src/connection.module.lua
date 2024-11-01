local RBXScriptConnection = {};
RBXScriptConnection.__index = RBXScriptConnection;

type self = {
    _connection: ((...any) -> any)?;
    _name: string;
}

function RBXScriptConnection.new(name: string)
    return setmetatable({
        _connection = nil;
        _name = name;
    }, RBXScriptConnection);
end

function RBXScriptConnection.Connect(self: self, func: (...any) -> any): nil
    if (self._connection) then
        error("RBXScriptConnection \"" .. self._name .. "\" already connected");
        return nil;
    end

    self._connection = func;
    return nil;
end

function RBXScriptConnection.Fire(self: self, ...): any
    if (not self._connection) then
        error("RBXScriptConnection \"" .. self._name .. "\" is not connected");
        return nil;
    end

    return self._connection(...);
end

return RBXScriptConnection