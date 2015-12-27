.import source "../lib/64core/kernal.asm"
.import source "64spec.asm"

.import source "./support/state_restoration.asm"
sfspec: :init_spec()
  
  :store_cursor_position
kernal_plot_set_moves_cursor_to_given_column_and_row:
  :kernal_plot_set #1; #2
  :kernal_chrout #'&'
  :restore_cursor_position 

  :assert_equal #'&'; $0400 + 40*2 + 1 

  :store_cursor_position
  :kernal_plot_set #21; #18
when_called_without_arguments:
  :kernal_plot_get
  sty test_column
  stx test_row
  :restore_cursor_position
kernal_plot_get_stores_column_in_the_y_register:
  :assert_equal test_column; #21
kernal_plot_get_stores_row_in_the_x_register:
  :assert_equal test_row; #18

  :store_cursor_position
  :kernal_plot_set #13; #20
when_called_with_arguments:
  :kernal_plot_get test_column; test_row
  :restore_cursor_position
kernal_plot_get_stores_column_at_the_specified_address:
  :assert_equal test_column; #13
kernal_plot_get_stores_row_at_the_specified_address:
  :assert_equal test_row; #20

  :finish_spec()

.pc =  * "Data"
cursor_position_state: :setup_cursor_position_state()

test_column:
  .byte 0
test_row:
  .byte 0


