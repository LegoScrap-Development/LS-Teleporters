function notify(text) 
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, true, -1)
end

function notify2(text)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandThefeedPostTicker(true, false)
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1)
            for i = 1, #Config, 1 do
                loc = Config[i]

                DrawMarker( -- Bottom Marker
                    27,loc.pos.x,loc.pos.y,loc.pos.z-0.75,
                    0.0,0.0,0.0,0.0,0.0,0.0,
                    loc.scale,loc.scale,loc.scale,
                    loc.rgba[1],loc.rgba[2],loc.rgba[3],loc.rgba[4],
                    false,true,2,nil,nil,false
                )
                DrawMarker( -- Top Marker
                    loc.marker,loc.pos.x,loc.pos.y,loc.pos.z + 2.0,
                    0.0,0.0,0.0,0.0,0.0,0.0,
                    loc.scale/2,loc.scale/2,loc.scale/2,
                    loc.rgba[1],loc.rgba[2],loc.rgba[3],loc.rgba[4],
                    false,true,2,nil,nil,false
                )

                local playerCoord = GetEntityCoords(PlayerPedId(), false)
                local locVector = vector3(loc.pos.x, loc.pos.y, loc.pos.z)
                if Vdist2(playerCoord, locVector) < loc.scale*1.12 and GetVehiclePedIsIn(PlayerPedId(), false) == 0 then
                    if IsControlJustPressed(0, 38) then
                        DoScreenFadeOut(500)
                        Citizen.Wait(2500)    
                        SetEntityCoords(PlayerPedId(), loc.tpto.x, loc.tpto.y, loc.tpto.z, true, true, true, false)
                        SetEntityHeading(PlayerPedId(), 0)
                        Citizen.Wait(6000) 
                        DoScreenFadeIn(2000) 
                        notify2("You have been teleported to ~y~".. loc.placename) 
                    else
                        notify("Press ~INPUT_PICKUP~ to teleport to ".. loc.placename)
                    end
                end
            end
        end
    end
)
