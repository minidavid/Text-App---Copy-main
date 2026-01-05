require('UIFolder.UI')

-- Effect variables
rain = {}
rain2 = {}
size = 1000
local currentDay = os.date("%d")  -- Store the current day for comparison
local currentMonth = os.date("%m")

-- Initialize rain drops
for i = 1, 1000 do
    rain[i] = {
        x = math.random(0, love.graphics.getWidth()),
        y = math.random(0, 500)
    }
end

for i = 1, 2 do  -- Only 2 drops for rain2 as per the initial setup
    rain2[i] = {
        x = math.random(0, love.graphics.getWidth()),
        y = math.random(0, 500)
    }
end

rain3 = {}
for i = 1, 1000 do  -- Only 2 drops for rain2 as per the initial setup
    rain3[i] = {
        x = math.random(love.graphics.getWidth()/2-100, love.graphics.getWidth()/2+100),
        y = math.random(love.graphics.getHeight()/2-100, love.graphics.getHeight()/2+100),
        dirX = math.random(-1,1),
        dirY = math.random(-1,1)
    }
end



----christmas data
local pixelX = love.graphics.getWidth()/2
local pixelY = love.graphics.getHeight()
local pixelTime = 0

local xRectPos = 0
local yRectPos = 0

function Rain()
    love.graphics.print(currentMonth,100,100)
    -- Check if it's the 15th day
    if currentDay == "15" then
        size = 1
    else
        size = 1000
    end

    if currentDay=="01" then
        love.graphics.print("It's the First Day of Month :)",0,0)
    end

    if currentDay=="26" and currentMonth=="12" then
        love.graphics.print("Happy Boxing Day!",0,0)
    end


    -- Christmas rain

    for r = 20,25 do
        if currentDay==tostring(r) and currentMonth=="12"         
        then
        love.graphics.print("Merry Christmas!",UI.x,love.graphics.getHeight()-120)
                
                for i = 1, #rain do

                    love.graphics.points(rain[i].x, rain[i].y)
                    rain[i].y = rain[i].y + 1

                    -- Reset rain drop position when it reaches the bottom
                    if rain[i].y > love.graphics.getHeight() - 100 then
                        rain[i].y = -2
                        rain[i].x = math.random(0, love.graphics.getWidth())
                        rain[i].y = math.random(0, 500)
                    end
                end
        end
    end


    if currentDay=="04" and currentMonth=="01" then

        pixelTime = pixelTime + 2


        if pixelTime < 400 then
            
            for i = 0,100-pixelTime/4.6 do
                love.graphics.points(pixelX+5-pixelTime/140,pixelY-pixelTime+i)
            
            end
        end

        
        if pixelTime > 400 and pixelTime<500 then
            


            for i = 1, #rain3 do

                DrawnewYear()
                love.graphics.points(rain3[i].x, rain3[i].y)
                    
                rain3[i].y = rain3[i].y + rain3[i].dirY+rain3[i].dirX+0.1
                rain3[i].x = rain3[i].x + rain3[i].dirX+0.1
    
                        

            end



        end




        if pixelTime>500 and love.timer.getTime()<12 then
            pixelTime = 0
        end


    end




--/home/davidnjihia/Downloads/Text-App---Copy-main/image/Untitled.png

    --Hearty Valentines day
    local closetoeachother = 130  -- Define the minimum distance to avoid overlap

    -- Draw and update rain2
    if currentDay == "14" and currentMonth=="02" then
        love.graphics.print("Jovial Valentines Day!",UI.x,love.graphics.getHeight()-120)

        for i = 1, #rain2 do
            -- Display the custom text for rain2
            love.graphics.print([[
              ..      ..
            ......  ......
           ................
            ..............
             ..........
               ......
                 .]], rain2[i].x, rain2[i].y)
    
            -- Move rain2 upwards and sinusoidal horizontal movement
            rain2[i].y = rain2[i].y - 1
            rain2[i].x = rain2[i].x - math.sin(love.timer.getTime())
    
            -- Reset rain2 drop position when it reaches the top
            if rain2[i].y < -100 then
                rain2[i].y = love.graphics.getHeight()  -- Reset the y position to the bottom
    
                -- Check for overlap with other raindrops
                local overlap = false  -- Initialize overlap to false before each check
    
                -- Loop through other raindrops to check for proximity
                for j = 1, #rain2 do
                    if i ~= j then
                        -- Calculate the distance between raindrop i and raindrop j
                        local dist = math.sqrt((rain2[i].x - rain2[j].x)^2 + (rain2[i].y - rain2[j].y)^2)
    
                        -- If the raindrops are too close, set overlap to true
                        if dist < closetoeachother then
                            overlap = true
                            break
                        end
                    end
                end
                
                
                
                -- If no overlap, reset the x position to a random value
                if not overlap then
                    rain2[i].x = math.random(0, love.graphics.getWidth())
                end

            end
        end
    end
end    



function DrawnewYear()
    love.graphics.print([[
        *   *   ****      
        **  *   *        
        * * *   ****        
        *  **   *           
        *   *   ****    
    ]],80,200)

    love.graphics.print([[
        *    *     
        *    *      
        * * *      
        ** **           
        *    *    
    ]],150,200)


    love.graphics.print([[
        *   *  ****    
         * *   *       
          *    ***    
          *    *      
          *    ***** 

    ]],200,200)

    love.graphics.print([[
         ***  
        *   *
        ****
        *   *
        *   *
    ]],270,200)

    love.graphics.print([[
        ***  
       *   *
       ****
       * *
       *   *
   ]],310,200)
end