
function NoClip.ValidJSON(str, cb, err)
    local j = util.JSONToTable(str)

    if not j then
        return err("JSON:UnableToCreate")
    end

    cb(j)
end

function NoClip.BuildEndpoint(ep)
    return (NoClip.RoleSync.Config.ServerURL:gsub("%/+$", "")) .. "/api/v1/gmod/" .. ep .. "?api_key=" .. NoClip.RoleSync.Config.APIKey
end

local cached_ranks = {}
function NoClip.GetRank(rankid, callback, err)
    if cached_ranks[rankid] then
        return callback(cached_ranks[rankid])
    end

    http.Fetch(NoClip.BuildEndpoint("roles"), function(b, _, _, code)
        if code != 200 then
            return err("CODE:" .. code)
        end

        NoClip.ValidJSON(b, function(j)
            for k,v in ipairs(j.data or {}) do
                cached_ranks[v.id] = v
            end

            if cached_ranks[rankid] then
                return callback(cached_ranks[rankid], b, j)
            end

            err("ROLE:NonExistent", rankid, cached_ranks)
        end, err)
    end, function(errormsg)
        err("HTTP:" .. errormsg)
    end )
end

local cached_plys = {}
function NoClip.GetPlayer(pl, callback, err)
    pl = (IsEntity(pl) and pl:SteamID64()) or pl

    if cached_plys[pl] then
        return cached_plys[pl]
    end

    http.Fetch(NoClip.BuildEndpoint("users/" .. pl), function(b, _, _, code)
        if code != 200 then
            return err("CODE:" .. code)
        end

        NoClip.ValidJSON(b, function(j)
            for k,v in pairs(j.data.roles) do
                cached_ranks[v.id] = v
            end

            cached_plys[pl] = j.data

            callback(cached_plys[pl])
        end, err)
    end, function(errormsg)
        err("HTTP:" .. errmsg)
    end )
end

function NoClip.AssignRank(pl, rank, cb, err)
    pl = (IsEntity(pl) and pl:SteamID64()) or pl

    http.Post(NoClip.BuildEndpoint("roles/" .. rank .. "/" .. pl .. "/assign"), {}, function(b, _, _, c)
        if c != 200 then
            return err("CODE:" .. c, NoClip.BuildEndpoint("roles/" .. rank .. "/" .. pl .. "/assign"))
        end

        NoClip.ValidJSON(b, function(j)
            cached_plys[pl] = j.data
            cb(j.data, NoClip.HasRank(j.data.roles, rank))
        end, err)
    end, function(c)
        err("HTTP:" .. c)
    end)
end

function NoClip.RevokeRank(pl, rank, cb, err)
    pl = (IsEntity(pl) and pl:SteamID64()) or pl

    http.Post(NoClip.BuildEndpoint("roles/" .. rank .. "/" .. pl .. "/revoke"), {}, function(b, _, _, c)
        if c != 200 then
            return err("CODE:" .. c)
        end

        NoClip.ValidJSON(b, function(j)
            cached_plys[pl] = j.data
            cb(j.data, NoClip.HasRank(j.data.roles, rank))
        end, err)
    end, function(c)
        err("HTTP:" .. c)
    end)
end

function NoClip.RankNameToID(name)
    for k,v in pairs(cached_ranks) do
        if v.name == name then
            return k
        end
    end

    return false
end

function NoClip.RankIDToName(rankid, cb, err)
    if cached_ranks[rankid] then
        return cb(cached_ranks[rankid].name)
    end

    NoClip.GetRank(rankid, function(rank)
        return cb(rank.name)
    end, err)
end

function NoClip.GetPlayerRanks(pl, cb, err)
    NoClip.GetPlayer(pl, function(pl_table)
        cb(pl_table.roles)
    end, err)
end

function NoClip.HasRank(ranks, rankid)
    for k,v in pairs(ranks) do
        if v.id == rankid then return v end
    end

    return false
end

function NoClip.ClearCaches()
    cached_ranks = {}
    cached_plys = {}
end

concommand.Add("noclip_debug_dump_caches", function()
    NoClip.ClearCaches()
end)

NoClip.DebugReFullfill()
