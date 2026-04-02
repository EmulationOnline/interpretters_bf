#!/usr/bin/env ruby

def run(code)
    cells = Array.new(30000, 0)
    cell_ptr = 0
    code_ptr = 0

    start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    stack = []
    jumps = {}

    code.each_char.with_index do |char, i|
        if char == '['
            stack.push(i)
        elsif char == ']'
            start_idx = stack.pop
            jumps[start_idx] = i
            jumps[i] = start_idx
        end
    end

    # Interpreter Loop
    while code_ptr < code.length
        instruction = code[code_ptr]

        case instruction
        when '>'
            cell_ptr += 1
            # Grow cells array if needed
            if cell_ptr >= cells.length then
                puts('oob')
                exit(1)
            end
        when '<'
            cell_ptr = [0, cell_ptr - 1].max # Clamp cell_ptr at 0
        when '+'
            cells[cell_ptr] = (cells[cell_ptr] + 1) % 256
        when '-'
            cells[cell_ptr] = (cells[cell_ptr] - 1) % 256
        when '.'
            print cells[cell_ptr].chr
        when ','
            # Input not implemented for this POC
        when '['
            if cells[cell_ptr] == 0
                code_ptr = jumps[code_ptr]
            end
        when ']'
            if cells[cell_ptr] != 0
                code_ptr = jumps[code_ptr]
            end
        end
        code_ptr += 1
    end

    end_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    duration = (end_time - start_time) * 1000 # Convert to milliseconds

    puts "\nExecution time: #{'%.4f' % duration} ms"
end

progfile = "cellsize.bf"

run( IO.read(progfile) )
