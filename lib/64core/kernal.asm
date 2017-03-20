#importonce
#import "64core/common.asm"
#import "64core/memory.asm"

// see http://www.ffd2.com/fridge/docs/c64-diss.html#a3bf
// and http://members.tripod.com/~Frank_Kontros/kernal/alpha.htm
// and Compute's_Programming_the_Commodore_64_The_Definitive_Guide.pdf page 241
.namespace kernal {
  .label setlfs = $FFBA
  .label open = $FFC0
  .label close = $FFC3
  .label chkin = $FFC6
  .label chkout = $FFC9
  .label setnam = $FFBD
  .label chrout = $FFD2
  .label chrin = $FFCF
  .label readst = $FFB7
  .label clrchn = $FFCC
  .label load = $FFD5
  .label save = $FFD8
  .label restor = $ff8a
  .label plot = $fff0
  .label clear_screen = $e544
  .label chrout_screen = $e716
} 

.pseudocommand kernal_plot_get column: row {
  sec
  jsr kernal.plot
  .if (column.getType() != AT_NONE) {
    stx row
  }
  .if (row.getType() != AT_NONE) {
    sty column
  }
}
.pseudocommand kernal_plot_set column: row {
  clc
  ldx row
  ldy column
  jsr kernal.plot
}
.pseudocommand kernal_restor {
  jsr kernal.restor  
}
.pseudocommand kernal_readst result {
  jsr kernal.readst
  .if (result.getType() != AT_NONE) {
    sta result
  }
}

.pseudocommand kernal_load load_or_verify: alternate_start  {
  lda load_or_verify
  .if (alternate_start.getType() != AT_NONE) {
    ldx extract_byte_argument(alternate_start, 0)
    ldy extract_byte_argument(alternate_start, 1)
  }
  jsr kernal.load
}

.pseudocommand kernal_save start_address: end_address : page_0_offset {
  .if (page_0_offset.getType() == AT_NONE) {
    .eval page_0_offset = CmdArgument(AT_IMMEDIATE, $c1)
  } else .if (page_0_offset.getType() != AT_IMMEDIATE) {
    .error "only immediate mode is supported for page_0_offset argument"
  }
  :mov16 start_address : page_0_offset.getValue()
  lda #page_0_offset.getValue()
  ldx extract_byte_argument(end_address, 0)
  ldy extract_byte_argument(end_address, 1)
  jsr kernal.save
}

.pseudocommand kernal_clrchn {
  jsr kernal.clrchn
}

.pseudocommand kernal_clrscr {
  jsr kernal.clear_screen
}

.pseudocommand kernal_setlfs logical_file_number: device_number: command {
  lda logical_file_number
  ldx device_number
  ldy command
  jsr kernal.setlfs
}
.pseudocommand kernal_setnam length: string_address {
  lda length
  ldx extract_byte_argument(string_address, 0)
  ldy extract_byte_argument(string_address, 1)
  jsr kernal.setnam
}

.pseudocommand kernal_open {
  jsr kernal.open
}

.pseudocommand kernal_close logical_file_number {
  lda logical_file_number
  jsr kernal.close
}

.pseudocommand kernal_chkin logical_file_number {
  ldx logical_file_number
  jsr kernal.chkin
}

.pseudocommand kernal_chkout logical_file_number {
  ldx logical_file_number
  jsr kernal.chkout
}
.pseudocommand kernal_chrout byte {
  lda byte
  jsr kernal.chrout
}

.pseudocommand kernal_chrin result {
  jsr kernal.chrin
  .if (result.getType() != AT_NONE) {
    sta result
  }
}

// deprecated?
.pseudocommand kernal_print_char char {
  lda char
  jsr kernal.chrout_screen
}

.macro print_pet_string(string) {
  .if (string.size() > 0) {
    jmp end_text
      text:
      .text string
      end_text:

      ldx #0
      loop:
      lda text, X
      jsr kernal.chrout
      inx
      cpx #string.size()
      bne loop
  }
}

// TODO: move somewhere else?
.macro kernal_print_ntstring(string){
    ldx #0
  loop:
    lda string, X
    beq end
    jsr kernal.chrout
    inx
    jmp loop 
  end:
}

// TODO: move somewhere else?
.macro kernal_print_lpstring(string) {
    ldx #0
  loop:
    cpx string
    beq end
    lda string + 1, X
    jsr kernal.chrout
    inx
    jmp loop 
  end:
}

// TODO: This is basic not kernal
.pseudocommand kernal_print_byte value {
  ldx value
  lda #0

  jsr $bdcd
}

