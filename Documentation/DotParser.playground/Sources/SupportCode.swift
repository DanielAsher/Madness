//
// This file (and all other Swift source files in the Sources directory of this playground) will be precompiled into a framework which is automatically made available to DotParser.playground.
//

import Cocoa

var str = "Hello, playground"

let bundle = NSBundle.mainBundle()

let myFilePath = bundle.pathForResource("SimpleGraph", ofType: "dot")

public var dotString : String = {   
    var error:NSError?
    return String(contentsOfFile:myFilePath!, 
        encoding:NSUTF8StringEncoding, error: &error)! }()