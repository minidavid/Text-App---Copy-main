
--replace the placeholder [name] with replacementText
function ReplaceText(wholeText, pattermatcher, replacementText)

    local replacedText = string.gsub(wholeText, pattermatcher, replacementText)
    

    --love.graphics.print(replacedText,100,420)

end


function ReplaceHexToRGB(hex)
    hex = hex:gsub("#", "")
    local r = tonumber("0x" .. hex:sub(1, 2)) / 255
    local g = tonumber("0x" .. hex:sub(3, 4)) / 255
    local b = tonumber("0x" .. hex:sub(5, 6)) / 255
    love.graphics.print(r.." "..g.." "..b,0,100)
end


----------------------
function CreateVar()
    SearchText(textContent,"cool",1, UI.x,510)
    ReplaceText(textContent,"ey","Hi")

    --ReplaceHexToRGB()

end