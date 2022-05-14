;
; ~ 1 Hz block wave
;

.module toggle

WAVEPIN = 0 ; pa0
VCC = 4500  ; mV

.include "pdk.asm"

;.area DATA (ABS)
;/.org 0x00

.area CODE (ABS)
.org 0x00

clock_3khz

easypdk_calibrate_ilrc 3000, VCC

.macro nop2 ?l0
	goto l0
	l0:
.endm

mov a, #0
mov pa, a
mov pac, a
set1 pac, #WAVEPIN

; 3000 cycle == 1Hz wave

loop:
set0 pa, #WAVEPIN  ; 1
mov a, #214        ; 1
l0:
nop2               ; 2 * 214
nop2               ; 2 * 214
dzsn a             ; 1 * 213 + 2
goto l0            ; 2 * 213

mov a, #214        ; 1
; -------------------------------
;                  | 1500

set1 pa, #WAVEPIN  ; 1
l1:
nop2               ; 2 * 214
nop2               ; 2 * 214
dzsn a             ; 1 * 213 + 2
goto l1            ; 2 * 213
goto loop          ; 2
; -------------------------------
;                  | 1500

