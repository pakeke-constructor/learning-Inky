
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


ui.ratios = require("ui.ratios")
setmetatable(ui.ratios, lookupError)


local function assertRatio(ratio)
    assert(ratio.x and ratio.y and ratio.w and ratio.h, "invalid ratio obj")
end


local function clamp(v, lo, hi)
	return math.max(lo, math.min(v, hi))
end


function ui.getView(ratio, X,Y,W,H)
    --[[
        takes a ratio object, and returns appropriate x,y,w,h 

        ratioObj: {
            x 
        }
    ]]
    local x,y,w,h
    assertRatio(ratio)

    w = ratio.w * W
    h = ratio.h * H

	x = X + x*W - w/2
	y = Y + y*H - h/2
    
    w = clamp(w, ratio.minWidth or w, ratio.maxWidth or w)
    h = clamp(h, ratio.minHeight or h, ratio.maxHeight or h)
	return x,y,w,h
end



ui.elems = {}

local loadTree = require("load_tree")

loadTree("ui/elems", ui.elems)




return ui
