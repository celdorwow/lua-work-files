print()

local x1, x2 = 1, 10

do -- first level of do-end
    print("Global x1:", x1)

    local x1 = 101
    print("Local x1:", x1)

    local x2 = 110
    do -- second level of do-end
        local x2 = 1110
        print("local of local x2:", x2)
    end
    print("local x2:", x2)

end

print("Again global x1:", x1)
print("Again global x2:", x2)

print()