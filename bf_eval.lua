#!/usr/bin/env lua

-- adapted from https://github.com/prapin/LuaBrainFuck/blob/master/brainfuck.lua
local subst = { ["+"] = "v=(v+1)%256 "
    ,["-"] = "v=(v-1)%256 "
    ,[">"] = "i=i+1 "
    ,["<"] = "i=i-1 "
    ,["."] = "w(v) "
    ,[","] = "v=r() "
    ,["["] = "while v~=0 do "
    ,["]"] = "end "
}

local function run(s)
    local maxargs = 30000
    local T = { i=0
        -- Using 0 indexing for consistency with other impls.
        , t = setmetatable({},{__index=function() return 0 end})
        , r = function() return io.read(1):byte() end
        , w = function(c) io.write(string.char(c)) end
        -- Cells initialized to 0 (default for new table elements)
        -- table.create 5.5/luajit only?
        -- table.move, (if <5.3 then create a table, move it, create, move)
        , string.byte( string.rep("\0", maxargs), 1, maxargs ) -- preallocate
        -- should be 30k, but 8k is the limit in 5.1
    }
    local mt = {
        __index = function(t) return t.t[t.i] end
        , __newindex = function(t,k,v) t.t[t.i]=v end
    }
    local bf2luacode = s
        :gsub("[^%+%-<>%.,%[%]]+","")
        -- possibility of using numbers instead of operators?
        -- 6> is equivalent to >>>>>>
        -- this would require running a gsub on each character
        :gsub(".", subst)
    local env = setmetatable(T, mt)
    local Run

    Run = load(bf2luacode, "brainfuck", "t", env)
    if setfenv then -- TODO: buggy, FIX
        setfenv(Run, env)
    end

    Run()
end

run(io.open(arg[1]):read"*a")
