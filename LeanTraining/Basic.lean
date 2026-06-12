namespace LeanTraining.Basic

-- Ejemplos básicos con funciones sobre listas y enteros
-- y algunas demostraciones

-- No detecta recursión estructural
-- def duplica_mal (n: Nat) : Nat :=
-- if n == 0 then 0 else 2 + duplica_mal (n - 1)

def duplica (n: Nat) : Nat :=
match n with
| 0 => 0
| Nat.succ n' => 2 + duplica n'

-- Suma el número de constructoras de tipo Nat en una lista
-- de números
def suma_todo (l: List Nat) : Nat :=
match l with
| [] => 0
| 0 :: xs => 1 + suma_todo xs
| Nat.succ n :: xs => Nat.succ (suma_todo (n::xs))

-- Teorema que se puede demostrar con omega o grind
theorem leq_plus1 (x y: Nat) :
(x <= y) → (x + 1) <= (1 + y) := by
  grind
  -- omega

theorem suma_todo_leq (l: List Nat) :
suma_todo l >= List.length l := by
  cases l with
  | nil => simp only [List.length_nil, ge_iff_le, Nat.zero_le]
  | cons head tail =>
      cases head with
      | zero =>
          simp only [List.length_cons, ge_iff_le]
          unfold suma_todo
          apply leq_plus1
          have IH := (suma_todo_leq tail)
          exact IH
      | succ n =>
          unfold suma_todo
          simp only [Nat.succ_eq_add_one, List.length_cons, ge_iff_le, Nat.add_le_add_iff_right]
          sorry -- ejercicio para el lector interesado XD


end LeanTraining.Basic
