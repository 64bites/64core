.import source "../lib/64core/kernal.asm"
.import source "64spec.asm"

.import source "../lib/64core/memory.asm"
.import source "../lib/64core/encoding.asm"

sfspec: :init_spec()

.var memory_size = memory_to_save_end - memory_to_save
memory_is_initialized_properly:
  :copy(memory_size, memory_to_save, memory_to_save_and_load)
  :assert_bytes_equal memory_size: memory_to_save: memory_to_save_and_load
  :assert_bytes_not_equal memory_size: memory_to_save: memory_to_load

.var name_length = name_end - name
save_to_disk:
  :kernal_setnam #name_length: #name
  :kernal_setlfs #0: #8: #0
  :kernal_save #memory_to_save_and_load: #memory_to_save_and_load_end

  :assert_c_cleared

clear_the_memory:
  :fill(memory_size, 0, memory_to_save_and_load)
  :poke memory_to_save_and_load - 1: #$ec
  :poke memory_to_save_and_load_end: #$ed
  :assert_bytes_equal memory_size: memory_to_save_and_load: memory_to_load
  
load_from_disk_to_the_stored_address:
  :kernal_setnam #name_length: #name
  :kernal_setlfs #1: #8: #1
  :kernal_load #0
  :assert_c_cleared
  :assert_a_not_equal #$04


memory_is_restored_properly:
  :assert_bytes_equal memory_size: memory_to_save: memory_to_save_and_load

nothing_else_is_touched:
  :assert_equal memory_to_save_and_load - 1: #$ec
  :assert_equal memory_to_save_and_load_end: #$ed
.var name2_length = name2_end - name2
save_read_only_memory_to_disk:
  :kernal_setnam #name2_length: #name2
  :kernal_setlfs #1: #8: #0
  :kernal_save #memory_to_save: #memory_to_save_end

load_from_disk_to_the_specified_address:
  :kernal_setnam #name_length: #name
  :kernal_setlfs #1: #8: #0
  :kernal_load #0: #memory_to_load

memory_is_loaded_properly:
  :assert_bytes_equal memory_size: memory_to_save: memory_to_load


nothing_else_is_touched2:
  :assert_equal memory_to_load - 1: #$fe
  :assert_equal memory_to_load_end: #$ff

  :kernal_clrchn

  :finish_spec()


.pc = * "Data"
name:
  .text pet_string("example1")
name_end:
name2:
  .text pet_string("example2")
name2_end:

.byte $fa
memory_to_save:
  .text "hello there"
  .byte $01
  .byte $02
  .word $1122
memory_to_save_end:
.byte $fb

.byte $fc
memory_to_save_and_load:
  .text "hello there"
  .byte $01
  .byte $02
  .word $1122
memory_to_save_and_load_end:
.byte $fd


.byte $fe
memory_to_load:
  .text "@@@@@@@@@@@"
  .byte $00
  .byte $00
  .word $0000
memory_to_load_end:
.byte $ff
