
--[[
    UI tools
]]

local ui = {}
rawset(_G, "ui", ui)

local lookupError = {
    __index = function(t,k)
        error("Unknown key: " .. tostring(k))
    end
}


setmetatable(ui, lookupError)





ui.elems = {}

local loadTree = require("load_tree")

loadTree("ui/elems", ui.elems)




return ui
