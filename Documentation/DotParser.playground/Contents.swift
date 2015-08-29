//: Playground - noun: a place where people can play

import Cocoa
import Madness
import Prelude

var str = "Hello, playground"

let bundle = NSBundle.mainBundle()

let myFilePath = bundle.pathForResource("SimpleGraph", ofType: "dot")

var dotString : String = {   
    var error:NSError?
    return String(contentsOfFile:myFilePath!, 
                                encoding:NSUTF8StringEncoding, error: &error)! }()
                                
let digit = %("0"..."9")
let lower = %("a"..."z")
let upper = %("A"..."Z")
let space = " "
let linefeed = "\n" 
let whitespace = %space | %linefeed

let alphaNumeric = lower | upper | digit

let token = alphaNumeric+

let digraph = %("digraph")

let a = parse(digraph, dotString).left
//> {reason "finished parsing before end of input", {value 7}, 0 elements}
let p = parse(digraph ++ whitespace+, "digraph  ")
let error = p.left?.description
let value = p.right
"\(value!)"
//let error = p.left?.description

 
