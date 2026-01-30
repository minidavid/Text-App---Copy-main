local utf8 = require('utf8')
require('replaceText')

--this code just uses string.find
function SearchText(content, searchedText, startIndex, xLogPos, yLogPos)
    local yOffset = yLogPos  -- Start printing at y=100
    



    --loop to find all strings in the string
    while true do
        local i, j = string.find(content, searchedText, startIndex)        



        if i then
            love.graphics.print("Found at: " .. i .. " to " .. j, xLogPos, yOffset, 0, 1, 1)

            --love.graphics.print(text,x,y,r,sx,sy,ox,oy)
            yOffset = yOffset + 10  -- Move down to print the next occurrence

            startIndex = j + 1  -- Continue searching after the last found position
        else
            break  -- Exit the loop when no more occurrences are found
        end

    end
    
end

function SearchFirstTimeText(content,searchedText,startIndex)
    return string.find(content, searchedText, startIndex)
end


-----Parser
---How to do it: Call ParseText first
---Call ReplaceParsed Text after
local variables = {}
local variables2 = {}
local variablesSmall = {}


function Parser()
    
    if string.find(textContent,"%[circle%]") then
        DrawCircle(textContent)        
    end

    DrawFont(textContent)
    ChangeFont(textContent)

    ParseText(textContent) 
    ReplaceParsedText(textContent,300,510)

    
    ParseDate(textContent)
    ReplaceParsedDate(textContent,300,510)

    ParseUTF8(textContent)
    ReplaceMathConstants(textContent)

    ParsenumLog(textContent)
    ReplacenumLog(textContent)

    ParsenumHex(textContent)
    ReplacenumHex(textContent)

    ParseSwap(textContent)

    ParseSmall(textContent)
    ReplaceSmall(textContent)

    ParsePlusText(textContent)
    ReplacePlusText(textContent)

    ParsenumAdd(textContent)
    ReplacenumAdd(textContent)

    ParsenumPower(textContent)
    ReplacenumPower(textContent)
    
    ParsenumMinus(textContent)
    ReplacenumMinus(textContent)

    ParsenumMultiply(textContent)
    ReplacenumMultiply(textContent)

    ParsenumDivide(textContent)
    ReplacenumDivide(textContent)
    
    ParsenumMod(textContent)
    ReplacenumMod(textContent)

    ParseMinusText(textContent)
    ReplaceMinusText(textContent)

    ParsenumFactorial(textContent)
    ReplacenumFactorial(textContent)

    sortText()

end

function ParseText(text)

    for name, value in string.gmatch(text, "%[([%w%s%p%d]+) equals ([%w%s%p%d]+)]") do
        variables[name] = value
        --love.graphics.print(value,100)
    end

    if isKeyHeld("backspace") then
        RemoveVariables()
    end

end

function RemoveVariables()
    for name in pairs(variables) do
        variables[name] = nil  -- Remove the variable by setting it to nil
    end

    variablesSmall["small"] = nil
    variablesSmall["SMALL"] = nil
    variablesSmall["large"] = nil

end

local lastPrefixPos = 800
function ReplaceParsedText(text, xLogPos, yLogPos)

    --parser stops at the newline
    local firstNewlinePos = SearchFirstTimeText(textContent, "\n", 1) 

    if firstNewlinePos then
        lastPrefixPos = firstNewlinePos        
    end

    --splice out the text content to two
    local prefix = string.sub(text,1,lastPrefixPos) --the first 10 characters sliced out to have variables
    local toReplace = string.sub(text,lastPrefixPos+1) --the rest of the text


    --read the rest
    for name, value in pairs(variables) do


        --we assign to text replacement
        toReplace = string.gsub(toReplace,  name, value)

    end


    local replacedText = prefix..toReplace

    textContent = replacedText
    --love.graphics.print(text, xLogPos, yLogPos)
    --actually search for [var] & replace text

end


--------------------
---Parse the date

local currentDate = false
function ParseDate(text)


    if not currentDate then

        for _ in string.gmatch(text, "%[date%]") do
            
                local date = os.date("%H:%M:%S \n%A: %d-%m-%Y")
                variables["date"] = date
                currentDate = true
        end

    end

    if isKeyHeld("backspace") then
        RemoveVariables()
    end

end


function ReplaceParsedDate(text)
    local formattedTime = os.date("%H:%M:%S \n%A: %d-%m-%Y")

    if formattedTime then
        text = string.gsub(text, "%[date%]", formattedTime)            
    end

    textContent = text

end

-----------------------
function ParseUTF8(text)

    text = string.gsub(text, "%[utf(%d+)%]", function (codepoint)
        return utf8.char(tonumber(codepoint))
    end)

    textContent = text

end


---------------------------------------------------
require('DrawSomeCool')

