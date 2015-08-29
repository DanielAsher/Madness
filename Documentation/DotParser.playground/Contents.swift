//: Playground - noun: a place where people can play

import Prelude
import Madness

let digit = %("0"..."9")
let lower = %("a"..."z")
let upper = %("A"..."Z")
let space = " "
let linefeed = "\n"
let leftBrace = "{"
let rightBrace = "}"
let arrow = "->"
 
let alphaNumeric = (lower | upper | digit)+ |> map { "".join($0) }
let whitespace = ignore( %space | %linefeed )
let spaces = whitespace+

let token = spaces ++ alphaNumeric ++ spaces 
let digraph = %("digraph") ++ token |> map { (graph, name) in "\(graph) \(name)" } 
let node = token
let edge = node ++ %arrow ++ node |> map { (source, dest) in "\(source) \(dest.0) \(dest.1)" }

let scope = ignore(%leftBrace) ++ (edge | token) ++ ignore(%rightBrace) ++ spaces*

let dotParser = digraph ++ scope

let output = parse(dotParser, fullDotString)

if let result = output.right {
    "\(result)"
    } else {
 let error = output.left?.description   
}
 
