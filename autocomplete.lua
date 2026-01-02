require('myWordList')

Trie = {}

function Trie:new()
    local obj = { root = {} }  -- Fix: Correctly initialize the root
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Trie:insert(word)
    local node = self.root
    for char in word:gmatch(".") do
        if not node[char] then
            node[char] = {}  -- Create new node if it doesn't exist
        end
        node = node[char]  -- Move to the next node
    end
    node.isWord = true  -- Mark the end of a word
end


function Trie:autocomplete(prefix)
    local node = self.root
    for char in prefix:gmatch(".") do  -- Fix: Use 'prefix', not 'word'
        if not node[char] then
            return {}  -- If prefix doesn't exist, return empty list
        end
        node = node[char]
    end

    local results = {}
    self:_collect(node, prefix, results)
    return results
end

function Trie:_collect(node, prefix, results)
    if node.isWord then
        table.insert(results, prefix)  -- Store the full word
    end

    for char, child in pairs(node) do
        if char ~= "isWord" then
            self:_collect(child, prefix .. char, results)  -- Fix recursive call
        end
    end
end







-- Load words into the Trie
function LoadTrie()
    trie = Trie:new()

    

    local word = {}
    for word in wordList:gmatch("%S+") do
        trie:insert(word)
    end
 
    

    
end

--draw suggestions
function DrawTrie()

    if not startClosingWindow then
        
        love.graphics.print("Autocomplete Suggestions:", love.graphics.getWidth()-mx/6, 10)

        -- Get the last word from textContent
        local lastWord = textContent:match("(%S+)$") or ""  -- Extract last word

        -- Get suggestions for the last word
        local suggestions = trie:autocomplete(lastWord)
        
        -- Display suggestions
        for i, word in ipairs(suggestions) do


            love.graphics.print(word, love.graphics.getWidth()-mx/20, 30 + (i * 20))


            -- If Shift is held, autocomplete with the first suggestion
            if (love.keyboard.isDown("lalt")) and i == 1 then
                textContent = textContent:gsub("%S+$", word)  -- Replace last word
                cursorIndex = #textContent + 1
                
            
            end
            
        end

        
    end
end