function ReplaceMathConstants(text)
    text = string.gsub(text, "%[PI value%]", 3.14159265358979)
    text = string.gsub(text, "%[pi value%]", 3.14159265358979)
    text = string.gsub(text, "%[math.pi%]", 3.14159265358979)
    text = string.gsub(text, "%[eq%]", "=")
    text = string.gsub(text, "%[plus%]", "+")
    text = string.gsub(text, "%[add%]", "+")
    text = string.gsub(text, "%[sub%]", "-")
    text = string.gsub(text, "%[subtract%]", "-")
    text = string.gsub(text, "%[div%]", "/")
    text = string.gsub(text, "%[divide%]", "/")
    text = string.gsub(text, "%[mul%]", "*")
    text = string.gsub(text, "%[multiply%]", "*")
    text = string.gsub(text, "%[tilde%]", "~")
    text = string.gsub(text, "%[tilde%]", "~")
    text = string.gsub(text, "%[mod%]", "%%")
    text = string.gsub(text, "%[modulo%]", "%%")
    text = string.gsub(text, "%[factorial%]", "!")


    --greek letters commonly used
    local greekCommon = {"%[alpha%]","%[beta%]","%[gamma%]","%[delta%]","%[epsilon%]"}

    for i=1,#greekCommon do
        text = string.gsub(text, greekCommon[i], utf8.char(944+i))
    end

    
    text = string.gsub(text, "%[DELTA%]", "Δ")
    text = string.gsub(text, "%[OMEGA%]", "Ω")
    text = string.gsub(text, "%[omega%]", "ω")
    text = string.gsub(text, "%[psi%]", "ψ")
    text = string.gsub(text, "%[phi%]", "φ")
    text = string.gsub(text, "%[sigma%]", "σ")
    text = string.gsub(text, "%[SIGMA%]", "Σ")
    text = string.gsub(text, "%[theta%]", "θ")
    text = string.gsub(text, "%[DIALYTIKA TONOS%]","΅")
    text = string.gsub(text, "%[GAMMA%]","Γ")
    text = string.gsub(text, "%[koppa%]","ϟ")
    text = string.gsub(text, "%[kappa%]","ϰ")
    text = string.gsub(text, "%[san%]","ϻ")
    text = string.gsub(text, "%[pi%]","ϖ")
    text = string.gsub(text, "%[THETA%]","ϑ")
    text = string.gsub(text, "%[xi%]","Ξ")
    text = string.gsub(text, "%[copy%]","⧉")
    text = string.gsub(text, "%[tag%]","⌂")
    text = string.gsub(text, "%[mesh%]","░")
    text = string.gsub(text, "%[squares%]","❖")
    text = string.gsub(text, "%[my cursor fancy%]","❡")
    text = string.gsub(text, "%[D fancy%]","𝔡")
    text = string.gsub(text, "%[diamond%]","⋄")
    text = string.gsub(text, "%[||%]","∥")
    text = string.gsub(text, "%[curved ->%]","↷")
    text = string.gsub(text, "%[curved <-%]","↶")
    text = string.gsub(text, "%[caret%]","⁁")
    text = string.gsub(text, "%[C old%]","ℭ")
    text = string.gsub(text, "%[B old%]","𝔅")
    text = string.gsub(text, "%[b old%]","𝔟")
    text = string.gsub(text, "%[A old%]","𝔄")
    text = string.gsub(text, "%[a old%]","𝔞")
    text = string.gsub(text, "%[black square%]","⬛")
    text = string.gsub(text, "%[white square%]","⬜")
    text = string.gsub(text, "%[black circle%]","⚫")
    text = string.gsub(text, "%[white circle%]","⚪")
    text = string.gsub(text, "%[start%]","⏻")
    text = string.gsub(text, "%[frown%]","⌢")
    text = string.gsub(text, "%[smile%]","⌣")
    text = string.gsub(text, "%[electric%]","⌁")
    text = string.gsub(text, "%[CAPS [a-z%s]+%]", string.upper)
    text = string.gsub(text, "%[caps [%w%s%p%d]+%]", string.upper)
    
    local numArraynames = {"one","two","three","four","five","six","seven","eight","nine","zero"}
    for i=1,10 do
        text = string.gsub(text, "numArraynames[i]", numArray[i])
    end
    
    
    
    
    
    
    
    
     
    
     
    
    

    text = string.gsub(text, "%[HELP%]", "Hi! Welcome to the my help section\nYou may want to check out the documentation on the website on EDIT>HELP.")

    text = string.gsub(text, "%[area of square%]", "A = side^2") --square area
    text = string.gsub(text, "%[area of triangle%]", "A = 1/2 * base^2") --square area
    text = string.gsub(text, "%[area of rectangle%]", "A = width * height") 
    
    text = string.gsub(text, "%[area of circle%]", "A = [PI value] * radius^2") 
    text = string.gsub(text, "%[circumference of circle%]", "A = PI value * diameter")
    
    text = string.gsub(text, "%[volume of cube%]", "V = side^3")
    text = string.gsub(text, "%[surface area of cube%]", "surface area = 6*side^2")
    
    text = string.gsub(text, "%[volume of cuboid%]", "V = width*breadth*height")
    text = string.gsub(text, "%[surface area of cuboid%]", "surface area = 6*width*breadth*height")
    
    text = string.gsub(text, "%[volume of cylinder%]", "V = pi*radius^2*height")

    text = string.gsub(text, "%[volume of cone%]", "V = 1/3*pi*radius^2*height")
    text = string.gsub(text, "%[surface area of cone%]", "V = pi*radius^2*height + pi*radius*length")
    
    text = string.gsub(text, "%[Psalms 23%]", "The Lord is my Shepherd, I shall not want.\nHe makes me lie down in green pastures.\nHe leads me beside still water. He restores my soul.\nHe restores my soul. He leads me in the path of righteousness,\nfor His name's sake. Yea, even though I walk through the valley of shadow of death,\nI will fear no evil. For YOU are with me.\nYour rod and your staff, they comfort me.\nYou prepare a table before me in the presence of my enemies.\nYou anoint my head with oil, my cup overflows.\nSurely, goodness and mercy shall follow us,\nall the days of our lives, and we shall dwell in the house of the LORD.\nForever and ever.\nAmen.")

    text = string.gsub(text, "%[John 3:16%]", "For God so loved the world, that He gave His only begotten son\nthat whoever believes in Him, shall not perish,\nbut have eternal life.")
    text = string.gsub(text, "%[Matthew 6:33%]", "But seek first the Kingdom of God and His righteousness\nand all these things shall be added to you.\nbut have eternal life.")
    text = string.gsub(text, "%[Matthew 28:19%]", "Therefore, go and make disciples,\nbaptizing them in the name of\nThe Father, The Son and The Holy Spirit.")
    text = string.gsub(text, "%[Romans 8:28%]", "And we know that in all things, God works for the good of those who love Him\nwho have been called according to His purpose.")
    text = string.gsub(text, "%[Psalms 91:11%]", "For He will command His angels concerning you\nto guard you in all of His ways.")


    text = string.gsub(text, "%[i%]", 90) --imaginary's number
    text = string.gsub(text, "%[emdash%]", "–")
    text = string.gsub(text, "%[endash%]", "—") 
    text = string.gsub(text, "%[infinity%]", "∞") --euler's number
    
    text = string.gsub(text, "%[E value%]", 2.7182818284) --euler's number
    text = string.gsub(text, "%[euler value%]", 2.7182818284) --euler's number

    text = string.gsub(text, "%[PHI value%]", 1.6180339887) --golden ratio
    text = string.gsub(text, "%[golden ratio%]", 1.6180339887) --golden ratio

    text = string.gsub(text, "%[GAMMA value%]", 0.5772156649) --Euler-Mascheroni
    text = string.gsub(text, "%[euler-mascheroni%]", 0.5772156649) --Euler-Mascheroni
    
    text = string.gsub(text, "%[TAU value%]", 2*22/7) --tau 2*PI
    text = string.gsub(text, "%[c%]",  299792458) --speed of light
    text = string.gsub(text, "%[light speed value%]",  299792458) --speed of light

    text = string.gsub(text, "%[speed limit road%]",  120) --replace this with correct speed


    text = string.gsub(text, "%[G earth%]", 9.80665) --gravity of earth 
    text = string.gsub(text, "%[G earth everest]", 9.764) --gravity of earth everest
    text = string.gsub(text, "%[G earth poles]", 9.8322) --gravity of earth poles

    text = string.gsub(text, "%[G earth poles]", 9.8322) --gravity of earth poles

    
    text = string.gsub(text, "%[G earth equator%]", 9.7803) --gravity of earth for equator

    text = string.gsub(text, "%[G moon%]", 1.625)
    text = string.gsub(text, "%[G mars]", 3.720)
    text = string.gsub(text, "%[G jupiter]", 24.97)


    textContent = text
