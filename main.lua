require('UIFolder.Scrollbar')
require('UIFolder.UI')
require('UIFolder.UIColourActivity')
require('FileStuff')
require('UIFolder.UIFileActivity')
require('UIFolder.UIEditActivity')
require('UIFolder.UIRain')
require('UIFolder.UIFileSubmenuActivity')
require('typewritereffect')
require('searchText')
require('UIFolder.Preferences')
require('replaceText')
require('MoveCursor')
require('EnlargeWindow')
require('shaders')
require('autocomplete')
require('colorWheel')
require('DrawSomeCool')


mx,my = 0
regularFont=""
fontMonospace=""

---------------------------------

function love.load()
    love.window.setMode(500, 600, {resizable=false})

    white = {1,1,1}
    black = {0,0,0}
    img = love.graphics.newImage("image/Stars.png")
    img2 = love.graphics.newImage("image/light.png")

    fontregular = love.graphics.newFont("noto-sans.regular.ttf")
    fontboldItalic = love.graphics.newFont("noto-sans.bold-italic.ttf")
    fontbold = love.graphics.newFont("noto-sans.bold.ttf")
    fontItalic = love.graphics.newFont("noto-sans.italic.ttf")
    fontMonospace = love.graphics.newFont("CourierPrime-Regular.ttf")

    correctImg = love.graphics.newImage("image/correct.png")
    undoImg = love.graphics.newImage("image/Undo.png")
    
    sr1 = love.audio.newSource("SoundEffectClick.mp3","static")

    LoadPreferences()
    LoadTrie()
    LoadShader() --IS LAST load function
end




------------------------------------
mousePixTable = {}

function CreatePixel()
    
    local mousePix = {
        x = love.mouse.getX(),
        y = love.mouse.getY()
    }

    table.insert(mousePixTable,mousePix)
end

function DrawScreen()

    love.graphics.setFont(fontregular)

    if love.mouse.isDown(1) then
        CreatePixel()
    end

    for i,v in ipairs(mousePixTable) do
        love.graphics.points(v.x,v.y)
    end

end


local utf8 = require('utf8')
function love.draw()
    love.graphics.setBackgroundColor(white)

    Parser()


    DrawUI()
    UIActivity()
    HeaderText()
--/home/davidnjihia/Downloads/Text-App---Copy-main/main.lua

    if mode == 1 then
        AllowEditTextFileName()
    elseif mode == 2 then

        AllowEditTextContent()
    end



    FileSubmenu()
    DisplaySave() 
    DrawTypedoutText()
    CreateVar() -- replaceText.lua
    DrawCursor()

    
    
    DrawTrie()--autocomplete

    
    DrawPreferences()
    DrawScreen()
    
    DrawShader() -- IS LAST draw function
end




----------------------------------
function love.update(dt)
    mx,my = love.mouse.getPosition()
    FileSubmenu()
    MoveCursor()
    CreateVar()
    UpdateTypedOutText(dt)
    CloseWindow()
    EnlargeWindow()
    
end




-----------------------------------
startClosingWindow = false 
local moveSpeed = 15 
------------------------------------
function love.keypressed(key)

    if key == "escape" then
        startClosingWindow = true
    end



end


----animate closing window
function CloseWindow()
    
    if startClosingWindow then

        local x,y = love.window.getPosition()

        if y < 1000 then
            love.window.setPosition(x, y+moveSpeed)
        else
            love.event.quit()
        end
    end

end
-------------------------------------