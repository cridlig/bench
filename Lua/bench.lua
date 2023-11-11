-- require "benchmark"

-- GC.disable

-- time = Benchmark.realtime do
    
num_rows = 100000
num_cols = 10
count = 0
xx = string.rep("x", 1000)

function shell(command)
    local handle = io.popen(command)
    local result = handle:read("*a")
    handle:close()
    return result
end

local unistd = require 'posix.unistd'

function rss()
    print(tonumber(shell("ps -o rss= -p " .. unistd.getpid())) // 1024 .. " MB")
end

function gen()
    count = count+1
    return count .. xx
end

function init(size, generator)
    local array = {}
    for i=1,size do
        array[i] = generator()
    end
   
    return array
end

function map(array, func)
    local new_array = {}
    for i,v in ipairs(array) do
      new_array[i] = func(v)
    end
    return new_array
end

function makeCSV()
    local data = init(num_rows, function (row) return init(num_cols, gen) end)
    print(count)
    local csv = table.concat(map(data, function (row) return table.concat(row, ",") end), "\n")
    rss()
    return csv
end
    
for i=1,10 do
    print("iteration " .. i)
    print(#(makeCSV()))
end

-- print time.round(2)
