//
//  main.swift
//  Dispatch
//
//  Created by Wess Cope on 02/22/2015.
//  Copyright © 2015 Wess Cope. All rights reserved.
//

// var thread = Thread() {
//     wait(10)


// }

import Darwin 

print("Starting...")

let thread = Thread() {
    sleep(6)
    print("Hello World")

    exit(1)
}


try! thread.join()
