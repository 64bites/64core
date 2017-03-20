.import source "../lib/64core/kernal.asm"
.import source "64spec.asm"

sfspec: :init_spec()
  :finish_spec()

.assert "setnam", { 
  :kernal_setnam $1000: #$0102 
}, {
  lda $1000
  ldx #<$0102
  ldy #>$0102
  jsr $ffbd
}
