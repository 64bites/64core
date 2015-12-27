.importonce
.import source "../../lib/64core/kernal.asm"
.import source "../../lib/64core/memory.asm"

.pseudocommand store_cursor_position {
  :kernal_plot_get cursor_position_state.column; cursor_position_state.row 
}
.pseudocommand restore_cursor_position {
  :kernal_plot_set cursor_position_state.column; cursor_position_state.row 
}

.macro setup_cursor_position_state() {
  column:
    .byte 0
  row:
    .byte 0
}

.pseudocommand store_top_left_char {
  :poke top_left_char_state.char; $0400
}
.pseudocommand restore_top_left_char {
  :poke $0400; top_left_char_state.char
}

.macro setup_top_left_char_state() {
  char:
    .byte 0
}
