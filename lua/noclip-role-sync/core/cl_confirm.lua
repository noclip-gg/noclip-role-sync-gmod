
local colors = {}
colors.noclip = Color(1, 130, 254)
colors.text = Color(255, 255, 255)
net.Receive("noclip_sync_chatmsg_set", function()
    local name = net.ReadString()
    local clr = NoClip.Hex2Color(net.ReadString())

    chat.AddText(colors.text, "[", colors.noclip, "Noclip", colors.text, "] You have been given ", clr, name, colors.text, "!")
end )