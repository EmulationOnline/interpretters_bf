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

echo all
hyperfine --warmup 2 \
	'luajit bf.lua' 'ruby --jit bf.rb' 'nodejs bf.js'\
	'php bf.php' 'python3 bf.py' 'ruby bf.rb' \
	'lua5.4 bf.lua' 'lua5.3 bf.lua' 'lua5.2 bf.lua' 'lua5.1 bf.lua' 'lua5.5 bf.lua' \

# bf.yjit.rb
# bf.py2.py