end





------------
local variablesWordMinus = {}
local letterMinus
local numberMinus

function ParseMinusText(text)
    -- Detect the presence of "[small]" and store a flag
   letterMinus, numberMinus = string.match(text, "%[(%a)%-(%d+)%]")
   
    if letterMinus~="" and letterMinus~=nil and numberMinus~="" and numberMinus~=nil then
        variablesWordMinus[letterMinus] = tonumber(numberMinus)
   end 

    if isKeyHeld("backspace") then
        RemoveVariables()
    end



end

function ReplaceMinusText(text)
    -- Check if the "[small]" tag was detected
    if letterMinus~="" and letterMinus~=nil and numberMinus~="" and numberMinus~=nil then
       
        for letterMinus,numberMinus in pairs(variablesWordMinus) do
            local newLetter = string.char(string.byte(letterMinus) - numberMinus)
           
            if cursorIndex > 1 then
                textContent = textContent:sub(1, cursorIndex - 11) .. textContent:sub(cursorIndex)
                cursorIndex = cursorIndex - 3 - #tostring(numberMinus)
            end

            text = string.gsub(text, "%[" .. letterMinus .. "%-" .. numberMinus .. "%]", newLetter)
        end

        textContent = text
    end


end


-----------
local variablesWord = {}
local letter
local number

