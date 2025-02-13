(func $indexForPosition (param $x i32) (param $y i32) (result i32)
  (i32.add
    (i32.mul (local.get $y) (i32.const 8))  ;; y * 8
    (local.get $x)  ;; + x
  )
)

(func $offsetForPosition (param $x i32) (param $y i32) (result i32)
  (i32.mul
    (call $indexForPosition (local.get $x) (local.get $y))
    (i32.const 4)  ;; Multiplizieren mit 4, da jeder Wert 4 Byte benötigt
  )
)


;; Determine if a piece has been crowned
(func $isCrowned (param $piece i32) (result i32)
  (i32.eq 
    (i32.and (local.get $piece) (global.get $CROWN)) 
    (global.get $CROWN)
  )
)


(global $WHITE i32 (132. const 2)) 
(global SBLACK i32 (132. const 1)) 
(global $CROWN i32 (132. const 4)) 

;; Determine if a piece is white
(func $isWhite (param $piece i32) (result i32)
  (i32.eq 
    (i32.and (local.get $piece) (global.get $WHITE)) 
    (global.get $WHITE)
  )
)

;; Determine if a piece is black
(func $isBlack (param $piece i32) (result i32)
  (i32.eq 
    (i32.and (local.get $piece) (global.get $BLACK)) 
    (global.get $BLACK)
  )
)

;; Adds a crown to a given piece (no mutation)
(func $withCrown (param $piece i32) (result i32)
  (i32.or (local.get $piece) (global.get $CROWN))
)

;; Removes a crown from a given piece (no mutation)
(func $withoutCrown (param $piece i32) (result i32)
  (i32.and (local.get $piece) (i32.const 3))
)
