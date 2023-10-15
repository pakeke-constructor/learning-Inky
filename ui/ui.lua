
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


local elements = {--[[
    [elemName] -> ElementFactory
]]}
ui.elements = elements



function ui.defineElement(elemName, setupFunc)
    --[[
    USAGE:

    return ui.defineElement("ElementName", function(self, args)
        for k,v in pairs(args) do
            print("arg passed in: ", k, v)
        end

        return function(region)
            -- `region` is a kirigami region
            ...
        end
    end)
    ]]
    assert(not elements[elemName], "overwriting element")

    local Element = Inky.defineElement(function(elem)
        return function(_, x,y,w,h)
            local region = kirigami.Region(x,y,w,h)
            elem.props.renderFunction(region)
        end
    end)

    local function ctor(scene, ...)
        local elem = Element(scene)
        elem.props.renderFunction = setupFunc(elem, ...)
        assert(type(elem.props.renderFunction) == "function", "need to return function")
        return elem
    end

    elements[elemName] = ctor
    return ctor
end



local loadTree = require("load_tree")
loadTree("ui/elems")




return ui
