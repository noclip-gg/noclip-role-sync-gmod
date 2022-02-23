
local tocheck = {}

local del = 0
hook.Add("Think", "NoClip:RoleSync:RedoRequests", function()
    if CurTime() < del then return end
    del = CurTime() + NoClip.RoleSync.Config.ReCheck

    NoClip.Log("Rechecking Users (" .. ((NoClip.IsWebToServer() and "web->server") or "server->web") .. ")")
    NoClip.ClearCaches()

    for k,v in pairs(player.GetAll()) do
        NoClip.CheckPlayer(v)
    end
end )

local pairs = pairs
local IsValid = IsValid
hook.Add("Think", "NoClip:RoleSync:CheckIsvalid", function()
    for k,v in pairs(tocheck) do
        local pl = player.GetBySteamID(v)

        if IsValid(pl) then
            NoClip.CheckPlayer(pl)
            tocheck[k] = nil
        end
    end
end )

gameevent.Listen("player_connect")
hook.Add("player_connect", "NoClip:RoleSync:Check", function(dat)
    if dat.bot then return end
    tocheck[dat.userid .. dat.address] = dat.networkid
end )

function NoClip.DebugReFullfill()
    del = 0
end