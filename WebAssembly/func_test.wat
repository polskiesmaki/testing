(module
  (memory $mem 1)

  ;; Globale Konstanten
  (global $WHITE i32 (i32.const 2))
  (global $BLACK i32 (i32.const 1))
  (global $CROWN i32 (i32.const 4))

  ;; Berechnet den Index einer Position auf einem 8x8-Spielbrett
  (func $indexForPosition (param $x i32) (param $y i32) (result i32)
    (i32.add
      (i32.mul (i32.const 8) (local.get $y))
      (local.get $x)
    )
  )

  ;; Berechnet den Speicher-Offset für eine Position
  (func $offsetForPosition (param $x i32) (param $y i32) (result i32)
    (i32.mul
      (call $indexForPosition (local.get $x) (local.get $y))
      (i32.const 4)
    )
  )

  ;; Prüft, ob eine Figur gekrönt ist
  (func $isCrowned (param $piece i32) (result i32)
    (i32.eq
      (i32.and (local.get $piece) (global.get $CROWN))
      (global.get $CROWN)
    )
  )

  ;; Prüft, ob eine Figur weiß ist
  (func $isWhite (param $piece i32) (result i32)
    (i32.eq
      (i32.and (local.get $piece) (global.get $WHITE))
      (global.get $WHITE)
    )
  )

  ;; Prüft, ob eine Figur schwarz ist
  (func $isBlack (param $piece i32) (result i32)
    (i32.eq
      (i32.and (local.get $piece) (global.get $BLACK))
      (global.get $BLACK)
    )
  )

  ;; Fügt einer Figur eine Krone hinzu (ohne Mutation)
  (func $withCrown (param $piece i32) (result i32)
    (i32.or (local.get $piece) (global.get $CROWN))
  )

  ;; Entfernt die Krone von einer Figur (ohne Mutation)
  (func $withoutCrown (param $piece i32) (result i32)
    (i32.and (local.get $piece) (i32.const 3))
  )

  ;; Exporte für die Nutzung außerhalb von WebAssembly
  (export "offsetForPosition" (func $offsetForPosition))
  (export "isCrowned" (func $isCrowned))
  (export "isWhite" (func $isWhite))
  (export "isBlack" (func $isBlack))
  (export "withCrown" (func $withCrown))
  (export "withoutCrown" (func $withoutCrown))
)
