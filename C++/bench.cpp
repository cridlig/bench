// bench.cpp

#include <iostream>
#include <vector>
#include <sstream>
#include <ctime>
#include <unistd.h>

const int num_rows = 100000;
const int num_cols = 10;
int count = 0;
std::string xx(1000, 'x');

void printMemoryUsage() {
    std::cout << (static_cast<int>(system(("ps -o rss= -p " + std::to_string(getpid())).c_str())) / 1024) << " MB" << std::endl;
}

std::string gen() {
    count++;
    return std::to_string(count) + xx;
}

std::string makeCSV() {
    std::vector<std::vector<std::string>> data(num_rows, std::vector<std::string>(num_cols));
    
    for (int i = 0; i < num_rows; ++i) {
        for (int j = 0; j < num_cols; ++j) {
            data[i][j] = gen();
        }
    }
    
    std::cout << count << std::endl;

    std::ostringstream csv;
    for (const auto& row : data) {
        csv << row[0];
        for (int j = 1; j < num_cols; ++j) {
            csv << "," << row[j];
        }
        csv << "\n";
    }

    printMemoryUsage();
    return csv.str();
}

int main() {
    clock_t start_time = clock();

    printMemoryUsage();
    for (int i = 0; i < 10; ++i) {
        std::cout << makeCSV().length() << std::endl;
    }

    clock_t end_time = clock();
    double time = static_cast<double>(end_time - start_time) / CLOCKS_PER_SEC;
    std::cout << "Time: " << time << " seconds" << std::endl;

    return 0;
}
