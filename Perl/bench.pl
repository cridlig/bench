use strict;
use v5.18;
use Time::HiRes qw(time);

my $time_begin = time;

my $num_rows = 100000;
my $num_cols = 10;
my $count = 0;
my $xx = "x" x 1000;
    
printf("%d MB\n", `ps -o rss= -p $$` / 1024);

sub gen {
    $count++;
    return $count . $xx;
}

sub makeCSV {
    my @data = map { [ map { gen } (1..$num_cols) ] } (1..$num_rows);
    say $count;
    my $csv = join("\n", map { join(",", @$_) } @data);
#say $csv;
#end
    printf("%d MB\n", `ps -o rss= -p $$` / 1024);
    return $csv;
}

for my $i (1..10) {
#    say "iteration " . $i;
    say length(makeCSV);
}
    
printf("%.2fs\n", time - $time_begin);
