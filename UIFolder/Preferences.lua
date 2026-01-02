scrollSpeed = 1

function LoadPreferences()

end

mouseOrScrollbar = {
    x = UI.x + UI.width * 6.7,
    startMoveLeft = false,
    startMoveRight = false,
    leftPressed = false,
    rightPressed = true
}

distanceScroll = {
    x = UI.x + UI.width * 6.7+50,
    y = 240
}


 

function DrawPreferences()
 
    if preferencesClicked[#preferencesClicked] then
        
        ScrollbarOrMouse() 


        DistanceScrollActivity() --Adjusts scrollSpeed
        
        ResizeWindow()
        ScreenShakeToggle()
        ClearUI()
        AdjustVolume()

    end


    --if I press X,
    -- table.insert(preferencesClicked,false)


end


function ScrollbarOrMouse()
    love.graphics.circle("line", mouseOrScrollbar.x, love.graphics.getHeight()-400, 10, mouseOrScrollbar.x/80)
    love.graphics.print("__________________", 354, love.graphics.getHeight()-400)
    
    --if you hover over circle left
    if (math.sqrt(UI.x+UI.width*6.7-mx)^2+(love.graphics.getHeight()-400-my)^2)<30
    and mouseOrScrollbar.leftPressed == false
    then
        love.graphics.print("Scroll with mouse?",mx+20,my-20)



        --if you press mouse activate scroll with scroll
        if love.mouse.isDown(1,1)            
        then
            mouseOrScrollbar.startMoveRight = true
            mouseOrScrollbar.startMoveLeft = false
        end

    end

    if mouseOrScrollbar.startMoveRight then

        if mouseOrScrollbar.x < UI.x + UI.width * 6.7+100 then
            mouseOrScrollbar.x = mouseOrScrollbar.x + 10
        
        elseif mouseOrScrollbar.x>= UI.x + UI.width * 6.7+100 then            
            mouseOrScrollbar.startMoveLeft = false
            mouseOrScrollbar.leftPressed = true
            mouseOrScrollbar.rightPressed = false
            scrollWithMouse = true
            scrollWithScrollbar = false       
        end
    
    end
    if mouseOrScrollbar.startMoveLeft then
        
        if mouseOrScrollbar.x > UI.x + UI.width * 6.7 then
            mouseOrScrollbar.x = mouseOrScrollbar.x - 10        
        elseif mouseOrScrollbar.x <= UI.x + UI.width * 6.7 then
            
            mouseOrScrollbar.startMoveRight = false
            mouseOrScrollbar.rightPressed = true
            mouseOrScrollbar.leftPressed = false
            scrollWithMouse = false
            scrollWithScrollbar = true
        end


    end



    --swap to mouse
    if (math.sqrt(467-mx)^2+(love.graphics.getHeight()-400-my)^2)<30
    and mouseOrScrollbar.rightPressed == false
    then
        love.graphics.print("Scroll with scrollbar?",mx-140,my-20)



        --if you press mouse
        if love.mouse.isDown(1,1) then
            mouseOrScrollbar.startMoveLeft = true
            mouseOrScrollbar.startMoveRight = false
      end

    end
end



function DistanceScrollActivity()
    love.graphics.rectangle("line",distanceScroll.x, love.graphics.getHeight()-360,50,30)
    love.graphics.print("Scroll Speed:     ".. scrollSpeed, distanceScroll.x - 85, love.graphics.getHeight()-350)

   if (mx > distanceScroll.x-20
    and mx < distanceScroll.x + 240
    and my > love.graphics.getHeight()-360
    and my < love.graphics.getHeight()-340
    )
    then


        for i = 0,9 do
            if love.keyboard.isDown(i) then
                scrollSpeed = i
            end
        end -- for
    end -- if 

end

----------------------------
fullScreen = false
startFullScreenTimer = false
fullScreent = 0


function ResizeWindow()
    love.graphics.rectangle("line",405, love.graphics.getHeight()-300,20,20)
    love.graphics.print("Full Screen",330, love.graphics.getHeight()-300)

    if (mx > 405
    and mx < 450
    and my > love.graphics.getHeight()-300
    and my < love.graphics.getHeight()-270
    )
    then
        if love.mouse.isDown(1,1) 
        and not fullScreen
        and not startFullScreenTimer
        then
            fullScreen = true
            startFullScreenTimer = true

        elseif love.mouse.isDown(1,1) 
        and fullScreen
        and not startFullScreenTimer then
            fullScreen = false
            startFullScreenTimer = true
        end
    end

    if startFullScreenTimer
    then
        fullScreent = fullScreent + 1
    end

    if fullScreent > 20 then
        startFullScreenTimer = false
        fullScreent = 0
    end



    if fullScreen then
        love.window.setFullscreen(true)
        love.graphics.print("X",410,love.graphics.getHeight()-298)
    else
        love.window.setFullscreen(false)
    end

    --code more here checker
    --love.window.setFullscreen(true)    
end


function ClearUI()
    love.graphics.print("Clear UI",370,love.graphics.getHeight()-250)

    if (mx > 370
    and mx < 420
    and my > love.graphics.getHeight()-250
    and my < love.graphics.getHeight()-240
    ) then
        love.graphics.print("Click to Clear Clutter",mx-20,my-20)
        
        if love.mouse.isDown(1,1) then
            table.insert(fileClicked,false)
            table.insert(aboutPressed,false)
            table.insert(editClicked,false)
            table.insert(preferencesClicked,false)

               
               for k in pairs(mousePixTable) do
                    mousePixTable[k] = nil         
               end

        end
    end

end


local screenShakeToggle = ""
screenShakeTogglePressed = {false}

local startscreenShakeTimer = false
local screenShakeTimert = 0

function ScreenShakeToggle()
    love.graphics.print("Screenshake:  "..screenShakeToggle, UI.x, love.graphics.getHeight()-300)
    love.graphics.rectangle("line", UI.x + UI.width * 1.7, love.graphics.getHeight()-300,20,20)

    if (mx > UI.x + UI.width * 1.7-10
    and mx < UI.x + UI.width * 1.7 + UI.width+10
    and my > love.graphics.getHeight()-310
    and my < love.graphics.getHeight()-280    
    )
    then
        
        
        if love.mouse.isDown(1,1) 
        then            


            if not screenShakeTogglePressed[#screenShakeTogglePressed]
            and not startscreenShakeTimer
            then
                table.insert(screenShakeTogglePressed, true)
                startscreenShakeTimer = true
            
            elseif screenShakeTogglePressed[#screenShakeTogglePressed]
            and not startscreenShakeTimer
            then
                table.insert(screenShakeTogglePressed, false)
                startscreenShakeTimer = true
                
            end
    

        end
    
    end

    if screenShakeTogglePressed[#screenShakeTogglePressed] == true then
        screenShakeToggle = "   X"
    else
        screenShakeToggle = ""
    end

    --for the timer 
    if startscreenShakeTimer then
        screenShakeTimert = screenShakeTimert + 1
    end

    if screenShakeTimert > 20 then
        startscreenShakeTimer = false
        screenShakeTimert = 0
    end

end

volume = 0
local mousePos

function AdjustVolume()
    love.graphics.print("Volume:  " .. volume, UI.x, love.graphics.getHeight() - 350)
    love.graphics.rectangle("line", UI.x + UI.width, love.graphics.getHeight() - 350, 20, 20)
    
    
    if (mx > UI.x + UI.width
    and mx < UI.x + UI.width + 20
    and my > love.graphics.getHeight() - 350
    and my < love.graphics.getHeight() - 350 + 20) -- Corrected rectangle bounds
    then
        love.graphics.print("Volume is from 0-0.9", UI.x, love.graphics.getHeight() - 330) -- Added a position for the "Yes" text

        -- Adjust the volume (simplified logic)

        for i=0,9 do
            if isKeyHeldOrTapped(i) then -- Replace '1' with the appropriate key index
                volume = i/10 -- Decrease volume incrementally
            end
        end


    end -- if
end
