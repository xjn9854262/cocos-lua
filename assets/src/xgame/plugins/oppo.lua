local class         = require "xgame.class"
local util          = require "xgame.util"
local PluginEvent   = require "xgame.plugins.PluginEvent"
local cjson         = require "kernel.cjson.safe"

local trace = util.trace("[oppo]")
local impl

local Oppo = class("Oppo", require("xgame.EventDispatcher"))

function Oppo:ctor()
    impl:setDispatcher(function (...)
        self:_didResponse(...)
    end)
end

function Oppo:_didResponse(action, message)
    trace("response: %s %s", action, message)
    local response = cjson.decode(message)
    if action == 'pay' then
        if response.status == 0 then
            self:dispatch(PluginEvent.PAY_SUCCESS)
        elseif response.status == 1 then
            self:dispatch(PluginEvent.PAY_CANCEL)
        else
            self:dispatch(PluginEvent.PAY_FAILURE)
        end
    end
end

function Oppo:pay(order)
    impl:pay(
        assert(order.orderno),
        assert(order.attach),
        assert(order.price),
        assert(order.name),
        assert(order.desc),
        assert(order.url)
    )
end

if xGame.os == "android" then
    local luaj = require "xgame.luaj"
    local inst = luaj.new("kernel/plugins/oppo/Oppo")
    impl = {}

    function impl:setDispatcher(callback)
        impl.callback = callback
    end

    function impl:pay(orderno, attach, price, name, desc, url)
        inst.pay(orderno, attach, price, name, desc, url, function (...)
            impl.callback("pay", ...)
        end)
    end
else
    impl = setmetatable({}, {__index = function (_, func)
        return function ()
            trace("function 'kernel.plugins.oppo.%s' not supported", func)
        end
    end})
end

return Oppo.new()