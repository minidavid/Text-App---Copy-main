function simpleTypewriter(text, animationSpeed, startTime, animationDirection)
    local displayed = ""
    local index, time = 0, startTime or 0

    return function(dt)
        time = time + dt
        
        -- type animation forwards
        if animationDirection == "forwards" then
            if time >= animationSpeed and index < #text then
                index = index + 1
                displayed = text:sub(1, index)
                time = 0
            end
                
        -- type animation reverse
        elseif animationDirection == "reverse" then
            if time >= animationSpeed and index < #text then
                index = index + 1
                displayed = text:sub(0, index)
                time = 0
            end

        -- type animation loop (infinite)
        elseif animationDirection == "infinite" then
            if time >= animationSpeed then
                index = (index % #text) + 1
                displayed = text:sub(1, index)
                time = 0
            end

        end
        return displayed
    end
end



--- implementation of the typewriter for draw & update in main.lua

local editText = simpleTypewriter("Edit File Name",0.5,1,"infinite")   

local displayText = ""

function DrawTypedoutText()
    love.graphics.print(displayText.." :"..fileName,(header.x + UI.x + UI.sx + UI.width * 8)/2 + 2 - string.len(fileName)*3.6,header.y-13) --UI.lua
end

function UpdateTypedOutText(dt)
    displayText = editText(dt)
end
