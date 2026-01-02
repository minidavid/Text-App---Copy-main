
local width,height = 500,600

function EnlargeWindow()

        if mx>450 and
        width < 600 then
                width = 1300
                love.window.setMode(width, height, {resizable=false})
        end
        

        
end