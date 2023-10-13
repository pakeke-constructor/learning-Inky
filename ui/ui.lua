
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
            x, y: x, y position ratio (1/2 = center)
            w, h: width/height. (1=100% size)
            minWidth, maxWidth:  min/max width in pixels
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


function ui.splitHorizontal(ratioX, X,Y,W,H)
    --[[
        splits a view horizontally
        For example, ratioY = 0.1 will yield a small region on the left,
        taking up around 10% of the region.

        returns two tuples representing the two split panes
    ]]
    local x,w = X, ratioX*W
    local x1,w1 = X+w, W-w

    return x,w,Y,H, x1,w1,Y,H
end



function ui.splitVertical(ratioY, X,Y,W,H)
    --[[
        splits a view vertically, according to ratioY.
        For example, ratioY = 0.1 will yield a navbar-like setup.

        returns two tuples representing the two split panes.
    ]]
    local y,h = Y, ratioY*H
    local y1,h1 = Y+h, Y-h

    return X,y,W,h, X,y1,W,h1
end



ui.elems = {}

local loadTree = require("load_tree")

loadTree("ui/elems", ui.elems)




return ui
