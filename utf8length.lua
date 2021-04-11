local utf8len = function (str)
	if not str then return 0 end
	local length, pos = 0, 1
	while str:sub(pos) ~= "" do
		local byte = str:byte(pos)
		if byte > 0 and byte < 128 then
			pos = pos + 1
		elseif byte >= 192 and byte < 224 then
			pos = pos + 2
		elseif byte >= 224 and byte < 240 then
			pos = pos + 3
		elseif byte >= 240 and byte < 248 then
			pos = pos + 4
		end
		length = length + 1
	end
	return length
end

local WA_Utf8Sub = function(input, size)
	if size >= utf8len(input) then
		return input
	end
	local output = ""
	local i = 1
	while (size > 0) do
		local byte = input:byte(i)
		if not byte then
			return output
		end
		if byte < 128 then
			-- ASCII byte
			output = output .. input:sub(i, i)
			size = size - 1
		elseif byte < 192 then
			-- Continuation bytes
			output = output .. input:sub(i, i)
		elseif byte < 244 then
			-- Start bytes
			output = output .. input:sub(i, i)
			size = size - 1
		end
		i = i + 1
	end

	-- Add any bytes that are part of the sequence
	while (true) do
		local byte = input:byte(i)
		if byte >= 128 and byte < 192 then
			output = output .. input:sub(i, i)
		else
			break
		end
		i = i + 1
	end

	return output
end

local allstrings = {
	{
		"",
	},
	{
		"Cathedral Square", "Dwarven District", "Old Town", "Trade District", "Mage Quarter", "Valley of Strength",
		"Valley of Spirits", "Valley of Wisdom", "The Drag", "Valley of Honor",
	},
	{
		"Соборная площадь", "Квартал дворфов", "Старый город", "Торговый квартал", "Квартал Магов", "Аллея Силы",
		"Аллея Духов", "Аллея Мудрости", "Волок", "Аллея Чести",
	},
	{
		"大教堂廣場", "矮人區", "舊城區", "貿易區", "法師區", "力量谷", "精神谷", "智慧谷", "暗巷區", "榮譽谷",
	},
}

for _, str in ipairs(allstrings) do
	for _, s in ipairs(str) do
		print(s, utf8len(s))
	end
end
