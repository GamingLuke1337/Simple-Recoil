if Config.Updater then
    PerformHttpRequest("https://raw.githubusercontent.com/GamingLuke1337/Simple-Recoil/main/fxmanifest.lua", function(err, responseText, headers)
        
        local ScriptVersion = GetResourceMetadata(GetCurrentResourceName(), "version")
        
        local GitHubVersion = string.match(responseText, "version%s+'(%d+%.%d+%.%d+)'")
        
        if ScriptVersion == GitHubVersion then
            print("^2[INFO] Simple-Recoil is up-to-date!")
        else
            print("^3[UPDATE] Update available for Simple-Recoil! ("..ScriptVersion.." -> "..GitHubVersion..")")
            print("^3[UPDATE] https://github.com/GamingLuke1337/Simple-Recoil")
        end
    end)
end
