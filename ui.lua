
--[[
    UI tools
]]

local ui = {}


function ui.renderScreenRatio(element, ratio)
    local x,y,w,h
	local W,H = love.graphics.getDimensions()

    w = ratio.w * W
    h = ratio.h * H

	x = x*W - w/2
	y = y*H - h/2
	
	element:render(x,y,w,h)
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



return ui
