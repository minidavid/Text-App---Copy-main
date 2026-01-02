

----------------data
currentColor = {1}
t = 0
startT = {false}



--------------------------easy read
function WhileColourHover()
    return (mx > UI.x+UI.width*7)
    and (mx < UI.x+UI.width*7+UI.width)
    and (my > UI.y)
    and (my < UI.height)    
end



-----------------------------------main code section for this file
function UIActivity()


    StartT()
    UIColorSwitch()


    --when click color ui with mouse
    if currentColor[#currentColor]~= nil then
        if WhileColourHover()
        and love.mouse.isDown(1, 1)
        then
            ColorSwitch()

            if screenShakeTogglePressed[#screenShakeTogglePressed] then
                love.graphics.translate(math.random(-10,10),math.random(-10,10))
            end
        end
    end
        

    --when hover over color ui
    if WhileColourHover() then
        love.graphics.rectangle("line", UI.x-10+UI.width*7, UI.y-5, UI.width, UI.height)
        SwipeForColourAnimationHover()


    end


    --so you have color of ui
    if currentColor[#currentColor] ~= nil then
        color = currentColor[#currentColor]
    end

    


end

----------------------------
function ColorSwitch()

    --if white, & timer hasn't started, flip color & have timer table (startT) set to true
    if currentColor[#currentColor] == 1 
    and startT[#startT] == false
    then
            color = 0
            table.insert(currentColor,color)
            table.insert(startT,true) --timer initiates

    elseif currentColor[#currentColor]==0
    and startT[#startT]==false
    then
        color = 1
        table.insert(currentColor,color)
        table.insert(startT,true) --timer initiates
    end

    

    
end


-------------------------------This just checks each frame for ui color
function UIColorSwitch()
    if color == 1 then
        love.graphics.setBackgroundColor(white)
        love.graphics.setColor(white)
        love.graphics.draw(img2,360,15,0,0.06,0.07,0,0)
        love.graphics.setColor(black)


    elseif color == 0 then
        love.graphics.setBackgroundColor(black)
        love.graphics.setColor(white)
        love.graphics.draw(img,360,15,0,0.06,0.07,0,0)
    end
end


----------------------
function StartT()
    if startT[#startT] then
        t = t + 1
    end
    if t>20 then
        t = 0
        table.insert(startT,false)
    end
    
end





----------------optional timer function
function wait(s)
    local timer = io.popen("sleep"..s)
    timer:close(s)    
end


