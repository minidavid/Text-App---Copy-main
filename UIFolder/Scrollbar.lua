scroller = {
    x = 530,
    y = 0
}


--RECALL: Assign scroller.x to mx or scoll.posX, and scoller.y to my or scroll.posY
scrollWithMouse = false
scrollWithScrollbar = true


function Scrollbar()
    DrawScrollbar()
    ScrollbarActivity()
end

--scroll with scroll wheel
function love.wheelmoved(x,y)

    --horizontal scrolling
    if x<0 then
        scroller.x = scroller.x - scrollSpeed * 20
    end
    
    if x>0 then
        scroller.x = scroller.x + scrollSpeed * 20
    end

    --vertical scrolling
    if y<0 then
        scroller.y = scroller.y - scrollSpeed
    end
    if y>0 then
        scroller.y = scroller.y + scrollSpeed
    end

    ScrollSfx()
end
----



function DrawScrollbar()

    if scrollWithScrollbar and love.graphics.getWidth()>500 then
        love.graphics.rectangle("line",love.graphics.getWidth() - 20,0,20,love.graphics.getHeight())
        love.graphics.rectangle("line",love.graphics.getWidth() - 20,scroller.y,20,20)        
        love.graphics.rectangle("line",scroller.x,love.graphics.getHeight()-20,20,20)        
        love.graphics.rectangle("line",530,love.graphics.getHeight()-20,love.graphics.getWidth()-500,20)        


    end

    --scroll with scroll bar
    if (mx > love.graphics.getWidth()-20
    and mx < love.graphics.getWidth()
    and my > scroller.y-600
    and my < scroller.y + 600
    ) then
        if love.mouse.isDown(1,1) then
            local pos = math.atan2(mx - love.graphics.getWidth()-20, my - scroller.y)
            scroller.y = scroller.y + 1*(math.cos(pos) ) 
            
            if math.cos(pos)>.5 then
                scrollSpeed = math.abs(scrollSpeed)        
            elseif math.cos(pos)<.5 then
                scrollSpeed = -scrollSpeed
            end
        
        end
    end

    --horizotal scroll bar
    if (mx > scroller.x-500
    and mx < scroller.x+love.graphics.getWidth()
    and my > love.graphics.getHeight()-20
    and my < love.graphics.getHeight()
    ) then
        if love.mouse.isDown(1,1) then

            if scroller.x < 530 then
                scroller.x = 530
            end
            local pos = math.atan2(mx - scroller.x, my - love.graphics.getHeight() - 20)
            scroller.x = scroller.x + 1*math.sin(pos)

        end
    end


end

function ScrollbarActivity()
    if scrollWithMouse then
        scroller.x = mx
        scroller.y = my
        ScrollSfx()
    end
end

--/home/davidnjihia/Downloads/Text-App---Copy-main/UIFolder/Scrollbar.lua

function ScrollSfx()
    sr2:setVolume(volume)
    sr2:setPitch(math.random(1,10)/10)
    sr2:play()
end