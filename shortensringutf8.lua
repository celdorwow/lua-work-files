local function ElvUI_ShortenString(str, numChars, dots)
	-- Credits to authors of ElvUI
	local bytes = #str
	if bytes <= numChars then
		return str
	else
		local len, pos = 0, 1
		while pos <= bytes do
			len = len + 1
			local c = str:byte(pos)
			if c > 0 and c <= 127 then
				pos = pos + 1
			elseif c >= 192 and c <= 223 then
				pos = pos + 2
			elseif c >= 224 and c <= 239 then
				pos = pos + 3
			elseif c >= 240 and c <= 247 then
				pos = pos + 4
			end
			if len == numChars then
				break
			end
		end

		if len == numChars and pos <= bytes then
			return str:sub(1, pos - 1)..(dots and '...' or '')
		else
			return str
		end
	end
end

local s = "СУКА БЛЯДЬ"

print(ElvUI_ShortenString(s, 6, true))
