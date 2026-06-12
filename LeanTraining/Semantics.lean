import LeanTraining.Program
open LeanTraining.Program (VarID Value Expr BExpr Stmt)

namespace LeanTraining.Semantics

def State := VarID → Value

def evalExpr (s : State) (e : Expr) : Value :=
match e with
  | Expr.var x => s x
  | Expr.const v => v
  | Expr.add e1 e2 => (evalExpr s e1) + (evalExpr s e2)
  | Expr.sub e1 e2 => (evalExpr s e1) - (evalExpr s e2)
  | Expr.mul e1 e2 => (evalExpr s e1) * (evalExpr s e2)

def evalBExpr (s : State) (b : BExpr) : Bool :=
match b with
  | BExpr.tt => true
  | BExpr.ff => false
  | BExpr.eq e1 e2 => (evalExpr s e1) == (evalExpr s e2)
  | BExpr.le e1 e2 => (evalExpr s e1) <= (evalExpr s e2)
  | BExpr.not b => !(evalBExpr s b)
  | BExpr.and b1 b2 => (evalBExpr s b1) && (evalBExpr s b2)
  | BExpr.or b1 b2 => (evalBExpr s b1) || (evalBExpr s b2)

def big_step (s: State) (p: Stmt) : State :=
match p with
  | Stmt.skip => s
  | Stmt.seq p1 p2 =>
    let s' := big_step s p1
    big_step s' p2
  | Stmt.assign x v => fun y => if y == x then v else s y
  | Stmt.ifThenElse b p1 p2 =>
    if evalBExpr s b then big_step s p1 else big_step s p2

def small_step (s: State) (p: Stmt) : (Stmt × State) :=
match p with
  | Stmt.skip => (Stmt.skip, s)
  | Stmt.seq Stmt.skip p2 =>  (p2, s)
  | Stmt.seq p1 p2 =>  let (p1', s') := small_step s p1
                      (Stmt.seq p1' p2, s')
  | Stmt.assign x v => (Stmt.assign x v, fun y => if y == x then v else s y)
  | Stmt.ifThenElse b p1 p2 =>
    if evalBExpr s b then (p1, s) else (p2, s)

def eval_n (n: Nat) (s: State) (p: Stmt): State :=
match n with
  | 0 => s
  | Nat.succ n' => match p with
                   | Stmt.skip => s
                   | stmt => let (p', s') := small_step s stmt
                             (eval_n n' s' p')

end LeanTraining.Semantics
