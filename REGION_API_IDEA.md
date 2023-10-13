

API Idea for Regions:


```lua

local region = Region(X,Y,W,H)



local left, right = region:splitHorizontal(0.4)
-- 40%, 60% split horizontal.
-- (where left, right are regions)

local left_top, left_bot = left:splitVertical(0.5)
-- 50%,50% split vertical
-- (left_top, left_bot are regions)


local right_regions[] = right:grid(rows, cols)
for _, r in ipairs(right_regions) do
    -- iterate over grid squares
end


local inner_region = region:pad(0.1)
-- creates an inner region with 10% padding around edges

local custom_region = region:pad(0.1, 0, 0.1 0)
-- same as above, but padding only on top and bottom.
-- (top, left, bottom, right) 



local bigger_region = region:expand(0.5)
-- creates an expanded region, by 50% in all directions


local r2 = region:offset(ox, oy)
-- offset a region. Useful for scrollbars and such








local x,y,w,h = region:get()



```


