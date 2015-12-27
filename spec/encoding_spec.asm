.import source "../lib/64core/encoding.asm"
.import source "64spec.asm"

.import source "../lib/64core/kernal.asm"
.import source "../lib/64core/memory.asm"
.import source "./support/state_restoration.asm"

.const TOP_LEFT_CHAR = $0400
sfspec: :init_spec()
 
char_generates_a_character_in_screencode_encoding_from_a_number:
  .for (var screencode = 0;screencode < 256; screencode++) {
    :assert_equal #screencode; #["" + char(screencode)].charAt(0)
  }

pet_string_generates_a_character_in_petscii_encoding_from_a_screencode_char:
  .for (var screencode = 0;screencode < 128; screencode++) {
    :store_top_left_char
    :store_cursor_position
    :kernal_plot_set #0; #0
    :print_pet_string(pet_string("" + char(screencode)))
    :restore_cursor_position
    :poke actual_char; TOP_LEFT_CHAR
    :restore_top_left_char
    :assert_equal actual_char; #screencode 
  }

  :finish_spec()

.pc = * "Data"
cursor_position_state: :setup_cursor_position_state()
top_left_char_state: :setup_top_left_char_state()
actual_char:
  .byte 0
