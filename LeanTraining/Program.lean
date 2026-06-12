namespace LeanTraining.Program

-- Versión muy pequeña de un lenguaje de programación

#check Nat.mul_add
#check Nat.lt_add_one_of_lt

abbrev VarID := String -- Program variable identifier
abbrev Value := Nat -- Values

inductive Expr : Type where
  | var : VarID → Expr
  | const : Value → Expr
  | add : Expr → Expr → Expr
  | sub : Expr → Expr → Expr
  | mul : Expr → Expr → Expr

inductive BExpr : Type where
  | tt    : BExpr
  | ff    : BExpr
  | eq    : Expr -> Expr → BExpr
  | le    : Expr -> Expr → BExpr
  | not   : BExpr → BExpr
  | and   : BExpr → BExpr → BExpr
  | or    : BExpr → BExpr → BExpr

inductive Stmt : Type where
  | skip        : Stmt
  | seq         : Stmt → Stmt → Stmt
  | assign      : VarID -> Value → Stmt
  | ifThenElse  : BExpr → Stmt → Stmt → Stmt

end LeanTraining.Program
