enum Term: Printable 
{
	case Variable(String)
	case Abstraction(String, Box<Term>)
	case Application(Box<Term>, Box<Term>)

	var description: String {
		switch self {
		case let Variable(symbol):
			return symbol
		case let Abstraction(symbol, body):
			return "λ\(symbol).\(body.value.description)"
		case let Application(x, y):
			return "(\(x.value.description) \(y.value.description))"
		}
	}
}


let symbol = %("a"..."z")


typealias X = Parser<[Int], Int>.Function
typealias P = Parser<String, Term>.Function
typealias T = Parser<String, (Term, Term)>.Function

let term: P = fix { (term: P) -> P in

	let variable: P = 
        symbol |> map { Term.Variable($0) }
        
	let abstraction: P = 
        ignore("λ") ++ symbol ++ ignore(".") ++ term 
        |> map { Term.Abstraction($0, Box($1)) }
        
	let parenthesized: T = 
        ignore("(") ++ term ++ ignore(" ") ++ term ++ ignore(")")
        
	let application: P = 
        parenthesized |> map 
            {   (function: Term, argument: Term) -> Term in
            
                Term.Application(Box(function), Box(argument))
            }
               
	return variable | abstraction | application
}

let a = parse(term, "λx.(x x)").right!.description
let b = parse(term, "(λx.(x x) λx.(x x))").right!.description
