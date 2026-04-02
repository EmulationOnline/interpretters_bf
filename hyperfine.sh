#!/bin/sh

# bf.cc

# echo JIT versions
# hyperfine \
	# 'luajit bf.lua'\
	# 'ruby --jit bf.rb' 'ruby --mjit bf.rb'\
	# 'nodejs bf.js'

# echo lua versions
# hyperfine \
	# 'lua5.4 bf.lua' 'lua5.3 bf.lua' 'lua5.2 bf.lua' 'lua5.1 bf.lua' 'lua5.5 bf.lua' \

# echo Interpreter version
# hyperfine --warmup 2 \
	# 'php bf.php' 'python3 bf.py' 'ruby bf.rb' \
	# 'lua5.4 bf.lua' 'lua5.3 bf.lua' 'lua5.2 bf.lua' 'lua5.1 bf.lua' 'lua5.5 bf.lua' \

# echo all
# hyperfine --runs 1 \
	# 'luajit bf.lua' 'ruby --jit bf.rb' 'nodejs bf.js'\
	# 'php bf.php' 'python3 bf.py' 'ruby bf.rb' \
	# 'lua5.4 bf.lua' 'lua5.3 bf.lua' 'lua5.2 bf.lua' 'lua5.1 bf.lua' 'lua5.5 bf.lua' \

# echo most
# # hyperfine -N --runs 1\
# hyperfine -N\
	# 'luajit bf.lua cellsize.bf' 'nodejs bf.js cellsize.bf' 'php bf.php cellsize.bf' 'python3 bf.py cellsize.bf' 'ruby bf.rb cellsize.bf' \
	# 'lua5.1 bf.lua cellsize.bf' 'lua5.2 bf.lua cellsize.bf' 'lua5.3 bf.lua cellsize.bf' 'lua5.4 bf.lua cellsize.bf' 'lua5.5 bf.lua cellsize.bf'\
	# 'luajit bf_eval.lua cellsize.bf' 'lua5.2 bf_eval.lua cellsize.bf' 'lua5.3 bf_eval.lua cellsize.bf' 'lua5.4 bf_eval.lua cellsize.bf' 'lua5.5 bf_eval.lua cellsize.bf'

echo mandelbrot
hyperfine -N --runs 1\
	'luajit bf.lua mandelbrot.bf' 'nodejs bf.js mandelbrot.bf' 'php bf.php mandelbrot.bf' 'python3 bf.py mandelbrot.bf' 'ruby bf.rb mandelbrot.bf' \
	'lua5.1 bf.lua mandelbrot.bf' 'lua5.2 bf.lua mandelbrot.bf' 'lua5.3 bf.lua mandelbrot.bf' 'lua5.4 bf.lua mandelbrot.bf' 'lua5.5 bf.lua mandelbrot.bf'\
	'luajit bf_eval.lua mandelbrot.bf' 'lua5.2 bf_eval.lua mandelbrot.bf' 'lua5.3 bf_eval.lua mandelbrot.bf' 'lua5.4 bf_eval.lua mandelbrot.bf' 'lua5.5 bf_eval.lua mandelbrot.bf'
# bf.yjit.rb
# bf.py2.py

