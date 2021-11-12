CHEST_LEVEL = 3
dofile_once("data/scripts/director_helpers.lua")
dofile_once("data/scripts/biome_scripts.lua")
dofile_once("data/scripts/lib/utilities.lua")

RegisterSpawnFunction( 0xffffeedd, "init" )
RegisterSpawnFunction( 0xffbbcc00, "spawn_check1" )
RegisterSpawnFunction( 0xffbbcc01, "spawn_check2" )
RegisterSpawnFunction( 0xffbbcc02, "spawn_check3" )

function spawn_small_enemies( x, y ) end
function spawn_big_enemies( x, y ) end
function spawn_items( x, y ) end
function spawn_props( x, y ) end
function spawn_props2( x, y ) end
function spawn_props3( x, y ) end
function spawn_lamp( x, y ) end
function load_pixel_scene( x, y ) end
function load_pixel_scene2( x, y ) end
function spawn_unique_enemy( x, y ) end
function spawn_unique_enemy2( x, y ) end
function spawn_unique_enemy3( x, y ) end
function spawn_ghostlamp( x, y ) end
function spawn_candles( x, y ) end
function spawn_potions( x, y ) end
function spawn_wands( x, y ) end

function init( x, y, w, h )
	LoadPixelScene( "data/biome_impl/null_room.png", "data/biome_impl/null_room_visual.png", x, y, "", true )
end

function spawn_orb(x, y)
end

function spawn_check1(x, y)
	EntityLoad( "data/entities/buildings/null_room/check1.xml", x, y )
end

function spawn_check2(x, y)
	EntityLoad( "data/entities/buildings/null_room/check2.xml", x, y )
end

function spawn_check3(x, y)
	EntityLoad( "data/entities/buildings/null_room/check3.xml", x, y )
end