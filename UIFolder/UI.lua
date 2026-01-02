--------------
color = nil
UI = {
    x = 20,
    y = 20,
    r = 0,
    sx = 1,
    sy = 1,
    ox = 0,
    oy = 0,
    kx = 0,
    ky = 0,
    width = 50,
    height = 30
}

textWithClick = false

-------------------------------
function DrawUI()

    --get the color
    color = love.graphics.getBackgroundColor()


    UIDesign()
    UIActivity()
end


---------------------------------
--if the BackgroundColor is white, set color to black, else if black set to white
----------------------------------


--------------------------------------
function UIDesign()
    Menus()
    Writer()
    DisplayFileRect() --
    DisplayFileSubmenu() --FILE
    DisplayEditRect()
    DisplayEditSubmenu()

    Rain() --Effect
    --UISubmenu
    WriterApply()
end



---check date top right

local currentTime = nil
local formattedTime = nil

local strand = "----------"
speedText = {
    x = UI.x+UI.width*7 + UI.width + 5,
    y = UI.y+10
}
function Menus()
    
    Scrollbar()
    --organized from left to right
    love.graphics.print("FILE",UI.x,UI.y,UI.r,UI.sx,UI.sy,UI.ox,UI.kx,UI.ky)

    love.graphics.print("EDIT",UI.x+UI.width,UI.y,UI.r,UI.sx,UI.sy,UI.ox,UI.kx,UI.ky)

    love.graphics.print("Color", UI.x+UI.width*7, UI.y, UI.r, UI.sx, UI.sy, UI.ox, UI.oy, UI.kx, UI.ky)
    

    love.graphics.print("Undo", UI.x+UI.width*5, UI.y)


    for i = 1,700 do
        love.graphics.print(i,560-scroller.x/10,i*14-scroller.y*15-15)
    end

    --draw roller
    love.graphics.print(strand, UI.x + UI.width * 7 + UI.width + 5, UI.y+10, UI.r, UI.sx, UI.sy, UI.ox, UI.oy, UI.kx, UI.ky)
    love.graphics.circle("line", speedText.x, speedText.y, 8, 15)

    ----- text speed roller top right
    if math.sqrt((speedText.x-mx)^2+(speedText.y-my)^2)<=10 then
        love.graphics.print("text speed",400,UI.y+30)


        speedText.dir = math.atan2(speedText.y-my,speedText.x-mx)

        --move to follow the mouse
        speedText.x = speedText.x - 1 * math.cos(speedText.dir)
        
        if speedText.x < UI.x+UI.width*7 + UI.width + 5 then
            speedText.x = UI.x+UI.width*7 + UI.width + 5
        end

        if speedText.x > UI.x+UI.width*7 + UI.width + 50 then
            speedText.x = UI.x+UI.width*7 + UI.width + 50
        end

        love.graphics.print((speedText.x - UI.x-UI.width*7-UI.width)/400,420,60)
        holdDuration = (speedText.x - UI.x-UI.width*7-UI.width)/400




    end
    --text roller complete!


    --TIMER
    ShowTimer()
    --timer complete

end


day = "%d"
month = "%m"
year = "%Y"

function ShowTimer()
    currentTime = os.time()
    formattedTime = os.date("%H:%M:%S \n%A: "..day.."-"..month.."-"..year, currentTime)


    love.graphics.print(formattedTime, UI.x, love.graphics.getHeight()-150)
    
    if (mx > UI.x
    and mx < UI.x + UI.width * 2 + 40
    and my > love.graphics.getHeight()-150
    and my < love.graphics.getHeight()-120
    )    
    then

        love.graphics.print("Click to copy time",mx+20,my-20)

        if love.mouse.isDown(1,1) then
            textContent = textContent .. formattedTime

        end

    end




end




-------------------------
--header rectangle
header = {
    x = UI.x +UI.sx +300,
    y = UI.y + UI.sy + UI.height*5-50
}

function Writer()

    --fix till here 

    love.graphics.rectangle("line", header.x, header.y, UI.width*3, UI.height)    
    --love.graphics.rectangle("line", UI.x + UI.sx +490, UI.y - 20, UI.width*9 + 38, UI.height*19.95+1)    

end


------Control with hover...
headerAnimation = {
    x = header.x,
    y = header.y
}

mode = nil
function WriterApply()

    --hover over title
    if (mx > header.x)
    and (mx < header.x + header.x + UI.width * 3)
    and (my > header.y)
    and (my < header.y + UI.height)
    then
        mode = 1 -- switch to title

        
        for i = headerAnimation.x-2,headerAnimation.x,2 do
            for j = headerAnimation.y, headerAnimation.y + UI.width/2+6,2 do
                love.graphics.points(i,j)
            end
        end



        if headerAnimation.x < header.x + UI.width * 3 then
            headerAnimation.x = headerAnimation.x + 1
        else
            headerAnimation.x = header.x
        end
    
    end   
end
