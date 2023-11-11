# bench3.py
# compatible with python 3

from timeit import default_timer as timer
import os

start_time = timer()
    
num_rows = 100000
num_cols = 10
count = 0
xx = "x"*1000

def rss():
    print("%d MB" % (int(os.popen("ps -o rss= -p " + str(os.getpid())).read()) / 1024))
    
def gen():
    global count
    count += 1
    return str(count) + xx

def makeCSV():
    data = [ [ gen() for col in range(num_cols) ] for row in range(num_rows) ]
    print(count)
    csv = "\n".join(map(lambda row: ",".join(row), data))
    rss()
    return csv
    
rss()
for i in range(10):
    print(len(makeCSV()))

print("Time taken: %.2f s" % (timer() - start_time))
