.import source "../lib/64core/memory.asm"
// test if it can be imported twice
.import source "../lib/64core/memory.asm"
.import source "64spec.asm"

sfspec: :init_spec()

  :poke32 dword_c; dword_a
  :assert_equal32 dword_a; dword_c

  :poke32 dword_c; #$10203040
  :assert_equal32 #$10203040; dword_c
  
  :copy(4, dword_b, dword_result)
  :assert_equal32 dword_b; dword_result

  :fill(4, $fe, dword_result)
  // Workaround until the bug is fixed
  :assert_equal16 #$fefe; dword_result
  :assert_equal16 #$fefe; dword_result + 2
  /*:assert_equal32 #$fefefefe; dword_result*/

  .var memory_size = 6*5
  :fill2d(5, memory_to_fill + 6 + 1, 2, 3, 4)
  :assert_bytes_equal memory_size; memory_to_fill; memory2d_a 

  :fill2d(0, memory_to_fill, 6, 5, 0)
  :copy2d(memory2d_a + 6 + 1, memory_to_fill + 6 + 2, 2, 3, 4)
  :assert_bytes_equal memory_size; memory_to_fill; memory2d_b 

  :finish_spec()

.pc = * "Data"
word_a:
  .dword $1122
word_b:
  .dword $0102
word_c:
  .dword $1020
word_result:
  .word $ffff
dword_a:
  .dword $11223344
dword_b:
  .dword $01020304
dword_c:
  .dword $10203040
dword_result:
  .dword $ffffffff
memory2d_a:
  .byte 0,0,0,0,0,0
  .byte 0,5,5,0,0,0
  .byte 0,5,5,0,0,0
  .byte 0,5,5,0,0,0
  .byte 0,0,0,0,0,0
memory2d_b:
  .byte 0,0,0,0,0,0
  .byte 0,0,5,5,0,0
  .byte 0,0,5,5,0,0
  .byte 0,0,5,5,0,0
  .byte 0,0,0,0,0,0

memory_to_fill:
  .byte 0,0,0,0,0,0
  .byte 0,0,0,0,0,0
  .byte 0,0,0,0,0,0
  .byte 0,0,0,0,0,0
  .byte 0,0,0,0,0,0
memory_to_fill_end:
