require('AnimationWipe') -- animationLines for the color wipe while hovering over menu

fileClicked = {false}


--while you hover over FILES
function WhileFileHover()
    return (mx > UI.x)
    and (mx < UI.x+UI.width)
    and (my > UI.y-10)
    and (my < UI.height+7)    
end




function DisplayFileRect()

    --------show rectangle when hover over FILES
    if WhileFileHover() then
        love.graphics.rectangle("line",UI.x-10,UI.y-10,UI.width,UI.height)
        SwipeForFileAnimationHover()
    end



    ---------register that you've clicked FILES
    if WhileFileHover()
    and love.mouse.isDown(1,1)
    then
        sr1:setVolume(volume)
        sr1:setPitch(0.5)
        sr1:play()
        table.insert(fileClicked, true)

        if screenShakeTogglePressed[#screenShakeTogglePressed] then
            love.graphics.translate(math.random(-10,10),math.random(-10,10))            
        end

    elseif not WhileColourHover()
    and love.mouse.isDown(1,1)
    then
        
       --table.insert(fileClicked,false)
    end

    
end

function DisplayFileSubmenu()
    if fileClicked[#fileClicked] == true 
    then
        love.graphics.print("about",UI.x,UI.y+30)
        love.graphics.print("new",UI.x,UI.y+60)
        love.graphics.print("open",UI.x,UI.y+90)
        love.graphics.print("save",UI.x,UI.y+120)            
    end

end
