require('AnimationWipe') -- animationLines for the color wipe while hovering over menu

editClicked = {false}


--while you hover over FILES
function WhileEditHover()
    return (mx > UI.x+UI.width)
    and (mx < UI.x+UI.width+UI.width)
    and (my > UI.y)
    and (my < UI.height)
end




function DisplayEditRect()

    --------show rectangle when hover over FILES
    if WhileEditHover() then
        love.graphics.rectangle("line",UI.x+UI.width-10,UI.y-10,UI.width,UI.height)
        SwipeForEditAnimationHover()
    end



    ---------register that you've clicked FILES
    if WhileEditHover()
    and love.mouse.isDown(1,1)
    then
        sr1:setVolume(volume)
        sr1:setPitch(1)
        sr1:play()
        table.insert(editClicked, true)

        if screenShakeTogglePressed[#screenShakeTogglePressed] then
            love.graphics.translate(math.random(-10,10),math.random(-10,10))            
        end 

    elseif not WhileColourHover()
    and love.mouse.isDown(1,1)
    then
        
       --table.insert(fileClicked,false)
    end

    
end

function DisplayEditSubmenu()
    if editClicked[#editClicked] == true then
        love.graphics.print("Preferences",UI.x+UI.width,UI.y+30)
        love.graphics.print("Help",UI.x+UI.width, UI.y+60)
        love.graphics.print("Directory",UI.x+UI.width, UI.y+90)
    end

end
