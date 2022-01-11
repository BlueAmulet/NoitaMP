dofile("mods/noita-mp/files/scripts/init/init_.lua")

local fu = require("file_util")
local em = require("entity_manager")

fu.SetAbsolutePathOfNoitaRootDirectory()

ModMagicNumbersFileAdd("mods/noita-mp/files/data/magic_numbers.xml")
print("init.lua | loading world seed magic number xml file.")
local world_seed_magic_numbers_path = fu.GetAbsoluteDirectoryPathOfMods() .. "/files/tmp/magic_numbers/world_seed.xml"
if fu.Exists(world_seed_magic_numbers_path) then
    GamePrint("init.lua | Loading " .. world_seed_magic_numbers_path)
    ModMagicNumbersFileAdd(world_seed_magic_numbers_path)
else
    GamePrint("init.lua | Unable to load " .. world_seed_magic_numbers_path)
end

fu.Find7zipExecutable()

function OnModPreInit()
    -- the seed is set when first time connecting to a server, otherwise 0
    local seed = tonumber(ModSettingGet("noita-mp.connect_server_seed"))

    if not seed and seed > 0 then
        SetWorldSeed(seed)
        _G.Client:connect()
    end
end

function OnWorldInitialized()
    print("init.lua | OnWorldInitialized()")

    local make_zip = ModSettingGet("noita-mp.server_start_7zip_savegame")
    print("init.lua | make_zip = " .. tostring(make_zip))
    if make_zip then
        local archive_name = "server_save06_" .. os.date("%Y-%m-%d_%H-%M-%S")
        local destination = fu.GetAbsoluteDirectoryPathOfMods() .. _G.path_separator .. "_"
        local archive_content =
            fu.Create7zipArchive(archive_name .. "_from_server", fu.GetAbsoluteDirectoryPathOfSave06(), destination)
        local msg =
            ("init.lua | Server savegame [%s] was zipped with 7z to location [%s]."):format(archive_name, destination)
        print(msg)
        GamePrint(msg)
        ModSettingSetNextValue("noita-mp.server_start_7zip_savegame", false, false) -- automatically start the server again
    end

    print("init.lua | Initialise client and server stuff..")
    dofile_once("mods/noita-mp/files/scripts/net/server_class.lua") -- run once to init server object
    dofile_once("mods/noita-mp/files/scripts/net/client_class.lua") -- run once to init client object
end

function OnPlayerSpawned(player_entity) -- This runs when player entity has been created
    -- if Server.super then
    --     GamePrintImportant( "Server started", "Your server is running on "
    --     .. Server.super:getAddress() .. ":" .. Server.super:getPort() .. ". Tell your friends to join!")
    -- else
    --     GamePrintImportant( "Server not started", "Your server wasn't started yet. Check ModSettings to change this or Press M to open multiplayer menu.")
    -- end
end

function OnWorldPreUpdate()
    if _G.Server then
        _G.Server:update()
    end

    if _G.Client then
        _G.Client:update()
    end

    dofile("mods/noita-mp/files/scripts/ui.lua")
end
