//: Playground - noun: a place where people can play

import Prelude
import Madness

let digit = %("0"..."9")
let lower = %("a"..."z")
let upper = %("A"..."Z")
let leftBrace = "{"
let rightBrace = "}"
let space = " "
let linefeed = "\n"
 
let alphaNumeric = (lower | upper | digit)+ |> map { "".join($0) }
let whitespace = ignore( %space | %linefeed )
let spaces = whitespace+

let token = spaces ++ alphaNumeric+ ++ spaces 
let digraph = %("digraph")

let scopeStart  = spaces ++ %leftBrace ++ spaces 
let scopeEnd    = spaces ++ %rightBrace ++ spaces

let scope = %leftBrace ++ token ++ %rightBrace ++ spaces

let dotParser = digraph ++ token ++ scope

let result = parse(dotParser, "digraph Limore { Hello } ")


let value = result.right
if let v = value {
    "\(v)"
    } else {
 let error = result.left?.description   
}

 
let fullParse = parse(dotParser, dotString).left // finished parsing before end of input

 
