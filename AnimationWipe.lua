--require('UIFolder.UIColourActivity')

----------------SWIPE FOR FILE----------------------------------
local animationFileLines = {
    x = UI.x,
    y = UI.y-10
}

function SwipeForFileAnimationHover()
    --draw animationLines
    for i = animationFileLines.x-4, animationFileLines.x,2 do
        for j = animationFileLines.y, animationFileLines.y+UI.height,2 do
            love.graphics.points(i,j)
        end
    end

    if animationFileLines.x < UI.x-10+UI.width then
        animationFileLines.x = animationFileLines.x + 0.5
    else
        animationFileLines.x = UI.x-10
    end
end

-------------- SWIPE FOR EDIT -------------------------
local animationEditLines = {
    x = UI.x + UI.width,
    y = UI.y-10
}
function SwipeForEditAnimationHover()
    --draw animationLines
    for i = animationEditLines.x-4, animationEditLines.x,2 do
        for j = animationEditLines.y, animationEditLines.y+UI.height,2 do
            love.graphics.points(i,j)
        end
    end

    if animationEditLines.x < UI.x+UI.width - 10 + UI.width then
        animationEditLines.x = animationEditLines.x + 0.5
    else
        animationEditLines.x = UI.x +UI.width-10
    end
end


---------------------SWIPE FOR COLOUR--------------------
--animation window like
local animationColourSwitchLines = {
    x = UI.x-10+UI.width*7,
    y = UI.y-5
}


function SwipeForColourAnimationHover()
    --animation
    for i = animationColourSwitchLines.x-4, animationColourSwitchLines.x,2 do
        for j = animationColourSwitchLines.y,animationColourSwitchLines.y+UI.height,2 do
            love.graphics.points(i,j)
        end
    end
    
    if animationColourSwitchLines.x < UI.x-10+UI.width*7+UI.width then
        animationColourSwitchLines.x = animationColourSwitchLines.x + 0.2
    else
        animationColourSwitchLines.x = UI.x-10+UI.width*7
    end
end