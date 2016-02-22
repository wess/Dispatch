//
//  Threading.swift
//  Dispatch
//
//  Created by Wess Cope on 02/22/2016.
//  Copyright © 2016 Wess Cope. All rights reserved.
//

#if os(Linux)
import Glibc
#else 
import Darwin
#endif

typealias PThreadBlock = () -> ()

class PThread {
    let block:PThreadBlock

    init(block:PThreadBlock) {
        self.block = block
    }
}

private func pthread_exec(context:UnsafeMutablePointer<Void>) -> UnsafeMutablePointer<Void> {
    let unmanaged = Unmanaged<PThread>.fromOpaque(COpaquePointer(context))

    unmanaged.takeUnretainedValue().block()
    unmanaged.release()

    return context 
}

public func Thread(block:PThreadBlock) {
    let holder = Unmanaged.passRetained(PThread(block:block))
    let pointer = UnsafeMutablePointer<Void>(holder.toOpaque())

    #if os(Linux)
    var pthread:pthread_t = 0
    #else 
    var pthread:pthread_t = nil 
    #endif 

    guard pthread_create(&pthread, nil, pthread_exec, pointer) == 0 else {
        print("Create error")
    }

    pthread_detach(pthread)
}