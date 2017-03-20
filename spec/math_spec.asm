.import source "../lib/64core/math.asm"
// test if it can be imported twice
.import source "../lib/64core/math.asm"
.import source "64spec.asm"

.import source "../lib/64core/memory.asm"
sfspec: :init_spec()
  
int24_declares_three_byte_integer_properly:
  :assert_equal24 #$010203: actual24
  :assert_equal24 #$102030: expected24

int24_do_not_declare_extra_bytes:
  :assert_equal #$fa: actual24 - 1
  :assert_equal #$fb: actual24 + 3
  
  
inc16_works:
  :poke16 actual16: #$0000
  :inc16 actual16 
  :assert_equal16 #$0001: actual16

  :poke16 actual16: #$0001
  :inc16 actual16 
  :assert_equal16 #$0002: actual16

  :poke16 actual16: #$1542
  :inc16 actual16 
  :assert_equal16 #$1543: actual16

  :poke16 actual16: #$00ff
  :inc16 actual16 
  :assert_equal16 #$0100: actual16

  :poke16 actual16: #$00ff
  :inc16 actual16 
  :assert_equal16 #$0100: actual16

  :poke16 actual16: #$0100
  :inc16 actual16 
  :assert_equal16 #$0101: actual16

  :poke16 actual16: #$42ff
  :inc16 actual16 
  :assert_equal16 #$4300: actual16

  :poke16 actual16: #$feff
  :inc16 actual16 
  :assert_equal16 #$ff00: actual16

  :poke16 actual16: #$ffff
  :inc16 actual16 
  :assert_equal16 #$0000: actual16

inc32_works:
  /*:poke32 actual32; #$ffffffff*/
  :poke16 actual32: #$ffff
  :poke16 actual32 + 2: #$ffff
  :inc32 actual32 
  :assert_equal32 #$00000000: actual32

  :poke32 actual32: #$00ffffff
  :inc32 actual32 
  :assert_equal32 #$01000000: actual32

  :poke32 actual32: #$0000ffff
  :inc32 actual32 
  :assert_equal32 #$00010000: actual32

  :poke32 actual32: #$000000ff
  :inc32 actual32 
  :assert_equal32 #$00000100: actual32

dec16_works:
  :poke16 actual16: #$0000
  :dec16 actual16 
  :assert_equal16 #$ffff: actual16

  :poke16 actual16: #$0001
  :dec16 actual16 
  :assert_equal16 #$0000: actual16

  :poke16 actual16: #$1542
  :dec16 actual16 
  :assert_equal16 #$1541: actual16

  :poke16 actual16: #$00ff
  :dec16 actual16 
  :assert_equal16 #$00fe: actual16

  :poke16 actual16: #$0100
  :dec16 actual16 
  :assert_equal16 #$00ff: actual16

  :poke16 actual16: #$0101
  :dec16 actual16 
  :assert_equal16 #$0100: actual16

  :poke16 actual16: #$4300
  :dec16 actual16 
  :assert_equal16 #$42ff: actual16

  :poke16 actual16: #$ff00
  :dec16 actual16 
  :assert_equal16 #$feff: actual16

  :poke16 actual16: #$ffff
  :dec16 actual16 
  :assert_equal16 #$fffe: actual16

dec24_works:
  :poke24 actual24: #$010100
  :dec24 actual24 
  :assert_equal24 #$0100ff: actual24

  :poke24 actual24: #$010000
  :dec24 actual24 
  :assert_equal24 #$00ffff: actual24

  :poke24 actual24: #$000000
  :dec24 actual24 
  :assert_equal24 #$ffffff: actual24

dec32_works:
  :poke32 actual32: #$01010100
  :dec32 actual32 
  :assert_equal32 #$010100ff: actual32

  :poke32 actual32: #$01010000
  :dec32 actual32 
  :assert_equal32 #$0100ffff: actual32

  :poke32 actual32: #$01000000
  :dec32 actual32 
  //:assert_equal32 #$01ffffff; actual32
  :assert_equal16 #$ffff: actual32
  :assert_equal16 #$00ff: actual32 + 2

  :poke32 actual32: #$00000000
  :dec32 actual32 
  //:assert_equal32 #$ffffffff; actual32
  :assert_equal16 #$ffff: actual32
  :assert_equal16 #$ffff: actual32 + 2

asl16_shifts_bits_left_disregarding_carry:
  :poke16 actual16: #%0001001001001000
  :poke16 expected16: #%0010010010010000
  
  sec
  :asl16 actual16
  :assert_equal16 expected16: actual16

lsr16_shifts_bits_right_disregarding_carry:
  :poke16 actual16: #%0001001001001000
  :poke16 expected16: #%0000100100100100
  sec
  :lsr16 actual16
cmps:
  :assert_equal16 expected16: actual16

  :finish_spec()

.pc = * "Data"
actual16:
  .word $fefe
expected16:
  .word $fefe

  .byte $fa
actual24:
  :int24($010203)
  .byte $fb
expected24:
  :int24($102030)
  .byte $fc

actual32:
  .dword $11223344
expected32:
  .dword $01020304


