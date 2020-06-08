local function pnpoly(area, test)
    local inside = false
    local tx, ty = table.unpack(test)
    local j = #area
    for i=1, #area do
        local vxi, vyi = table.unpack(area[i])
        local vxj, vyj = table.unpack(area[j])
        if (vyi > ty) ~= (vyj > ty)
        and tx < (vxj - vxi)*(ty - vyi)/(vyj - vyi) + vxi
        then
            inside = not inside
        end
        j = i
    end
    return inside
end

local A = {{2, 1}, {1, 2}, {15, 3}, {3, 4}, {5, 3}, {4, 1.5}}
local T = {2, 1.1}

print(pnpoly(A, T))

-- SecondsToClock(seconds, showHours)
