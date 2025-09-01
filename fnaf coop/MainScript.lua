local placeids = {
    lobby = 12495498157,
    lobby2 = 12497341251,
    fnaf1 = 12497348201
}

if (game.PlaceId == placeids.lobby or game.PlaceId == placeids.lobby2) then 
    loadstring(game:HttpGet("https://raw.githubusercontent.com/snovvvvy/snow-client/main/fnaf%20coop/Lobby.lua"))()
elseif (game.PlaceId == placeids.fnaf1) then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/snovvvvy/snow-client/main/fnaf%20coop/fnaf1.lua"))()
end