local function convert_to_time(secs, dropsecs)
    local hh = (secs // 3600) % 24
    local mm = (secs // 60) % 60
    local ss = secs % 60

    local frmt = "%02d:%02d"
    local sformat
    if mm > 0 then
        sformat = function (f)
            return string.format(f, hh, mm, ss)
        end
        if not dropsecs then frmt = frmt .. ":%02d" end
    elseif mm == 0 then
        sformat = function (f)
            return string.format(f, mm, ss)
        end
    else
        sformat = function (f)
            return string.format(f, mm, ss)
        end
    end
    return sformat(frmt)
end

print(convert_to_time(3700, false))
print(convert_to_time(3700, true))

print(convert_to_time(1800, false))
print(convert_to_time(1800, true))
