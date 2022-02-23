
local colors = {}
colors.noclip = Color(1, 130, 254)
colors.text = Color(255, 255, 255)

function NoClip.Log(...)
    MsgC(colors.text, "[", colors.noclip, "Noclip", colors.text, "] ", ..., "\n")
end