

local Region = {}
local Region_mt = {__index = Region}



local function newRegion(x,y,w,h)
    return setmetatable({
        x = x,
        y = y,
        w = w,
        h = h
    }, Region_mt)
end



local unpack = unpack or table.unpack
-- other lua version compat ^^^


local function average(a, b)
    return (a+b)/2
end


local function getRatios(...)
    -- gets ratios from a vararg-list of numbers
    local ratios = {}
    local sum = 0
    local len = select("#", ...)
    if len <= 0 then error("No numbers passed in!") end
	for i=1, len do
        -- collect ratios
		local v = select(i, ...)
        assert(type(v) == "number", "Arguments need to be numbers")
        sum = sum + v
        table.insert(ratios, v)
	end

    for i=1, len do
        -- normalize region ratios:
        ratios[i] = ratios[i] / sum
    end
    return ratios
end

function Region:splitVertical(...)
    --[[
        splits a region vertically.
        For example:  

        region:splitVertical(0.1, 0.9)

        This code ^^^ splits a region into two horizontally-lying
        rectangles; one at the top, taking up 10%, and one at bottom taking 90%.
    ]]
    local regions = getRatios(...)
    local accumY = self.y
    for i=1, #regions - 1 do
        local ratio = regions[i]
        local y, h = accumY, self.h*ratio
        regions[i] = newRegion(self.x, y, self.w, h)
        accumY = accumY + h
    end
    return unpack(regions)
end


function Region:splitHorizontal(...)
    --[[
        Same as vertical, but in other direction
    ]]
    local regions = getRatios(...)
    -- 0.1  0.8  0.1
    -- |.|........|.|
    local accumX = self.x
    for i=1, #regions - 1 do
        local ratio = regions[i]
        local x, w = accumX, self.w*ratio
        regions[i] = newRegion(x, self.y, w, self.h)
        accumX = accumX + w
    end
    return unpack(regions)
end




function Region:grid(rows, cols)
    local w, h = self.w/rows, self.h/cols
    local regions = {}

    for ix=0, rows-1 do
        for iy=0, cols-1 do
            local x = self.x + w*ix
            local y = self.y + h*iy
            local r = newRegion(x,y,w,h)
            table.insert(regions, r)
        end
    end

    return regions
end




-- FUTURE GOAL: Allow for custom regions.
-- local custom_region = region:pad(0.1, 0, 0.1 0)
-- same as above, but padding only on top and bottom.
-- (top, left, bottom, right) 

function Region:padRatio(ratio)
    --[[
        creates an inner region with percentage of padding,
        according to the width/height.
        If width-height is different, we
        pad by the AVERAGE of the width-height values
    ]]
    local v = ratio * average(self.w, self.h)
    return self:pad(v)
end


function Region:pad(v)
    --[[
        creates an inner region with `v` units of padding
    ]]
    local v2 = v*2
    return newRegion(
        self.x + v,
        self.y + v,
        self.w - v2,
        self.h - v2
    )
end






return newRegion