function ParsePlusText(text)
    -- Detect the presence of "[small]" and store a flag
   letter, number = string.match(text, "%[(%a)%+(%d+)%]")
   
    if letter~="" and letter~=nil and number~="" and number~=nil then
        variablesWord[letter] = tonumber(number)
   end

end

function ReplacePlusText(text)
    -- Check if the "[small]" tag was detected
    if letter~="" and letter~=nil and number~="" and number~=nil then
       
        for letter,number in pairs(variablesWord) do
            local newLetter = string.char(string.byte(letter) + number)
           
            if cursorIndex > 1
             then
                textContent = textContent:sub(1, cursorIndex - 11) .. textContent:sub(cursorIndex)
                cursorIndex = cursorIndex - 3 - #tostring(number)
            end

            text = string.gsub(text, "%[" .. letter .. "%+" .. number .. "%]", newLetter)
        end

        textContent = text
    end

    love.graphics.print(cursorIndex,100,100)

end

-----------------PROCEED FROM HERE!---------------------------

local variablesnumLog = {}

function ParsenumLog(text)
    local base, num9 = string.match(text, "%[log ([%d%.]+) ([%d%.]+)%]")

    if base~="" and base~=nil and num9~="" and num9~=nil then
        base, num9 = tonumber(base), tonumber(num9)
        table.insert(variablesnumLog, {base = base, num9 = num9})
    end
    
end

function ReplacenumLog(text)
    -- Check if the "[small]" tag was detected
       
        for _,data in ipairs(variablesnumLog) do
            local newLetter = tostring(math.log(data.num9, data.base))

            text = string.gsub(text, "%[log " .. data.base .. " " .. data.num9 .. "%]", newLetter)
        end

        textContent = text

end
------ create a sqrt function later this will get painful

-------------------------

local variablesnumAdd = {}
local num1
local num2

function ParsenumAdd(text)
    num1, num2 = string.match(text, "%[([%-?%d+%.?%d*]+)%+([%-?%d+%.?%d*]+)%]")

    if num1~="" and num1~=nil and num2~="" and num2~=nil then
        variablesnumAdd[num1] = tonumber(num2)
    end
    
end

function ReplacenumAdd(text)
    -- Check if the "[small]" tag was detected
    local replacements

    if num1~="" and num1~=nil and num2~="" and num2~=nil then
       

        for num1,num2 in pairs(variablesnumAdd) do
            local newLetter = tostring(tonumber(num1) + tonumber(num2))
            
            --replace word with newLetter
            local removedLen = #tostring(num1) + #tostring(num2) + 3
            local insertedLen = #newLetter
            local actualLen = removedLen - insertedLen
           
            --for the pattern for negative nums and decimals.
            local safeNum1 = tostring(num1):gsub("%-", "%%-")
            local safeNum2 = tostring(num2):gsub("%-", "%%-")

            local pattern = "%[" .. safeNum1 .. "%+" .. safeNum2 .. "%]"
            local replacements
           
            text, replacements = string.gsub(text, pattern, newLetter)

            ---adjust cursor
            --we have the cursor at the end of the word,
            --else we have it at the start of the word.
            
            local wordStart = cursorIndex - 1
            -- Ensure the wordStart doesn't go below 1
            if wordStart < 2 then
                wordStart = 2
            end

            while wordStart > 2 and not textContent:sub(wordStart, wordStart):match("%s") do
                wordStart = wordStart - 1
            end


            if (cursorIndex - actualLen * replacements) > 2 and not textContent:sub(wordStart, wordStart):match("%[") then
                cursorIndex = cursorIndex - actualLen * replacements
            else
                cursorIndex = wordStart+1
            end

        end



        textContent = text
    end



    --love.graphics.print("actualLen: "..tostring(actualWordLen),100,110)
    --love.graphics.print("cursorI: "..tostring(cursorIndex),100,120)

end
---------------
local variablesnumMinus = {}
local num3
local num4

