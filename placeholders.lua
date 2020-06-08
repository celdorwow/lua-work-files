local name = "Zbigniew"
local x, y = 50.1, 32.8
local level = "122+"
local health = "75"

local msg = "(Rare) %n (%l) %h% at %c"

msg = msg:gsub("%%n", name):gsub("%%l", level):gsub("%%h", health)
msg = msg:gsub("%%c", ("%.1f %.1f"):format(x, y))

print(msg)
