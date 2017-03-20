.import source "../lib/64core/kernal.asm"
.import source "64spec.asm"

sfspec: :init_spec()

write_to_and_read_from_file_using_open_and_chkout:
 
  :kernal_setnam #[name_write_end - name_write]: #name_write
  :kernal_setlfs #2: #8: #2

  :kernal_open
  :kernal_readst open_st

  :kernal_chkout #2
  :kernal_readst chkout_st

  :kernal_chrout #'A'
  :kernal_chrout #'B'
  :kernal_chrout #'C'

  :kernal_chrout #<$0102
  :kernal_chrout #>$0102

  :kernal_readst chrout_st

  :kernal_close #2
  :kernal_readst close_st

  :kernal_clrchn

  :kernal_setnam #[name_read_end - name_read]: #name_read
  :kernal_setlfs #2: #8: #2

  :kernal_open
  :kernal_readst open_st

  :kernal_chkin #2
  :kernal_readst chkout_st

  :kernal_chrin tmp
  :kernal_chrin tmp + 1
  :kernal_chrin tmp + 2

  :kernal_chrin a_word
  :kernal_chrin a_word + 1
  :kernal_readst chrout_st

  :kernal_close #2
  :kernal_readst close_st

  :kernal_clrchn

  :assert_equal tmp: #'A'
  :assert_equal tmp + 1: #'B'
  :assert_equal tmp + 2: #'C'

  :assert_equal16 a_word: #$0102
  :finish_spec()


.pc = * "Data"
name_read:
  .text "FILENAME"
name_read_end:
name_write:
  .text "FILENAME,P,W"
name_write_end:

open_st:
  .byte $fe

chkout_st:
  .byte $fe

chrout_st:
  .byte $fe

close_st:
  .byte $fe

tmp:
  .byte $00
  .byte $00
  .byte $00

a_word:
  .word $0000

