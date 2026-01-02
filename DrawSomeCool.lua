one = [[   
  /|
  _|_
]]
two= [[
  __
  __|
 |___
]]
three=[[
 ___
 ___|
 ___|
]]

four=[[
   /|
 /_|_
    |
]]

five=[[
  ____
 |___
 ____|
]]

six=[[
  ____
 |____
 |____|
]]

seven=[[
 ____
     /
   / 
]]

eight=[[
  _____
 |_____|
 |_____|
]]

nine= [[
  ____
 |____|
          |
]]

zero = [[
   _____
  |        |
  |_____|
]]

numArray = {
    one,two,three,four,five,six,seven,eight,nine,zero
}


function DrawUTF8Art()

    
    for i = 1,#numArray do
        love.graphics.print(numArray[i], i*100,100)
    end
end


