------------------------------------------------------------------------
-- Non-global functions

-- this syntactic sugar is better then next one
-- it expands to:
-- local <name>; <name> = function () ... end
----
local function fact1(n)
    if n == 0 then return 1
    else return n*fact1(n - 1)
    end
end

-- This form has a subtle issue and is not going to work.
-- At execution, fact2 is still not defined at execution and a global
-- fact2 is going to be called as long as it exists. 
----
local fact2 = function(n)
    if n == 0 then return 1
    else return n*fact2(n-1) -- error
    end
end

-- This works but has the same form as fact1 while fact1 is more compact
----
    local fact3
fact3 = function (n)
    if n == 0 then return 1
    else return n*fact3(n-1)
    end
end

-- print(fact1(6))
-- -- print(fact2(6))   -- error 15: attempt to call a nil value (global 'fact2')
-- print(fact3(6))



------------------------------------------------------------------------
-- 
local function F(x)
    return {
        set = function (y) x = y end,
        get = function () return x end,
    }
end

-- local o1 = F(10)
-- local o2 = F(20)
-- print(o1.get(), o2.get())

-- o2.set(200)
-- o1.set(300)
-- print(o1.get(), o2.get())

------------------------------------------------------------------------
-- Polynomial
local function poly(...)
    local args = {...}
    return function (x)
        local sum = 0
        local n = #args
        for i = 1, n do
            local mul = 1
            for j = 1, n - i do
                mul = mul*x
            end
            sum = sum + args[i]*mul
        end
        return sum
    end
end

-- local sq1 = poly(2, 0, 3)
-- local sq2 = poly(3, -2, 7)
-- print(sq1(2))
-- print(sq2(4))

------------------------------------------------------------------------
-- Integral

-- local function linspace(a, b, n)
--     local x = {}
--     local d = (b - a)/(n - 1)
--     for i = 0, n-1 do
--         x[#x + 1] = a + i*n
--     end
--     return x, d
-- end

local function intf(f, n)
    local n = n or 100
    if math.fmod ~= 0 then
        n = n - math.fmod(n,2)
    end
    return function (a, b)
        local d = (b - a)/2
        local k = 0.0
        local x = a + d
        for i = 1, n + 1 do
            k = k + 4*f(x)
            x = x + 2*d
        end
        x = x + 2*d
        for i = 1, n/2 do
            k = k + 4*f(x)
            x = x + 2*d
        end
        return (d/3)*(f(a) + f(b) + k)
    end
end

local g = intf(math.sin, 10)
print(g(0, 2*math.pi))
