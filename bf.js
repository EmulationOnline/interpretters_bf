#!/usr/bin/env node

function run(code) {
    const cells = new Uint8Array(30000);
    let cellPtr = 0;
    let codePtr = 0;
    let output = "";

    const startTime = performance.now();

    const stack = [];
    const jumps = {};
    for (let i = 0; i < code.length; i++) {
        if (code[i] === '[') stack.push(i);
        if (code[i] === ']') {
            const start = stack.pop();
            jumps[start] = i;
            jumps[i] = start;
        }
    }

    // Interpreter Loop
    while (codePtr < code.length) {
        const instruction = code[codePtr];

        switch (instruction) {
            case '>': cellPtr++; break;
            case '<': cellPtr--; break;
            case '+': cells[cellPtr]++; break;
            case '-': cells[cellPtr]--; break;
            case '.': process.stdout.write(String.fromCharCode(cells[cellPtr])); break;
            case ',': /* Input not implemented for this POC */ break;
            case '[':
                if (cells[cellPtr] === 0) codePtr = jumps[codePtr];
                break;
            case ']':
                if (cells[cellPtr] !== 0) codePtr = jumps[codePtr];
                break;
        }
        codePtr++;
    }

    const endTime = performance.now();
    const duration = (endTime - startTime).toFixed(4);

    console.log(`Execution time: ${duration} ms`);
}

const fs = require('fs');
const code = fs.readFileSync(process.argv[2], 'utf8');

run(code);
