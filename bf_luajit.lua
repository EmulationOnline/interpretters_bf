#!/usr/bin/env luajit

local function run(code)
    -- Using 0 indexing for consistency with other impls.
    -- Cells initialized to 0 (default for new table elements)
    local cells = {}
    for i = 1, 30000 do
        cells[i] = 0
    end

    local cell_ptr = 0
    local code_ptr = 0

    local start_time = os.clock()

    local stack = {}
    local jumps = {}
    local stack_idx = 0

    for i, instruction in code:gmatch"()([%[%]])" do
        i = i-1
        if instruction == '[' then
            stack_idx = stack_idx + 1
            stack[stack_idx] = i
        else
            local start_idx = stack[stack_idx]
            stack_idx = stack_idx - 1
            jumps[start_idx] = i
            jumps[i] = start_idx
        end
    end

    -- Interpreter Loop
    while code_ptr < #code do
        local instruction = code:sub(code_ptr + 1, code_ptr + 1)

        if instruction == '>' then
            cell_ptr = cell_ptr + 1
        elseif instruction == '<' then
            cell_ptr = math.max(0, cell_ptr - 1)
        elseif instruction == '+' then
            cells[cell_ptr + 1] = (cells[cell_ptr + 1] + 1) % 256
        elseif instruction == '-' then
            cells[cell_ptr + 1] = (cells[cell_ptr + 1] - 1) % 256
        elseif instruction == '.' then
            io.write(string.char(cells[cell_ptr + 1]))
            -- io.flush()
        -- elseif instruction == ',' then
            -- Input not implemented for this POC
        elseif instruction == '[' then
            if cells[cell_ptr + 1] == 0 then
                code_ptr = jumps[code_ptr]
            end
        elseif instruction == ']' then
            if cells[cell_ptr + 1] ~= 0 then
                code_ptr = jumps[code_ptr]
            end
        end
        code_ptr = code_ptr + 1
    end

    local end_time = os.clock()
    local duration = (end_time - start_time) * 1000

    print(string.format("\nExecution time: %.4f ms", duration))
    io.flush()
end

local progfile =
    -- 'hello.bf'
    'cellsize.bf'
    -- 'mandelbrot.bf'

run(io.open(progfile):read"a")