function ParsenumMinus(text)
    num3, num4 = string.match(text, "%[([%-?%d+%.?%d*]+)%-([%-?%d+%.?%d*]+)%]")

    -- to avoid multiply error. It must not have multiply
    if text:find("[%*%*]") then
        return
    end

    if num3~="" and num3~=nil and num4~="" and num4~=nil then
        variablesnumMinus[num3] = tonumber(num4)
    end
    
end

function ReplacenumMinus(text)
    -- Check if the "[small]" tag was detected
    if num3~="" and num3~=nil and num4~="" and num4~=nil then
       
        for num3,num4 in pairs(variablesnumMinus) do
            local newLetter = tostring(tonumber(num3) - tonumber(num4))
            
            --replace word with newLetter
            local removedLen = #tostring(num3) + #tostring(num4) + 3
            local insertedLen = #newLetter
            local actualLen = removedLen - insertedLen
           
            --for the pattern for negative nums and decimals.
            local safeNum1 = tostring(num3):gsub("%-", "%%-")
            local safeNum2 = tostring(num4):gsub("%-", "%%-")

            local pattern = "%[" .. safeNum1 .. "%-" .. safeNum2 .. "%]"
            local replacements
           
            text, replacements = string.gsub(text, pattern, newLetter)

            ---adjust cursor
            --we have the cursor at the end of the word,
            --else we have it at the start of the word.
            
            local wordStart = cursorIndex - 1
            -- Ensure the wordStart doesn't go below 1
            if wordStart < 2 then
                wordStart = 2
            end

            while wordStart > 2 and not textContent:sub(wordStart, wordStart):match("%s") do
                wordStart = wordStart - 1
            end


            if (cursorIndex - actualLen * replacements) > 2 and not textContent:sub(wordStart, wordStart):match("%[") then
                cursorIndex = cursorIndex - actualLen * replacements
            else
                cursorIndex = wordStart+1
            end


        end


        textContent = text
    end


end
-------------------------
local variablesnumMultiply = {}
local num5
local num6

function ParsenumMultiply(text)
    num5, num6 = string.match(text, "%[(%-?%d+%.?%d*)%*(-?%d+%.?%d*)%]")

    if num5~="" and num5~=nil and num6~="" and num6~=nil then
        --variablesnumMultiply[num5] = tonumber(num6)
        table.insert(variablesnumMultiply, { a = num5, b = num6 })
    end
    
end

function ReplacenumMultiply(text)
    -- Check if the "[small]" tag was detected
    if num5~="" and num5~=nil and num6~="" and num6~=nil then
       
        for _, v in ipairs(variablesnumMultiply) do
            local newLetter = tostring(tonumber(v.a) * tonumber(v.b))
            
            --replace word with newLetter
            local removedLen = #tostring(v.a) + #tostring(v.b) + 3
            local insertedLen = #newLetter
            local actualLen = removedLen - insertedLen
           
            --for the pattern for negative nums and decimals.
            local safeNum1 = tostring(v.a):gsub("%-", "%%-")
            local safeNum2 = tostring(v.b):gsub("%-", "%%-")

            local pattern = "%[" .. safeNum1 .. "%*" .. safeNum2 .. "%]"
            local replacements
           
            text, replacements = string.gsub(text, pattern, newLetter)

            ---adjust cursor
            --we have the cursor at the end of the word,
            --else we have it at the start of the word.
            
            local wordStart = cursorIndex - 1
            -- Ensure the wordStart doesn't go below 1
            if wordStart < 2 then
                wordStart = 2
            end

            while wordStart > 2 and not textContent:sub(wordStart, wordStart):match("%s") do
                wordStart = wordStart - 1
            end


            if (cursorIndex - actualLen * replacements) > 2 and not textContent:sub(wordStart, wordStart):match("%[") then
                cursorIndex = cursorIndex - actualLen * replacements
            else
                cursorIndex = wordStart+1
            end

        end

        textContent = text
    end
end
--------------
local variablesnumDivide = {}
local num7
local num8

function ParsenumDivide(text)
    num7, num8 = string.match(text, "%[(%-?%d+%.?%d*)%/(-?%d+%.?%d*)%]")

    if num7~="" and num7~=nil and num8~="" and num8~=nil then
        --variablesnumDivide[num7] = tonumber(num8)
        table.insert(variablesnumDivide, { a = num7, b = num8 })
    end
    
end

