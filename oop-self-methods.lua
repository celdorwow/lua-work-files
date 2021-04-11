local t = {
  field1 = "Field 1",
  field2 = 10,
  method1 = function (self, msg)
    print("    In method11. Message: " .. msg)
  end,
  method2 = function (self)
    print("    In method2. Fields: "..self.field1..", "..tostring(self.field2))
  end,
  method3 = function (self)
    print(self)
    self:method1("My message")
    self:method2()
  end,
}

local u = {
  command1 = t.method1,
  command2 = t.method2,
  command3 = t.method3,
}

print(t)

u.command1(t, "Aaaa")
u.command2(t)
u.command3(t)
