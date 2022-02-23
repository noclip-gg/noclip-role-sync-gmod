
NoClip.RoleSync.Config = NoClip.RoleSync.Config or {}

---[[
-----------------------------------
------------- General -------------
-----------------------------------
---]]

-----------------------------------------------------------------------------------------
-- NoClip.RoleSync.Config.Mode = "web to server" or "server to web"
-----------------------------------------------------------------------------------------
-- This option sets the mode of this addon
-- 
-- web to server: Gives usergroups from the website ingame
-- server to web: Gives ranks on the website based on the usergroups ingame
--

NoClip.RoleSync.Config.Mode = "web to server"
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- NoClip.RoleSync.Config.ServerURL
-----------------------------------------------------------------------------------------
-- This is the URL to your servers forum
-- This is required
--
-- This should be something like:  https://example.noclip.me/
-- Trailing slashes dont matter
--

NoClip.RoleSync.Config.ServerURL = ""
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- NoClip.RoleSync.Config.APIKey
-----------------------------------------------------------------------------------------
-- This is the API key to enable the ability to do everything
-- This is required
--
-- You can find this at https://<YOUR_COMMUNITY_URL>/dashboard/settings
--

NoClip.RoleSync.Config.APIKey = ""
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- NoClip.RoleSync.Config.ReCheck = 60 * 30
-----------------------------------------------------------------------------------------
-- This is the time between checking for updates in seconds
-- Keep this reasonable, dont set it below 15 minutes
--
-- Default is 30 minutes (60 * 30)
--

NoClip.RoleSync.Config.ReCheck = 60 * 30
-----------------------------------------------------------------------------------------

