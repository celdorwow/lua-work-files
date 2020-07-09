-- Polynomial
function poly(x, ...)
    -- convert input args to table
    local args = {...}
    -- read no of elements--unreliable if a table contains nil
    local n = #args

    -- Iterate over table and calculate polynomial
    local sum = 0
    for i = 1, n do
        local mul = 1
        for j = 1, n - i do
            mul = mul*x
        end
        sum = sum + args[i]*mul
    end

    -- return
    return sum
end

function concat(...)
    args = {...}
    s = ""
    for _, val in ipairs(args) do
        s = s .. val
    end
    return s
end
