--require('UIFolder.UI')


function FileSubmenu()
    DisplayAbout()
    Displaynew()
    DisplayOpen()
    DisplaySave()

    DisplayEdit()
end






--FILE pressed after that...

-------------About Code-------------
function WhileAboutSubmenuHover()
    return (mx > UI.x)
    and (mx < UI.x + UI.width)
    and (my > UI.y + 30)
    and (my < UI.y + 30 + UI.height)
    
end


---------

aboutPressed = {false}

-----------
function DisplayAbout()

    --Hover over About
    if WhileAboutSubmenuHover()
    and fileClicked[#fileClicked]==true
    then
        love.graphics.rectangle("line",UI.x-10, UI.y + 20, UI.width, UI.height)
    end

    --Click FILE> About
    if WhileAboutSubmenuHover()
    and love.mouse.isDown(1,1)
    then

        --this looks prettier
        sr1:setVolume(volume)
        sr1:setPitch(0.4)
        sr1:play()

        table.insert(aboutPressed,true)

        if screenShakeTogglePressed[#screenShakeTogglePressed] then
            love.graphics.translate(math.random(-10,20),math.random(-10,20))            
        end

    end

    if aboutPressed[#aboutPressed] then
        love.graphics.print("\nminidavid, 2025", UI.x+352, love.graphics.getHeight()-150)

        if (mx > UI.x + 352
        and mx < UI.x + UI.width * 9
        and my > UI.y + love.graphics.getHeight()-152
        and my < love.graphics.getHeight()-50)
        and not startFullScreenTimer
        then
            love.graphics.print("Open minidavid.itch.io?",mx-100,my-20)
        
            if love.mouse.isDown(1, 1) then

                sr1:setVolume(volume)
                sr1:setPitch(0.8)
                sr1:play()

                love.system.openURL("https://minidavid.itch.io/")
            end

        end

    end


end


-------------About ends here ------------------------



-----------------new file-----------------------------

function WhilenewSubmenuHover()
    return (mx > UI.x)
    and (mx < UI.x + UI.width)
    and (my > UI.y + 60)
    and (my < UI.y + 60 + UI.height)
    
end


-------------------------

function Displaynew()
    --hover over new
    if WhilenewSubmenuHover()
    and fileClicked[#fileClicked]==true
    then
        love.graphics.rectangle("line", UI.x-10, UI.y+50, UI.width, UI.height)
    end

    --click the FILE>new
    if WhilenewSubmenuHover()
    --and fileClicked[#fileClicked]
    and love.mouse.isDown(1,1) then

        sr1:setVolume(volume)
        sr1:setPitch(0.3)
        sr1:play()

        CreateTextFile()
        
        textContent = ""
        fileName = "hover & type"

        if screenShakeTogglePressed[#screenShakeTogglePressed] then
            love.graphics.translate(math.random(-10,10),math.random(-10,10))            
        end

        mode = 1 --switch to title
    else
        mode = 2
    end


end

---------------- end of new -----------------

------------------- Open ---------------------
function WhileOpenSubmenuHover()
    return (mx > UI.x)
    and (mx < UI.x + UI.width)
    and (my > UI.y + 90)
    and (my < UI.y + 90 + UI.height)
    
end

function DisplayOpen()

    --hover over new
    if WhileOpenSubmenuHover()
    and fileClicked[#fileClicked]==true
    then
        love.graphics.rectangle("line", UI.x-10, UI.y+80, UI.width, UI.height)
    end

    --click
    if WhileOpenSubmenuHover()
    and love.mouse.isDown(1,1) then

        sr1:setVolume(volume)
        sr1:setPitch(0.2)
        sr1:play()

        FileStuffOpen() --FileStuff.lua file, write the file
        
        if screenShakeTogglePressed[#screenShakeTogglePressed] then
            love.graphics.translate(math.random(-10,10),math.random(-10,10))            
        end

    end

end


---------------- end of open -----------------

--------------------SAVE----------------------
function WhileSaveSubmenuHover()
    return (mx > UI.x-10)
    and (mx < UI.x + UI.width)
    and (my > UI.y + 120)
    and (my < UI.y + 120 + UI.height)
    
end
    

function DisplaySave()

    --hover over new
    if WhileSaveSubmenuHover()
    and fileClicked[#fileClicked]==true
    then
        love.graphics.rectangle("line", UI.x-10, UI.y+110, UI.width, UI.height)
    end

    --click
    if WhileSaveSubmenuHover()
    then
        
        sr2:setVolume(volume)
        --sr2:setPitch(0.1)
        sr2:play()

        FileStuffSave() --FileStuff.lua file, write the file

        if screenShakeTogglePressed[#screenShakeTogglePressed] then
            love.graphics.translate(math.random(-10,10),math.random(-10,10))            
        end

    end

end
--------------



function WhileEditSubmenuHover()
    return (mx > UI.x + UI.width)
    and (mx < UI.x + UI.width + UI.width)
    and (my > UI.y + UI.height)
    and (my < UI.y + UI.height + UI.height)
    
end
    


preferencesClicked = {false}

function DisplayEdit()

    --hover over new
    if WhileEditSubmenuHover()
    and editClicked[#editClicked]==true
    then
        love.graphics.rectangle("line", UI.x + UI.width - 10, UI.y+UI.height-10, UI.width + UI.width, UI.height)

        if love.mouse.isDown(1,1) then

            sr1:setVolume(volume)
            sr1:setPitch(0.9)
            sr1:play()

            table.insert(preferencesClicked,true)
        end
    
    end

    --click
    if WhileSaveSubmenuHover()
    and love.mouse.isDown(1,1) then

        if screenShakeTogglePressed[#screenShakeTogglePressed] then
            love.graphics.translate(math.random(-10,10),math.random(-10,10))            
        end
        
    end


    ---------
    if (mx > UI.x + UI.width)
    and (mx < UI.x + UI.width + UI.width)
    and (my > UI.y + UI.height+29)
    and (my < UI.y + UI.height + UI.height+30)
    and editClicked[#editClicked]
    then
        love.graphics.rectangle("line", UI.x + UI.width - 10, UI.y+UI.height-10+30, UI.width + UI.width, UI.height)
        love.graphics.print("Open file?",mx+100,my)
    
        if love.mouse.isDown(1,1) then

            sr1:setVolume(volume)
            sr1:setPitch(0.8)
            sr1:play()

            love.system.openURL("https://minidavid.github.io/miniedit/")
        end
    end

    -------directory
    if (mx > UI.x + UI.width)
    and (mx < UI.x + UI.width + UI.width)
    and (my > UI.y + UI.height + UI.height+30)
    and (my < UI.y + UI.height + UI.height+50)
    and editClicked[#editClicked]
    then
        love.graphics.rectangle("line", UI.x + UI.width - 10, UI.y+UI.height+55, UI.width + UI.width, UI.height)
        love.graphics.print("Open file path?",mx+100,my)
    
        if love.mouse.isDown(1,1) then

            os.execute('start "" "' .. love.filesystem.getRealDirectory("main.lua") .. '"')

            sr1:setVolume(volume)
            sr1:setPitch(0.7)
            sr1:play()

        end
    end


end


