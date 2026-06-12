Notas para un pequeño taller de introducción a Lean4
====================================================

Historia
--------
* Lean4: Proof assistant
* CIC
* años 2000

Instalación
-----------
* Extensión en VSCode

Crear un proyecto
-----------------
* Desde el propio VSCode, `Lean4 > New Project...`
* Punto positivo -> autocontenido en cada carpeta
* Punto negativo -> cementerio de GB si usas Mathlib


Lenguaje funcional
------------------
  - Tipos de datos inductivos
  - Definición de funciones
  - Encaje de patrones

Lenguaje para definir teoremas y demostraciones
-----------------------------------------------
  - tácticas
    * `intro / intros`
      Mueve premisas al contexto local
    * `revert`
      Realiza la operación inversa a intro
    * `clear`
      Elimina hipótesis del contexto local
    * `apply`
      Intenta emparejar la conclusión de un teorema/hipótesis con 
      el objetivo actual. Si encaja, crea nuevos subobjetivos para cada una de las premisas requeridas
      por ese teorema.
    * `exact`
      Cierra el objetivo actual de inmediato si se le proporciona un término exacto
    * `rfl (reflexivity)`
      Cierra un objetivo de igualdad si ambos lados de la ecuación son estructural o numéricamente idénticos tras simplificarse (por ejemplo: 5 = 5).
    * `rw (rewrite)`
      Utiliza una igualdad para reemplazar todas las apariciones de un lado por el otro
    * `simp`
      Utiliza reglas predefinidas en la biblioteca base y las hipótesis locales para reducir el objetivo a su forma más simple o resolverlo directamente.
    * `aesop / grind`
      Táctica de automatización avanzada que busca demostraciones de forma autónoma combinando búsqueda lógica, inducción y reescrituras.
    * `omega`
      Resuelve de forma automática problemas de aritmética lineal con números enteros y naturales (ecuaciones e inecuaciones que involucren sumas y restas).
    * `linarith`
      Táctica de la biblioteca Mathlib especializada en resolver sistemas de inecuaciones lineales sobre números reales o racionales.
    * `cases`
      Divide el objetivo actual analizando los distintos constructores de un tipo de datos o una hipótesis (por ejemplo, si una hipótesis es una disyunción "A O B", genera un caso para A y otro para B).
    * `have`
      Permite declarar y demostrar una afirmación o lema intermedio dentro del bloque para utilizarlo como hipótesis más adelante.
    * `sorry`
      Asume algo sin demostración (warning)

  - https://lean-lang.org/theorem_proving_in_lean4/Tactics/#Theorem-Proving-in-Lean-4--Tactics
  - https://leanprover-community.github.io/img/lean-tactics.pdf


Encontrar lemas y teoremas
----------------------------
  - Autocompletado y suerte

        #check Nat.
  - https://leansearch.net/ que no está mal
  - Echo de menos un Search como en Rocq :'(

Generación de binarios
----------------------
  - `$ lake build`
  - Instrucciones en `lakefile.toml`
  - ¡Todo en el mismo lenguaje de Lean!

Aprender Lean
-------------
* El juego de Lean! https://adam.math.hhu.de/#/g/leanprover-community/NNG4/world/Tutorial/level/1
* Muchos recursos en https://lean-lang.org/learn/

IA
--
* GitHub Copilot ayuda bastante para cosas repetitivas
  - Incluso se puso a demostrar de manera iterativa!
* Claude Code? Tengo mucha esperanza puesta en él
* Axiomatic AI: https://github.com/Axiomatic-AI/ax-prover-base