local Account = {
    balance = 0,
    withdraw = function(self, v)
        self.balance = self.balance - v
    end,
    deposit = function(self, v)
        self.balance = self.balance + v
    end,
    new = function(self, o)
        o = o or {}
        self.__index = self
        self.__tostring = function(o)
            return "{balance = " .. o.balance .. "}"
        end
        setmetatable(o, self)
        return o
    end,
}

local a = Account:new()
a:deposit(50)

local b = Account:new()
b:deposit(100)

local c = Account:new()
c:deposit(150)

print(a)
print(b)
print(c)
