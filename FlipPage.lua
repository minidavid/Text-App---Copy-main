local canvas
local font

local text

local page = {
    SPEED = 0.01, 
    dir = nil,
    s = 0.0,
    count = 1
}


function love.load()
    img = love.graphics.newImage("images/paper.jpeg")
   font = love.graphics.newFont(16)

    text = "Hello LÖVE"
    local w = font:getWidth(text)
    local h = font:getHeight()

    canvas = love.graphics.newCanvas(w, h)

    love.graphics.setCanvas(canvas)
    love.graphics.clear(0, 0, 0, 0)
    love.graphics.setFont(font)
    love.graphics.setColor(0, 0, 0)
    love.graphics.print(text, 0, 0)
    
    love.graphics.setCanvas()

    -- transform (center on screen)
    img_tf = love.math.newTransform(
        400 - w / 2,
        300 - h / 2
    )

    img_size = { w, h }
end


function love.update(dt)

    love.graphics.setCanvas(canvas)
    love.graphics.clear(0, 0, 0, 0)
    love.graphics.print(text, 0, 0)
    love.graphics.setCanvas()


    if page.dir then
         page.s = page.s + page.SPEED * page.dir 
        if page.s <= 0.0 then 
            page.s = 0.0 page.dir = nil 
        elseif page.s >= 1.0 then 
            page.s = 1.0 page.dir = nil 
        end 
    end

    if love.keyboard.isDown('left') then 
        page.s = page.s + 0.01 
        if page.s >= 1.0 then
            page.s = 1.0 
        end
    end 
    
    if love.keyboard.isDown('right') then 
        page.s = page.s - 0.01 
        if page.s <= 0.0 then 
            page.s = 0.0 
        end 
    end
end


local myShader = love.graphics.newShader(
[[// Angle in radians.
uniform float a;

// Transform that you want the image to be drawn with.
uniform mat4 image_tf;

// Image size in pixels.
uniform vec2 image_size;

vec4 position(mat4 transform_projection, vec4 vertex_position)
{
    float xc = image_size.x / 2.0;
    float yc = image_size.y / 2.0;
    mat4 origin_mat = mat4(1.0, 0.0, 0.0, 0.0,
                           0.0, 1.0, 0.0, 0.0,
                           0.0, 0.0, 1.0, 0.0,
                           -xc, -yc, 0.0, 1.0);

    mat4 rotate_y_mat = mat4( cos(a), 0.0, -sin(a), 0.0,
                                 0.0, 1.0,    0.0, 0.0,
                             -sin(a), 0.0, cos(a), 0.0,
                                 0.0, 0.0,    0.0, 1.0);

    // Setting this to -1.0 will flip the direction of rotation.
    const float ROTATION_SIGN = 1.0;

    // A factor that controls the foreshortening (the perspective effect).
    // Suggested numbers: 500.0, 1000.0, 5000.0, 10000.0 etc.
    const float FORESHORTENING = 400.0;

    // A large number to keep Z coordinates from clipping out of the screen.
    // Try setting this to like 10.0 to see why it'page.s needed.
    const float Z_COMPRESSION = 50000.0;

    mat4 css_projection_mat = mat4(
    1.0, 0.0, 0.0, 0.0,
    0.0, 1.0, 0.0, 0.0,
    0.0, 0.0, 1.0 / Z_COMPRESSION, ROTATION_SIGN / FORESHORTENING,
    0.0, 0.0, 0.0, 1.0);

    mat4 restore_mat = mat4(1.0);
    restore_mat[3] = vec4(xc, yc, 0.0, 1.0);

    vec4 perspective_position = restore_mat * css_projection_mat * rotate_y_mat
                                * origin_mat * vertex_position;
    return transform_projection * image_tf * perspective_position;
}]]
)


function love.draw()
    love.graphics.setShader(myShader)
    myShader:send('a', page.s * math.pi)
    myShader:send('image_tf', img_tf)
    myShader:send('image_size', img_size)

    -- draw the canvas instead of an image
    love.graphics.setColor(1, 1, 0)
    love.graphics.draw(img)
   
    love.graphics.setColor(1, 1, 1)

    if page.s <= 0.5 then
        love.graphics.print("Ooh!",10,10)
    else
        local text = "Cool" 
        local w = font:getWidth(text)

        love.graphics.print("Cool!",150+w,10,0,-1,1)
    end

    love.graphics.setShader()



    love.graphics.print('- Press Space to flip.', 10, 10)

end


function love.keypressed(key)

    if key == 'escape' then
        love.event.quit()

    elseif key == 'space' then
        if not page.dir then
            if page.s > 0.5 then
                page.dir = -1
            else
                page.dir = 1
            end
        else
            page.dir = -page.dir
        end
    end

end