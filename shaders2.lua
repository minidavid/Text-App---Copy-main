local myShader --may delete this code later 
local myColor = 1
local myColor2 = 1
local time

function LoadShader2()
    myShader = love.graphics.newShader([[
        extern float realtime;
        extern float time;
        extern float myColor;
        extern float myColor2;
        
        // Vertex shader
        vec4 position(mat4 transform_projection, vec4 vertex_position)
        {
            float scale = 1.0 + 0.5 * sin(5);
            vertex_position.x -= scale + abs(sin(5));
            vertex_position.y -= 0+scale+abs(cos(5));
            return transform_projection * vertex_position;
        }
        
        // Fragment shader
        vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ) {
            // 'screen_coords' are pixel coordinates, but they count from the bottom up in pixel effects by default
            // For a top-to-bottom gradient, we might use texture_coords (normalized 0-1 from top-left)
            float gradient_amount = texture_coords.y;

            // Define start and end colors

            vec4 start_color = vec4(myColor, myColor, time, 1.0); // Red
            vec4 end_color = vec4(myColor2, myColor2, time, 1.0);   // Blue

            // Interpolate between the two colors
            vec4 pixel_color = mix(start_color, end_color, gradient_amount/((1.8+sin(realtime))));

            return pixel_color;
        }


    ]])
end



function DrawShader2()

    --change color with lightmode/dark mode
    if color == 1 then
        myColor = 1.0
        myColor2 = 0.0
        time = love.timer.getTime()
    else
        myColor = 0.0
        myColor2 = 1.0
        time = 1-love.timer.getTime()
    end

    --draw the shader
    love.graphics.setShader(myShader)
    love.graphics.draw(correctImg,0,40,0,2,2)

    love.graphics.setShader()

    myShader:send("time",time)
    myShader:send("realtime",love.timer.getTime())

    myShader:send("myColor",myColor)
    myShader:send("myColor2",myColor2)


end
