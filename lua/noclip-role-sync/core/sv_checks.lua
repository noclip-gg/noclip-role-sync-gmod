
util.AddNetworkString("noclip_sync_chatmsg_set")
function NoClip.TellUpdated(pl, rank)
    net.Start("noclip_sync_chatmsg_set")
    net.WriteString(rank.name)
    net.WriteString(rank.color)
    net.Send(pl)
end

function NoClip.WebToServerHandler(pl, data, rank)
    if NoClip.HasRank(data.roles, rank) then return end


    NoClip.AssignRank(pl, rank, function(webuser, webrank)
        NoClip.Log("Updated group of web user '" .. webuser.name .. " (" .. pl:Nick() .. ") to " .. webrank.name)
    end, print)

end

function NoClip.CheckPlayer(pl)
    if not IsValid(pl) then return end

    if not NoClip.IsWebToServer() then
        local ug = pl:GetUserGroup()

        if NoClip.RoleSync.Config.Usergroups[ug] then
            NoClip.GetPlayer(pl, function(ply)
                NoClip.WebToServerHandler(pl, ply, NoClip.RoleSync.Config.Usergroups[ug])
            end, print)
        end

        return
    end

    NoClip.GetPlayerRanks(pl, function(ranks)
        table.SortByMember(ranks, "level")

        local set
        for k,v in ipairs(ranks) do
            local x = NoClip.RoleSync.Config.Roles[v.id]

            if x then
                set = true
                if pl:GetUserGroup() == x then break end

                pl:SetUserGroup(x)
                NoClip.TellUpdated(pl, v)

                NoClip.Log("Updated group of player " .. pl:Nick() .. " to ", x)
                break
            end
        end

        if NoClip.RoleSync.Config.RevertTo and (not set) then
            pl:SetUserGroup(NoClip.RoleSync.Config.RevertTo)
            NoClip.Log("Reset group of player " .. pl:Nick() .. " to " .. NoClip.RoleSync.Config.RevertTo)
        end
    end, err)
end