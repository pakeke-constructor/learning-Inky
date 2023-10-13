
--[[
    UI tools
]]

local ui = {}
rawset(_G, "ui", ui)



function ui.renderScreenRatio(ratioObj, X,Y,W,H)
    local x,y,w,h
	local W,H = love.graphics.getDimensions()

    w = ratio.w * W
    h = ratio.h * H

	x = x*W - w/2
	y = y*H - h/2
	
	element:render(x,y,w,h)
end


function ui.getRatio(ratio, X,Y,W,H)
    local x,y,w,h

    w = ratio.w * W
    h = ratio.h * H

	x = X + x*W - w/2
	y = Y + y*H - h/2
	return x,y,w,h
end


function ui.renderRatio(parent, child, ratio)
    local x,y,w,h
    local X,Y,W,H = parent:getView()

    w = ratio.w * W
    h = ratio.h * H

	x = x*W - w/2
	y = y*H - h/2
	
	child:render(x,y,w,h)
end


ui.elems = {}

local loadTree = require("load_tree")

loadTree("ui/elems", ui.elems)




return ui
