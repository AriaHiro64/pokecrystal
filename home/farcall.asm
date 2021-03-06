FarCall_de::
; Call a:de.
; Preserves other registers.

	ldh [hTempBank], a
	ldh a, [hROMBank]
	push af
	ldh a, [hTempBank]
	rst Bankswitch
	call .de
	jr ReturnFarCall

.de
	push de
	ret

FarCall_hl::
; Call a:hl.
; Preserves other registers.

	ldh [hTempBank], a
	ldh a, [hROMBank]
	push af
	ldh a, [hTempBank]
	rst Bankswitch
	call FarCall_JumpToHL

ReturnFarCall::
; We want to retain the contents of f.
; To do this, we can pop to bc instead of af.

	ld a, b
	ld [wFarCallBCBuffer], a
	ld a, c
	ld [wFarCallBCBuffer + 1], a

; Restore the working bank.
	pop bc
	ld a, b
	rst Bankswitch

	ld a, [wFarCallBCBuffer]
	ld b, a
	ld a, [wFarCallBCBuffer + 1]
	ld c, a
	ret

FarCall_JumpToHL::
	jp hl
