local Parser = require("Parser")

-----------------------------------------------------------------------------
--- Is Empty Table
-----------------------------------------------------------------------------
local function isempty(t)
  if type(t) ~= "table" then return end
  return not next(t)
end


-----------------------------------------------------------------------------
--- MAIN AND TEST OF FRAMEWORK
-----------------------------------------------------------------------------

--- Inputs
local str = "  par1 arg11 arg12 arg13      par4     par2 arg21 arg22      par1 arg211 arg212 arg213     par3 arg31     "
local p_obj = Parser:New(str)


--- Test valid arguments
print("Test valid arguments")
for _, e in ipairs({{"par4"}, {"par3", 1}, {"par1", 3}, {"par2", 2},}) do
  local t = p_obj:ParseInput(e[1], e[2]);
  for _, o in ipairs(t) do
    if next(o) then
      print(table.concat(o, "\t"))
    end
  end
end
print()

--- Test invalid arguments
print("Test invalid arguments")
for _, e in ipairs({{"par", 1}}) do
  local t = p_obj:ParseInput(e[1], e[2]);
  if not isempty(t) then
    for _, o in ipairs(t) do
      if next(o) then
        print(table.concat(o, "\t"))
      end
    end
  else
    print("No parameter: '"..e[1].."'!")
  end
end
print()

--- Test all arguments
print("Test expected arguments")
local outputs = p_obj:ParseAllInputs({{"par3", 1}, {"par4"}, {"par2", 2}, {"par1", 3}})
for _,v in ipairs(outputs) do
  if next(v) then
    print(table.concat(v, "\t"))
  else
    print("No parameter '"..v.."'")
  end
end
