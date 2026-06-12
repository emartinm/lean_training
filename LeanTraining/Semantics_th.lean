import LeanTraining.Semantics
import LeanTraining.Program

open LeanTraining.Semantics (small_step big_step State evalBExpr)
open LeanTraining.Program (Stmt VarID Value)

namespace LeanTraining.SemanticsTh

theorem small_step_skip (s: State) : small_step s Stmt.skip = (Stmt.skip, s) := by
  simp only [small_step]
  --rfl

theorem if_chained (s: State) (x y: VarID) (v: Value) :
(if y = x then v else if y = x then v else s y) = (if y = x then v else s y) := by
  split
  . rfl
  . rfl

theorem small_step_to_big_step (s: State) (p: Stmt) :
  small_step s p = (p', s') → big_step s p = big_step s' p' := by
  intros h
  cases p with
  | skip => simp only [small_step] at h
            simp only [big_step]
            rcases h with ⟨h1, h2⟩
            simp only [big_step]
  | seq p1 p2 =>
      cases p1 with -- este caso lo hizo Copilot Pro él solo!
                    -- Estuvo iterando y revisaba los errores
      | skip =>
          simp only [small_step] at h
          rcases h with ⟨rfl, rfl⟩
          simp only [big_step]
      | seq pa pb =>
          simp only [small_step] at h
          rcases h with ⟨rfl, rfl⟩
          simp only [big_step]
          exact congrArg (fun x => big_step x p2) (small_step_to_big_step s (Stmt.seq pa pb) rfl)
      | assign x v =>
          simp only [small_step] at h
          rcases h with ⟨rfl, rfl⟩
          simp only [big_step]
          exact congrArg (fun x => big_step x p2) (small_step_to_big_step s (Stmt.assign x v) rfl)
      | ifThenElse b pa pb =>
          simp only [small_step] at h
          rcases h with ⟨rfl, rfl⟩
          simp only [big_step]
          exact congrArg (fun x => big_step x p2) (small_step_to_big_step s (Stmt.ifThenElse b pa pb) rfl)
  | assign x v => simp [small_step] at h
                  rcases h with ⟨h1, h2⟩
                  rw [← h1]
                  rw [← h2]
                  simp [big_step]
                  funext z -- extensionality
                  rw [if_chained]
  | ifThenElse b p1 p2 => simp only [small_step] at h
                          cases heval : evalBExpr s b with
                          | false =>
                            rw [heval] at h
                            simp at h
                            rcases h with ⟨h1, h2⟩
                            rw [← h1]
                            rw [← h2]
                            simp [big_step]
                            rw [heval]
                            simp only [Bool.false_eq_true, false_implies]
                          | true =>
                            rw [heval] at h
                            simp at h
                            rcases h with ⟨h1, h2⟩
                            rw [← h1]
                            rw [← h2]
                            simp [big_step]
                            rw [heval]
                            simp only [Bool.true_eq_false, false_implies]


end LeanTraining.SemanticsTh
