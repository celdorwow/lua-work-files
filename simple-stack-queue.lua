local stack = {
    -- add element on top
    push = function (self, arg)
        self[#self + 1] = arg
    end,
    -- Take first element from top
    pop = function (self)
        if #self == 0 then return end
        local n = #self
        local val = self[n]
        self[n] = nil
        return val
    end,
}

local queue = {
    -- add element on top
    push = function (self, arg)
        table.insert(self, 1, arg)
    end,
    -- Take first element from top
    pop = function (self)
        local n = #self
        if n == 0 then return end
        local val = self[n]
        self[n] = nil
        return val
    end,
}

-- Stack
print("Stack:")
stack:push(10)
stack:push("aaa")
for v in stack.pop, stack do print(v) end

-- Queue
print("Queue:")
queue:push(10)
queue:push("aaa")
for v in queue.pop, queue do print(v) end

repeat
    -- body...
until true
