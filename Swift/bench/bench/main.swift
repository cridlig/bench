//
//  main.swift
//  bench
//
//  Created by Regis Cridlig on 4/26/16.
//  Copyright © 2016 Regis Cridlig. All rights reserved.
//

import Foundation

/*extension String {
    var length: Int {
        return characters.count
    }
}
*/
extension Array {
    init(count size : Int, generator : (Int) -> Element) {
       /* self.init()
        for i in 0 ..< size {
            self.append(generator(i))
        }*/
   
        let array = Array<Int>(repeating: 0, count: size)
        self = array.map(generator)
    }
}

func rss() {
    let task = Process()
    task.launchPath = "/bin/sh"
    print("pid=" + String(getpid()))
    task.arguments = ["-c", "echo $(expr `ps -o rss= -p " + String(getpid()) + "` / 1024) MB"]
    task.launch()
    task.waitUntilExit()
}

let time_begin = Date()

let num_rows = 100000
let num_cols = 10
var counter = 0

let x : Character = "x"
let xx = String.init(repeating: String(x), count: 1000)

rss()

func gen(_ : Int) -> String {
    counter += 1
    return String(counter) + xx
}

func makeCSV()  -> String {
    let data = Array.init(count: num_rows, generator: { _ in Array.init(count: num_cols, generator: gen) })
    print(counter)
    let csv = data.map({ row in row.joined(separator: ",") }).joined(separator: "\n")
    rss()
    return csv
}

for _ in 1...10 {
    print(makeCSV().count)
}

print(String(format: "%.2f", Date().timeIntervalSince(time_begin)))


