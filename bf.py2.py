import sys

def run(code):
    cells = [0] * 30000
    cell_ptr = 0
    code_ptr = 0

    stack = []
    jumps = {}
    for i in range(len(code)):
        if code[i] == '[':
            stack.append(i)
        elif code[i] == ']':
            assert(len(stack) > 0)
            start = stack.pop()
            jumps[start] = i
            jumps[i] = start
    if len(stack) != 0:
         print("unmatched jumps")
         exit(1)

    # Interpreter Loop
    while code_ptr < len(code):
        instruction = code[code_ptr]

        if instruction == '>':
            cell_ptr += 1
            if cell_ptr >= len(cells):
                print("tape oob")
                exit(1)
        elif instruction == '<':
            cell_ptr -= 1
        elif instruction == '+':
            cells[cell_ptr] = (cells[cell_ptr] + 1) % 256
        elif instruction == '-':
            cells[cell_ptr] = (cells[cell_ptr] - 1) % 256
        elif instruction == '.':
            sys.stdout.write(chr(cells[cell_ptr]))
            sys.stdout.flush()
        elif instruction == ',':
            pass
        elif instruction == '[':
            if cells[cell_ptr] == 0:
                code_ptr = jumps[code_ptr]
        elif instruction == ']':
            if cells[cell_ptr] != 0:
                code_ptr = jumps[code_ptr]
        code_ptr += 1

progfile = "cellsize.bf"

if __name__ == "__main__":
    run( open(progfile).read() )
