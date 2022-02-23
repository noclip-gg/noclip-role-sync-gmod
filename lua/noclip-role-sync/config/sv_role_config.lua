
NoClip.RoleSync.Config = NoClip.RoleSync.Config or {}

NoClip.RoleSync.Config.Roles = {}
NoClip.RoleSync.Config.Usergroups = {}

---[[
-----------------------------------
---------- Web To Server ----------
-----------------------------------
---]]

-----------------------------------------------------------------------------------------
-- NoClip.RoleSync.Config.RevertTo = false or string
-----------------------------------------------------------------------------------------
-- This option gives complete usergroup handling to the website
-- Only set this if you absolutely need this
-- 
-- false: Gives usergroups given from the forums, doesnt revert them when 
--        revoked on the site
--
-- any:   Gives usegroups given from the forums and reverts to the value
--        regardless of usergroup otherwise
--
--        if you had the Owner on the website and it was configured to superadmin
--        here, youd be given superadmin
--        if you had superadmin on the server and Member on the website, youd be
--        given the value that the options set to.
--

NoClip.RoleSync.Config.RevertTo                     = false
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- NoClip.RoleSync.Config.Roles[x] = y
-----------------------------------------------------------------------------------------
-- These are roles that are from the website and are synced to the server
-- RankID's can be found when editing roles, after dashboard/roles/
-- The order these are given is based on priority, 
-- the highest priority level the user has is what will be given
--
-- [example]
-- 
-- 1 Owner
-- 2 Admin
-- 3 Mod
-- 4 User
-- 
-- If the user had the roles Admin and Mod, theyd be given Admin first
-- 
-- NoClip.RoleSync.Config.Roles["RankID"] = "usergroup"
--

NoClip.RoleSync.Config.Roles["examplerankid"] = "example"
-----------------------------------------------------------------------------------------


---[[
-----------------------------------
---------- Server To Web ----------
-----------------------------------
---]]

-----------------------------------------------------------------------------------------
-- NoClip.RoleSync.Config.Usergroups[y] = x
-----------------------------------------------------------------------------------------
-- These are usergroups to be fullfilled on the website
-- Same as up there except here the usergroups are to a web rank
--
-- NoClip.RoleSync.Config.Usergroups["usergroup"] = "RankID"
--

NoClip.RoleSync.Config.Usergroups["example"] = "examplerankid"
-----------------------------------------------------------------------------------------
