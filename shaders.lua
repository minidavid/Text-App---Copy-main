local myShader --may delete this code later 
local myColor = 1


function LoadShader()
    myShader = love.graphics.newShader([[
        extern float time;
        extern float myColor;
        
        // Vertex shader
        vec4 position(mat4 transform_projection, vec4 vertex_position)
        {
            float scale = 1.0 + 0.5 * sin(time);
            vertex_position.x -= scale + abs(sin(time));
            vertex_position.y -= 0+scale+abs(cos(time));
            return transform_projection * vertex_position;
        }
        
        // Fragment shader
        vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
        {
            float r, g, b;
            float cool = texture_coords.x;

                r = myColor;
                g = time;
                b = 0;
            float c = abs(sin(time));
            return vec4(c, c, r/2+c, 1.0);
        }
    ]])
end



function DrawShader()

    love.graphics.setShader(myShader)
    love.graphics.rectangle("fill",10,40,200,3)


    --SearchText()
    love.graphics.setShader()
    myShader:send("time",love.timer.getTime())
    myShader:send("myColor",myColor)

    GetmyColorValue()

    --love.graphics.print(myColor)
end


--the value is derived from the color swap
function GetmyColorValue()

    if color == 1 then
        myColor = 0.9
    else
        myColor = 0.3
    end

end