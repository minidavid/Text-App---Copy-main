local utf8 = require('utf8')

fileName = "Hover to type"

textContent = ""

--- open file code -----------------------
function FileStuffOpen() 
    local file

    -- Attempt to open the file for reading
    file = io.open(fileName, "r")

    if file~=nil then
        textContent = file:read("*all")
        file:close()
    else
        textContent = "file error"
    end

end

---- save file code ------------------------
function FileStuffSave()
    local file = io.open(fileName)
    file = io.open(fileName,"w")
    textContent = textContent
    file:write(textContent)
    file:close()
end


---THE FILE name-----
function HeaderText()
    --moved to AllowEditText()
    --love.graphics.print(fileName,(header.x + UI.x + UI.sx + UI.width * 9)/2 - string.len(fileName)*3.6,header.y+6) --header vars located: UI.lua
end



------------------------------------
--- FILE>new: create new file -----
newPressed = {false}
-----------------------------------
function CreateTextFile()

    --if you press the new file you create the 
    if WhilenewSubmenuHover()
    --and fileClicked[#fileClicked]
    and love.mouse.isDown(1,1) then

        table.insert(newPressed,true)
    end

end



alphabet = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"}
numbers = {0,1,2,3,4,5,6,7,8,9}
specialchar =      {'`' , ',' , '.' , '/' , ';' , '\'' , '[' , ']' , '\\', '-' , '='}
specialcharShift = {'~' , '<' , '>' , '?' , ':' , '\"' , '{' , '}' , '|' , '_' , '+'}
local numpadShiftSymbols = {
    ")", "!", "@", "#", "$", "%", "^", "&", "*", "("
}
local keypadSymbols = {".","/", "*","-","+"}

local shiftSymbols = {")", "!", "@", "#", "$", "%", "^", "&", "*", "("}

alphabet2 = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","w","x","y","z"}
numbers2 = {1,2,3,4,5,6,7,8,9,0}
specialchar2 = {',',';','[',']','-','='}


local keyPressTime = {} -- Table to store the press time for each key
holdDuration = 0.0125 -- Threshold duration for a slow key press in seconds
cursorIndex = 1

function isKeyHeld(key)

    if love.keyboard.isDown(key) and not love.mouse.isDown(1,1) then
        if keyPressTime[key] == nil then
            keyPressTime[key] = love.timer.getTime()
        else
            if love.timer.getTime() - keyPressTime[key] >= holdDuration then
                keyPressTime[key] = nil -- Reset the press time for the key
                return true
            end
        end
    else
        keyPressTime[key] = nil
    end


    return false

end


local keyPressed = {}

function isKeyTapped(key)
    if love.keyboard.isDown(key) and not love.mouse.isDown(1,1) then
        if keyPressed[key] == nil or keyPressed[key] ==false  then
            keyPressed[key] = true

            return true
        end
    else
        keyPressed[key] = false
        return false
    end
end


function isKeyHeldOrTapped(key)
    if ((speedText.x - UI.x - UI.width * 7 - UI.width) / 400) < 0.1 then
        return isKeyHeld(key)
    else
        return isKeyTapped(key)
    end
end

--Edit the text for the header
function AllowEditTextFileName()

    -- Move cursor left


    -- Move cursor right
    if isKeyHeldOrTapped("right") then
        if cursorIndex <= #fileName then
            cursorIndex = cursorIndex + 1
        end
    elseif isKeyHeldOrTapped("left") then
        if cursorIndex >=1 then
            cursorIndex = cursorIndex - 1
        end

    end

    -- Editing fileName with keys
    for i = 1, #alphabet2 do
        if isKeyHeldOrTapped(alphabet2[i]) then
            fileName = fileName:sub(1, cursorIndex - 1) .. alphabet2[i] .. fileName:sub(cursorIndex)
            cursorIndex = cursorIndex + 1
        end
    end

    -- Handle backspace (delete at cursor position)
    if isKeyTapped("backspace") then
        if cursorIndex > 1 then
            fileName = fileName:sub(1, cursorIndex - 2) .. fileName:sub(cursorIndex)
            cursorIndex = cursorIndex - 1

        end
    end

    -- Handle space, period, and numbers
    if isKeyHeldOrTapped("space") then
        fileName = fileName:sub(1, cursorIndex - 1) .. " " .. fileName:sub(cursorIndex)
        cursorIndex = cursorIndex + 1
    end

    if isKeyHeldOrTapped(".") then
        fileName = fileName:sub(1, cursorIndex - 1) .. "." .. fileName:sub(cursorIndex)
        cursorIndex = cursorIndex + 1
    end

    -- Handle numbers
    for i = 1, #numbers2 do
        if isKeyHeldOrTapped(numbers2[i]) then
            fileName = fileName:sub(1, cursorIndex - 1) .. numbers2[i] .. fileName:sub(cursorIndex)
            cursorIndex = cursorIndex + 1
        end
    end

    -- Combine textContent with cursor placeholde
    --Draw the text 
    local textWithCursor = fileName:sub(1, cursorIndex - 1) .. "I" .. fileName:sub(cursorIndex)
    
    -- Display the updated text with the cursor as part of the string
    love.graphics.print(textWithCursor, (header.x + UI.x + UI.sx + UI.width * 9)/2 -cursorIndex - string.len(fileName)*3.6,header.y+6)

end

function tableSize(t)
    local count = 0
    for _ in pairs(t) do
        count = count + 1
    end
    return count
end

----------------------------colorful text effect for screenShake-------
local textEffects = {}
local textEff = {
    x = 0,
    y = 0,
    str = "cool"

}
local listWord = {}
local listWordPos = 0



---------------------------------------------------------------------------

function CreateTextEffect()
    local textEff = {}
    textEff.str = listWord[#listWord]
    textEff.x = 0
    textEff.y = 0
    table.insert(textEffects, textEff)

    if tableSize(textEffects)>10 then
        for i=0,2 do
            table.remove(textEffects,i)
        end
    end
    
end

-- Updated to include cursor as part of textContent
function AllowEditTextContent()


    if love.keyboard.isDown("left") and (love.keyboard.isDown("lctrl") or love.keyboard.isDown("rctrl")) then
        if cursorIndex > 1 then
            local wordStart = cursorIndex - 1
            -- Ensure the wordStart doesn't go below 1
            if wordStart < 2 then
                wordStart = 2
            end

            while wordStart >2 and not textContent:sub(wordStart, wordStart):match("%s") do
                wordStart = wordStart - 1
            end

    
            -- Move cursor to the start of the previous word
            cursorIndex = wordStart
        end
    end


    if love.keyboard.isDown("right") and (love.keyboard.isDown("lctrl") or love.keyboard.isDown("rctrl")) then
        if cursorIndex > 1 then
            local wordEnd = cursorIndex
            -- Ensure the wordStart doesn't go below 1


            while wordEnd < #textContent and not textContent:sub(wordEnd, wordEnd):match("%s") do
                wordEnd = wordEnd + 1
            end

    
            -- Move cursor to the start of the previous word
            cursorIndex = wordEnd
        end
    end



    if (love.keyboard.isDown("lctrl") or love.keyboard.isDown("rctrl")) and love.keyboard.isDown("x") then
        if cursorIndex > 1 then
            -- Find the start of the word (look backwards for spaces, or new lines, etc.)
            local wordStart = cursorIndex - 1

            -- Move backwards to the start of the word
            while wordStart > 1 and not textContent:sub(wordStart, wordStart):match("\n") do
                wordStart = wordStart - 1
            end        

            -- Cut the word (remove from wordStart to cursorIndex)
            local cutText = textContent:sub(wordStart, cursorIndex - 1)
            textContent = textContent:sub(1, wordStart - 1) .. textContent:sub(cursorIndex)
            
            -- Optionally, save the cut text to clipboard or store it in a variable
            love.system.setClipboardText(cutText)

            -- Adjust the cursor position to the start of the new word or after space
            cursorIndex = wordStart

        else
            cursorIndex = 1
        end
    end
    


    -- Move cursor left
    if isKeyHeldOrTapped("left") then
        if cursorIndex > 1 then
            cursorIndex = cursorIndex - 1
        end
    end



    -- Move cursor right
    if isKeyHeldOrTapped("right") then
        if cursorIndex <= #textContent then
            cursorIndex = cursorIndex + 1
        end
    end




    -- Copy-paste handling
    if (love.keyboard.isDown("lctrl") or love.keyboard.isDown("rctrl")) and isKeyHeldOrTapped("v") then
        local clipboardText = love.system.getClipboardText()
        textContent = textContent:sub(1, cursorIndex - 1) .. clipboardText .. textContent:sub(cursorIndex)
        cursorIndex = cursorIndex + #clipboardText
    end

    -- Insert letters, numbers, and special characters
    for i = 1, #alphabet do
        if isKeyHeldOrTapped(alphabet[i]) then
            local charToInsert = (love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift")) and string.upper(alphabet[i]) or string.lower(alphabet[i])
            textContent = textContent:sub(1, cursorIndex - 1) .. charToInsert .. textContent:sub(cursorIndex)
            cursorIndex = cursorIndex + 1

            if screenShakeTogglePressed[#screenShakeTogglePressed] then
                table.insert(listWord,charToInsert)
                CreateTextEffect()
                love.graphics.translate(-1,0)
            end

        end
    end

    for i = 1, #specialchar do
        if isKeyHeldOrTapped(specialchar[i]) then
            
            if not (love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift")) then

                textContent = textContent:sub(1, cursorIndex - 1) .. specialchar[i] .. textContent:sub(cursorIndex)
                cursorIndex = cursorIndex + 1

            else
                textContent = textContent:sub(1, cursorIndex - 1) .. specialcharShift[i] .. textContent:sub(cursorIndex)
                cursorIndex = cursorIndex + 1
            end
        end
    end

    -- Backspace handling (delete character before the cursor)
    
    if isKeyTapped("backspace") then
        if not (love.keyboard.isDown("lctrl") or love.keyboard.isDown("rctrl")) then --remove letter
            
                if cursorIndex > 1 then
                    textContent = textContent:sub(1, cursorIndex - 2) .. textContent:sub(cursorIndex)
                    cursorIndex = cursorIndex - 1
                end


        elseif (love.keyboard.isDown("lctrl") or love.keyboard.isDown("rctrl")) then -- Handle Ctrl + Backspace to delete a whole word
   
                if cursorIndex > 1 then

                    -- Find the start of the word (look backwards for spaces, or new lines, etc.)
                    local wordStart = cursorIndex - 1
        
                    -- Move backwards to the start of the word
                    while wordStart > 0 and not textContent:sub(wordStart, cursorIndex-1):match("%s") and textContent:sub(wordStart, cursorIndex-1) ~= "\n" do
                        wordStart = wordStart - 1
                    end
        
        
                    -- Delete the word
                    textContent = textContent:sub(1, wordStart) .. textContent:sub(cursorIndex)
        
                    -- Adjust the cursor position to the start of the new word (or just after the space)
                    cursorIndex = wordStart
                end

        end

    end






    -- Move up
    if isKeyHeldOrTapped("up")
    then
        if cursorIndex > 1 then

            local wordStart = cursorIndex - 1

            if wordStart < 1 then
                wordStart = 2
            end

            while wordStart > 1 and not textContent:sub(wordStart, cursorIndex-1):match("\n") do
                wordStart = wordStart - 1
            end


            cursorIndex = wordStart

            scroller.y = scroller.y - 1 --scroll with cursor

        else
            cursorIndex = 1
        end
    end


    -- Move down
    if isKeyHeldOrTapped("down")
    then
        if cursorIndex <#textContent then

            local wordStart = cursorIndex + 1
            while wordStart <#textContent and not textContent:sub(wordStart, wordStart):match("\n") do
                wordStart = wordStart + 1
            end

            
            cursorIndex = wordStart


            scroller.y = scroller.y + 1  --scroll with cursor

        else
            cursorIndex = #textContent
        end
    end

    if isKeyHeldOrTapped("tab") then
        textContent = textContent:sub(1, cursorIndex - 1) .. "    " .. textContent:sub(cursorIndex)
        cursorIndex = cursorIndex + 4
    end

    --Has error
    -- Handle Ctrl + X (Cut operation)

    

    -- Handle space and period
    if isKeyHeldOrTapped("space") then
        textContent = textContent:sub(1, cursorIndex - 1) .. " " .. textContent:sub(cursorIndex)
        cursorIndex = cursorIndex + 1
    end



    -- Handle return/enter (new line)
    if isKeyHeldOrTapped("return") then
        textContent = textContent:sub(1, cursorIndex - 1) .. "\n" .. textContent:sub(cursorIndex)
        cursorIndex = cursorIndex + 1

    end

    -- Insert numbers
    for i = 1, #numbers do
        if isKeyHeldOrTapped(numbers[i]) then
            -- Check if Shift key is held down
            if (love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift")) then
                -- Insert the corresponding symbol for the number key
                textContent = textContent:sub(1, cursorIndex - 1) .. shiftSymbols[i] .. textContent:sub(cursorIndex)
                cursorIndex = cursorIndex + 1
            else
                -- Insert the number as normal
                textContent = textContent:sub(1, cursorIndex - 1) .. numbers[i] .. textContent:sub(cursorIndex)
                cursorIndex = cursorIndex + 1
            end
        end

        if isKeyHeldOrTapped("kp" .. numbers[i]) then

            if (love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift")) then
                textContent = textContent:sub(1, cursorIndex - 1) .. numpadShiftSymbols[i] .. textContent:sub(cursorIndex)
                cursorIndex = cursorIndex + 1
            else
                -- Insert the numpad number as normal
                textContent = textContent:sub(1, cursorIndex - 1) .. numbers[i] .. textContent:sub(cursorIndex)
                cursorIndex = cursorIndex + 1
            end
        end

    end

    for i = 1, #keypadSymbols do
        if isKeyHeldOrTapped("kp"..keypadSymbols[i]) then
            textContent = textContent:sub(1, cursorIndex - 1) .. keypadSymbols[i] .. textContent:sub(cursorIndex)
            cursorIndex = cursorIndex + 1
        end
    end

    if isKeyHeldOrTapped("kpenter") then
        textContent = textContent:sub(1, cursorIndex - 1) .. "\n" .. textContent:sub(cursorIndex)
        cursorIndex = cursorIndex + 1

        -----------resets screenShake word drop to the left side if you skip line--------------



        -----------------------------------------------------------------------------------------
    end

    --I'm going insane HAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAH!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!






    -----------Screen shake effects-----------
    for i,v in ipairs(textEffects) do

        if v.y<love.graphics.getHeight() then
            love.graphics.print(v.str, v.x, v.y)   
            --speed lines
            


            love.graphics.line(500,0,540,40)
            love.graphics.line(love.graphics.getWidth(),0,love.graphics.getWidth()-40,40)
            love.graphics.line(500,love.graphics.getHeight(),540,love.graphics.getHeight()-40)
            love.graphics.line(love.graphics.getWidth(),love.graphics.getHeight(),love.graphics.getWidth()-40,love.graphics.getHeight()-40)
        end
    end

    for i,v in pairs(textEffects) do 

        if v.y<love.graphics.getHeight() then
            v.y = v.y + 10
            v.x = UI.x + 570 - math.floor(scroller.x / 10) + listWordPos*5
        end
    end
    --to get listWordPos is super tedious. Coz we have to accout for every text input & I'm too lazy for that.
    --------------------------------------------

    



    -- Combine textContent with cursor placeholder
    local textWithCursor = textContent:sub(1, cursorIndex - 1)  .. utf8.char(182) .. textContent:sub(cursorIndex)

    -- Display the updated text with the cursor as part of the string
    love.graphics.print(textWithCursor, UI.x + 570 - math.floor(scroller.x / 10), UI.y - 22 - scroller.y * 15)

    -- Draw the cursor as a vertical line (for better representation)





end


-----------
function buffer()
    
end