function ReplacenumDivide(text)
    -- Check if the "[small]" tag was detected
    if num7~="" and num7~=nil and num8~="" and num8~=nil then
       
        for _, v in ipairs(variablesnumDivide) do
            local newLetter = tostring(tonumber(v.a) * tonumber(v.b))
            
            --replace word with newLetter
            local removedLen = #tostring(v.a) + #tostring(v.b) + 3
            local insertedLen = #newLetter
            local actualLen = removedLen - insertedLen
           
            --for the pattern for negative nums and decimals.
            local safeNum1 = tostring(v.a):gsub("%-", "%%-")
            local safeNum2 = tostring(v.b):gsub("%-", "%%-")

            local pattern = "%[" .. safeNum1 .. "%/" .. safeNum2 .. "%]"
            local replacements
           
            text, replacements = string.gsub(text, pattern, newLetter)

            ---adjust cursor
            --we have the cursor at the end of the word,
            --else we have it at the start of the word.
            
            local wordStart = cursorIndex - 1
            -- Ensure the wordStart doesn't go below 1
            if wordStart < 2 then
                wordStart = 2
            end

            while wordStart > 2 and not textContent:sub(wordStart, wordStart):match("%s") do
                wordStart = wordStart - 1
            end


            if (cursorIndex - actualLen * replacements) > 2 and not textContent:sub(wordStart, wordStart):match("%[") then
                cursorIndex = cursorIndex - actualLen * replacements
            else
                cursorIndex = wordStart+1
            end

        end

        textContent = text
    end
end

-----factorial
local num9

function ParsenumFactorial(text)
    num9 = string.match(text, "%[(%d+)%!%]")
    if num9~="" and num9~=nil then
        num9 = tonumber(num9)
    end
end

function ReplacenumFactorial(text)


    if num9~="" and num9~=nil then 
       
        local result = 1
        
        num9 = tonumber(num9)

        for i = 2,num9 do
            result = result * i

        end


        text = string.gsub(text, "%[" .. num9 .. "%!%]", tostring(result))
        textContent = text

    end


end

--power
local variablesnumPower = {}
local num10
local num11

function ParsenumPower(text)
    num10, num11 = string.match(text, "%[(%-?%d+%.?%d*)%^(-?%d+%.?%d*)%]")

    if num10~="" and num10~=nil and num11~="" and num11~=nil then
        table.insert(variablesnumPower, { a = num10, b = num11 })
    end
    
end

function ReplacenumPower(text)
    -- Check if the "[small]" tag was detected
    if num10~="" and num10~=nil and num11~="" and num11~=nil then
       
        for _, v in ipairs(variablesnumPower) do
            local newLetter = tostring(tonumber(v.a) ^ tonumber(v.b))
            
            --replace word with newLetter
            local removedLen = #tostring(v.a) + #tostring(v.b) + 3
            local insertedLen = #newLetter
            local actualLen = removedLen - insertedLen
           
            --for the pattern for negative nums and decimals.
            local safeNum1 = tostring(v.a):gsub("%-", "%%-")
            local safeNum2 = tostring(v.b):gsub("%-", "%%-")

            local pattern = "%[" .. safeNum1 .. "%^" .. safeNum2 .. "%]"
            local replacements
           
            text, replacements = string.gsub(text, pattern, newLetter)

            ---adjust cursor
            --we have the cursor at the end of the word,
            --else we have it at the start of the word.
            
            local wordStart = cursorIndex - 1
            -- Ensure the wordStart doesn't go below 1
            if wordStart < 2 then
                wordStart = 2
            end

            while wordStart > 2 and not textContent:sub(wordStart, wordStart):match("%s") do
                wordStart = wordStart - 1
            end


            if (cursorIndex - actualLen * replacements) > 2 and not textContent:sub(wordStart, wordStart):match("%[") then
                cursorIndex = cursorIndex - actualLen * replacements
            else
                cursorIndex = wordStart+1
            end
        end

        textContent = text
    end


end

---check hex to rgb
local num12

function ParsenumHex(text)
    num12 = string.match(text, "%[%#(%x+)%]")
end
---

