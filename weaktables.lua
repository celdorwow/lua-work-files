local RareNPC = {
    __idex = false,
    __gc = false,
    getname = function (self)
        return self.name
    end,
    getlevel = function (self)
        return self.level
    end,
    delay = function (self)
        return self.delay
    end,
    new = function (self, name, level, delay)
        local o = {
            delay = delay or 60,
            name = name,
            level = level,
        }
        setmetatable(o, self)
        return o
    end,
}
RareNPC.__index = RareNPC
RareNPC.__gc = function (self) print("Getting rid of " .. self.name) end


--- Test of weak values
print("Weak values:")
local t_wv = setmetatable({}, {__mode="v"})
local val
val = RareNPC:new("Monster", 120)
t_wv.monster = val
assert(val == t_wv.monster, "Objects addresses are not the same")
val = nil
collectgarbage()
for k,v in pairs(t_wv) do print(k, v) end
--
-- The loop "for" should not output anything from t_wv as val is nil and reference to value is weak
-- __gc should print "Getting rid of Monster"

print()
print("Weak keys:")
-- Test of weak keys
local key
local t_wk = setmetatable({}, {__mode="k"})
key = RareNPC:new("Animal", 120)
t_wk[key] = "Animal"
key = RareNPC:new("Demon", 110)
t_wk[key] = "Demon"
collectgarbage()
-- The second collectgarbage() is required if something's refering to an object being removed, such as __gc.
-- Here, __gc "ressurects" "Animal" in order to refer to its name attribute and then marked it for collection.
-- In the next cycle (second call of collectgarbage here), they it be removed, as well.
collectgarbage()
for k, v in pairs(t_wk) do print(k, v) end
--
-- The loop "for" should output only one items in t_wk "Demon".
-- __gc should print "Getting rid of Animal"
