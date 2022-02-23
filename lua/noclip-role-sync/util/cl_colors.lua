
local function n(str) return tonumber("0x" .. str) end
function NoClip.Hex2Color(hex)
    hex = hex:gsub("%#", "")

    return Color(
        n(hex:sub(1, 2)),
        n(hex:sub(3, 4)),
        n(hex:sub(5, 6))
    )
end