function ReplacenumHex(text)


    if num12~="" and num12~=nil then 

        if num12:match("^%x%x%x%x%x%x$") then

            ReplaceHexToRGB(num12)

        else

            --print error text
            love.graphics.setColor(0.8,0,0,1)
            
            --adjust grammar for error text
            if ((6-#num12==1) or (6-#num12==-1)) then
                love.graphics.print("Requires 6 Digit Hexadecimal; "..6-#num12.." Character Left -.-",110,520)
            else
                love.graphics.print("Requires 6 Digit Hexadecimal; "..6-#num12.." Characters Left -.-",110,520)
            end

            UIColorSwitch() --reset color

        end
        --text = string.gsub(text, "%[%#" .. num12, tostring(result))
        --textContent = text

    end


end


-----FIX THIS!!!!!------

local someTextT = {} -- Table to store bold segments
local someText = "This is very very [bold]bold text[/bold] in a sentence."  -- Global text storage

function DrawFont(text)
    local i = 1
    local y,x = 10,10

    
    --while i <= #text do
        -- Check for the start of a bold tag
        --if text:sub(i, i + 5) == "[bold]" then
            --love.graphics.setFont(fontbold) -- Switch to bold
            --i = i + 6 -- Skip "[bold]"
        --elseif text:sub(i, i + 6) == "[/bold]" then
            --love.graphics.setFont(fontregular) -- Switch back to regular
            --i = i + 7 -- Skip "[/bold]"
       -- else
            -- Print each character individually
            --love.graphics.print(text:sub(i, i), x, 12) --utf8 error, refuses to parse utf8 characters. Holy guacamole!!!!!!
            --x = x + fontregular:getWidth(text:sub(i, i)) -- Move cursor
            --i = i + 1
        --end
    --end


end


function ChangeFont(text)
   if string.find(text,"%[monospace%]") then
        love.graphics.setFont(fontMonospace)
   elseif string.find(text, "%[italic%]") then
        love.graphics.setFont(fontItalic)
   elseif string.find(text, "%[bold%]") then
        love.graphics.setFont(fontbold)
   else
        love.graphics.setFont(fontregular)
   end

   
end

function DrawCircle(text)
	-- define some variables for the circle, and some text:
	local radius = 80
	local originY = love.graphics.getHeight() / 2
	local originX = love.graphics.getWidth() / 2

	-- get the font
	local font = love.graphics.getFont()

	-- Draw a circle to see how the text is aligned to it:
	love.graphics.circle("line", originX, originY, radius)

	-- this makes it draw on the outside edge of the circle:
	--radius = radius + font:getHeight()

	-- define the rotation for each character. Start at negative half the first character's rotation (explained later)
	local rotation = -calcHalfCharRotation(string.sub(text, 1, 1), font, radius)
    



	-- for each character position
	for charPos = 1, string.len(text) do
		-- get the character at this position
		local char = string.sub(text, charPos, charPos)

		-- get the length of pixels the character will take up
		local length = font:getWidth(char)

		-- add half the arc to the rotation. Since we're drawing at the centre of the character, we only want half the rotation for now.
		-- For the first character, we don't want it rotated at all, so this cancels out the negative half from before the loop.
		rotation = rotation + calcHalfCharRotation(char, font, radius)

        for i = 2,4,1 do
		love.graphics.print(
			char, -- text to print
			originX, -- x position, in this case it's the centre of the circle
			originY, -- y position
			rotation+love.timer.getTime()/2, -- rotation
			nil, -- scale X
			nil, -- scale Y
			length/2, -- x offset, this keeps the letter centred, since half the length puts it in the middle
			i*100 -- y offset, this tells it to draw (radius) pixels away from the centre of the circle
			-- The offset tells it to rotate around the centre of the circle
		)
        end

		-- For the *next* character, we still have to have the rotation of the current character, so add the second half
		rotation = rotation + calcHalfCharRotation(char, font, radius)
	end
end


-- take the amount of space the character takes up, apply arc length formula to find the amount of rotation necesary
-- arc length = radians * radius
-- therefore, to find radians: length / radius = radians
function calcHalfCharRotation(char, font, radius)
	local length = font:getWidth(char) / 2
	local rotation = ((length * 1) / radius) -- the * 1.2 just pads it out and makes it look nicer.
	return rotation
end
    


--------------
local variablesnumMod = {}
local num9
local num10

function ParsenumMod(text)
    num9, num10 = string.match(text, "%[(%-?%d+%.?%d*)%%(-?%d+%.?%d*)%]")

    if num9~="" and num9~=nil and num10~="" and num10~=nil then
        --variablesnumMod[num9] = tonumber(num10)
        table.insert(variablesnumMod, { a = num9, b = num10 })
    end
    
end

function ReplacenumMod(text)
    -- Check if the "[small]" tag was detected
    if num9~="" and num9~=nil and num10~="" and num10~=nil then
       

        for _, v in ipairs(variablesnumMod) do
            local newLetter = tostring(tonumber(v.a) % tonumber(v.b))
            
            --replace word with newLetter
            local removedLen = #tostring(v.a) + #tostring(v.b) + 3
            local insertedLen = #newLetter
            local actualLen = removedLen - insertedLen
           
            --for the pattern for negative nums and decimals.
            local safeNum1 = tostring(v.a):gsub("%-", "%%-")
            local safeNum2 = tostring(v.b):gsub("%-", "%%-")

            local pattern = "%[" .. safeNum1 .. "%%" .. safeNum2 .. "%]"
            local replacements
           
            text, replacements = string.gsub(text, pattern, newLetter)

            ---adjust cursor
            --we have the cursor at the end of the word,
            --else we have it at the start of the word.
            
            local wordStart = cursorIndex - 1
            -- Ensure the wordStart doesn't go below 1
            if wordStart < 2 then
                wordStart = 2
            end

            while wordStart > 2 and not textContent:sub(wordStart, wordStart):match("%s") do
                wordStart = wordStart - 1
            end


            if (cursorIndex - actualLen * replacements) > 2 and not textContent:sub(wordStart, wordStart):match("%[") then
                cursorIndex = cursorIndex - actualLen * replacements
            else
                cursorIndex = wordStart+1
            end

        end

        textContent = text
    end


end

--------------

function ParseSmall(text)
    -- Detect the presence of "[small]" and store a flag
    if string.find(text, "%[smallish]") then
        variablesSmall["smallish"] = true -- Just a flag, no need for name-value pairs
        variablesSmall["caps"] = false -- Just a flag, no need for name-value pairs
    end

    if string.find(text, "%[SMALLISH%]") then
        variablesSmall["SMALL"] = true
        variablesSmall["caps"] = false -- Just a flag, no need for name-value pairs
    end

    if string.find(text, "%[regular]") then
        variablesSmall["caps"] = false -- Just a flag, no need for name-value pairs
        variablesSmall["small"] = false -- Just a flag, no need for name-value pairs
        variablesSmall["SMALLISH"] = false -- Just a flag, no need for name-value pairs
    end

    if string.find(text, "%[REGULAR]") then
        variablesSmall["caps"] = false -- Just a flag, no need for name-value pairs
        variablesSmall["small"] = false -- Just a flag, no need for name-value pairs
        variablesSmall["SMALLISH"] = false -- Just a flag, no need for name-value pairs
    end



    if string.find(text, "%[caps]") then
        variablesSmall["caps"] = true -- Just a flag, no need for name-value pairs
        variablesSmall["small"] = false -- Just a flag, no need for name-value pairs
        variablesSmall["SMALLISH"] = false -- Just a flag, no need for name-value pairs
    end


    if string.find(text, "%[quit]") then
        love.event.push("quit")
    end

    if string.find(text, "%[QUIT%]") then
        love.event.push("quit")
    end

    if string.find(text, "%[restart%]") then
        love.event.push("quit","restart")        
    end

    if string.find(text, "%[RESTART%]") then
        love.event.push("quit","restart")        
    end

    if isKeyHeld("backspace") then
        RemoveVariables()
    end
end


function ReplaceSmall(text)
    -- Check if the "[small]" tag was detected
    if variablesSmall["smallish"] or variablesSmall["SMALLISH"]then
        text = string.lower(text)
    end

    if variablesSmall["caps"] then
        text = string.upper(text)
    end



    textContent = text
end


----swap feature

local lastSwapTime = 0
local swapDuration = 0.01 -- Short swap duration (1 frame)
local swapInterval = 3    -- Long interval between swaps
local runOnce = false

function ParseSwap(text)
    local currentTime = love.timer.getTime()

    -- Reset runOnce every swap interval
    if currentTime - lastSwapTime > swapInterval then
        runOnce = false
        lastSwapTime = currentTime -- Reset swap time
    end

    -- Swap only for a short moment
    if currentTime - lastSwapTime < swapDuration then
        for name, value in string.gmatch(text, "%[(%w+) swap (%w+)]") do
            -- Initialize variables if they don't exist
            variables2[name] = variables2[name] or name
            variables2[value] = variables2[value] or value

            -- Perform swap if not already swapped in this cycle
            if not runOnce then
                variables2[name], variables2[value] = variables2[value], variables2[name]
                runOnce = true
            end

            -- Debugging output
            print(variables2[name].."-"..name..";"..variables2[value].."-"..value)

            -- Ensure text replacement
            if variables2[name] and variables2[value] then
                text = string.gsub(text, name, variables2[name])
            end
            
            textContent = text
        end
    end

    if isKeyHeld("backspace") then
        RemoveVariables()
    end
end


---I don't know how I'd fix this honestly


function sortText()
    

    textContent = textContent:gsub("%b[]", function(bracketedGroup)
        local inner = bracketedGroup:sub(2,-2)

        if inner:match("^sort%s+") then
            local data = inner:gsub("^sort%s+","")
            local items = {}

            for word in data:gmatch("%S+") do
                table.insert(items, tonumber(word) or word)
            end

            table.sort(items, function(a,b)
                if type(a) == type(b) then return 
                    a<b 
                else
                    return tostring(a) < tostring(b)
                end
            end)

            return "[sort ".. table.concat(items, " ").."]"

        end

        return bracketedGroup

    end)

    -- textContent = textContent:gsub("%b[sort ]", function(bracketedGroup)
    --     local content = bracketedGroup:sub(2,-2)
    --     return sortInsideBrackets(content)

    -- end
    -- )

end


function findText()

end


