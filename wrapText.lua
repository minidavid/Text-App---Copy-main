function wrapText(text, width)
    width = width or 79
    local lines = {}
    local line_start = 1

    while line_start <= #text do
        local line_end = line_start + width - 1

        if line_end >= #text then
            table.insert(lines, text:sub(line_start))
            break
        end


        local breakpoint
        for i = line_end,line_start,-1  do
            if text:sub(i, i):match("%s+") then
                breakpoint = i
                break
            end
        end

        if breakpoint then
            table.insert(lines, text:sub(line_start, breakpoint - 1))
            line_start = breakpoint + 1
        else
            table.insert(lines, text:sub(line_start, line_end))
            line_start = line_end + 1
        end
    end

    return table.concat(lines, "\n")
end