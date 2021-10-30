local ServerCallbacks = {}

local function CallbackTimer(event, delay)
    if type(delay) == 'number' then
        local time = GetGameTimer()
        if (ServerCallbacks[event] or 0) > time then
            return false
        end
        ServerCallbacks[event] = time + delay
    end
end

local ServerCallback = table.create(0, 2)

--- Sends an event to the server and halts the current thread until a response is returned.
---@param event string
---@param delay number
ServerCallback.Await = function(resource, event, delay, ...)
    CallbackTimer(event, delay)
    event = ('__cb_%s:%s'):format(resource, event)
    TriggerServerEvent(event, ...)
    local promise = promise.new()
    event = RegisterNetEvent(event, function(...)
        promise:resolve(...)
        RemoveEventHandler(event)
    end)
    return Citizen.Await(promise.value)
end

--- Sends an event to the server and triggers a callback function once the response is returned.
---@param event string
---@param delay number
ServerCallback.Async = function(resource, event, delay, cb, ...)
    CallbackTimer(event, delay)
    event = ('__cb_%s:%s'):format(resource, event)
    print(event)
    TriggerServerEvent(event, ...)
    event = RegisterNetEvent(event, function(...)
        cb(...)
        RemoveEventHandler(event)
    end)
end

return ServerCallback