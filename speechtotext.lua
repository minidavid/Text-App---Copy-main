function LoadSpeechToText()
    handle = io.popen("python3 -u vosk-api-master/python/example/test_microphone.py")
end

local spokenText = "A"

function DrawSpeechToText()
    love.graphics.print(spokenText,100,100)

end

function UpdateCaptions(dt)
    if handle then
        local line = handle:read("*l")
        if line and line ~= "" then
            local text = line:match('"text"%s*:%s*"([^"]+)"')
            if text and text ~= "" then

                if text:find("keyboard", 1, true) then
                    spokenText = "eh?"
                else
                    spokenText = text
                end

            end
        end
    end
end


local lastProcessedLine = nil

function UpdateSpeechToText(dt)

    -- Only continue if tag exists
    if not textContent:find("%[speechtotext%]") then
        return ""
    end

    if not handle then
        return ""
    end

    local line = handle:read("*l")
    if not line or line == "" or line == lastProcessedLine then
        return ""
    end

    lastProcessedLine = line

    local text = line:match('"text"%s*:%s*"([^"]+)"')
    if not text or text == "" then
        return ""
    end

    if text:find("keyboard", 1, true) then
        spokenText = "eh?"
        return ""
    end

    -- if text:find("community") then

    --     local threshold = "~"

    --     if cursorIndex>1 then
    --             local byte = string.byte(textContent,cursorIndex-1)

    --             if byte and byte > 126 then
    --                 textContent = textContent:sub(1,cursorIndex-10)..textContent:sub(cursorIndex)
    --                 cursorIndex = cursorIndex - 1
    --             end
    --     end
    --     return ""
    -- end
    

    spokenText = text

    -- Build new string ONCE
    local before = textContent:sub(1, cursorIndex - 1)
    local after  = textContent:sub(cursorIndex)

    textContent = before .. " " .. spokenText .. " " .. after

    cursorIndex = #textContent

    return ""
end