#!/usr/bin/env php
<?php
function run($code) {
    $cells = array_fill(0, 30000, 0);
    $cellPtr = 0;
    $codePtr = 0;

    $startTime = microtime(true);

    $stack = [];
    $jumps = [];
    for ($i = 0; $i < strlen($code); $i++) {
        if ($code[$i] === '[') $stack[] = $i;
        if ($code[$i] === ']') {
            $start = array_pop($stack);
            $jumps[$start] = $i;
            $jumps[$i] = $start;
        }
    }

    // Interpreter Loop
    while ($codePtr < strlen($code)) {
        $instruction = $code[$codePtr];

        switch ($instruction) {
            case '>': $cellPtr++; break;
            case '<': $cellPtr--; break;
            case '+': $cells[$cellPtr] = ($cells[$cellPtr] + 1) & 0xFF; break;
            case '-': $cells[$cellPtr] = ($cells[$cellPtr] - 1) & 0xFF; break;
            case '.': echo chr($cells[$cellPtr]); break;
            case ',': /* Input not implemented for this POC */ break;
            case '[':
                if ($cells[$cellPtr] === 0) $codePtr = $jumps[$codePtr];
                break;
            case ']':
                if ($cells[$cellPtr] !== 0) $codePtr = $jumps[$codePtr];
                break;
        }
        $codePtr++;
    }

    $endTime = microtime(true);
    $duration = number_format(($endTime - $startTime) * 1000, 4);

    echo "Execution time: {$duration} ms\n";
}

run(file_get_contents($argv[1]));
