require('myWordList')

showAutocomplete = false -- Preferences changes, main draws

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

        love.graphics.print(
            "Autocomplete Suggestions:",
            love.graphics.getWidth() - mx / 6,
            10
        )

        -- Only look at text BEFORE the cursor
        local beforeCursor = textContent:sub(1, cursorIndex - 1)
        local afterCursor  = textContent:sub(cursorIndex)

        -- Find the word the cursor is currently typing
        local wordStart, wordEnd = beforeCursor:find("(%S+)$")

        local currentWord = ""
        
        if wordStart then
            currentWord = beforeCursor:sub(wordStart, wordEnd)
        end

        -- Get suggestions
        local suggestions = trie:autocomplete(currentWord)

        for i, word in ipairs(suggestions) do
            love.graphics.print(
                word,
                love.graphics.getWidth() - mx / 20,
                30 + (i * 20)
            )

            -- Autocomplete on ALT
            if (love.keyboard.isDown("lalt") or love.keyboard.isDown("ralt")) and i == 1 then
                if wordStart then
                    -- Replace ONLY the word at the cursor
                    textContent =
                        beforeCursor:sub(1, wordStart - 1)
                        .. word
                        .. afterCursor

                    -- Move cursor to end of inserted word
                    cursorIndex = (wordStart - 1) + #word + 1
                end
            end
        end


        
    end
end
