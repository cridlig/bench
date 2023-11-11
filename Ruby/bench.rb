require "benchmark"

#GC.disable

time = Benchmark.realtime do
    
    $num_rows = 100000
    $num_cols = 10
    $count = 0
    $xx = "x"*1000

    puts "%d MB" % (`ps -o rss= -p #{Process.pid}`.to_i/1024)
    
    def gen
        $count+=1
        return $count.to_s + $xx
    end

    def makeCSV
        data = Array.new($num_rows) { Array.new($num_cols) { gen } }
        puts $count
        csv = data.map { |row| row.join(",") }.join("\n")
        puts "%d MB" % (`ps -o rss= -p #{Process.pid}`.to_i/1024)
        return csv
    end
    
    for i in 1..10
#    say "iteration " . $i;
        puts makeCSV.length
    end

end

puts time.round(2)
