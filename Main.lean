import LeanTraining

def main (args : List String) : IO Unit := do
  -- En el binario podemos usar todo nuestro código Lean
  let x := LeanTraining.Program.Expr.const 3
  let y := LeanTraining.Program.Expr.const 5
  let expr := LeanTraining.Program.Expr.add x y
  let state := fun _ => 0
  let res := LeanTraining.Semantics.evalExpr state expr

  let name := if args.isEmpty then "World" else args[0]!
  IO.println s!"hello {name} {res}"
