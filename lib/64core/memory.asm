.importonce
.import source "./common.asm"
.import source "./math.asm"

.pseudocommand mov source: dest {
  :_mov 1: source: dest
}

.pseudocommand mov16 source: dest {
  :_mov 2: source: dest
}

.pseudocommand _mov bytes: source: dest {
  .for(var byte_id = 0; byte_id < bytes.getValue(); byte_id++) {
    lda extract_byte_argument(source, byte_id)
    sta extract_byte_argument(dest, byte_id)
  }
}



// TODO: fill16, fill24, fill32
.macro fill(bytes_count, value, dest){
  lda #value
  ldx #bytes_count
loop:
  .label dest_start = * + 1
  sta dest - 1, X 
  dex
  bne loop 
}

// Take a look at: http://www.ffd2.com/fridge/docs/c64-diss.html#a3bf
// TODO: add errors for invalid bytes_count
.macro copy(bytes_count, source, dest){
  ldx #bytes_count
loop:
  .label source_start = * + 1
  lda source - 1, X
  .label dest_start = * + 1
  sta dest - 1, X 
  dex
  bne loop 
}

.macro fill2d(value, dest, columns, rows, stride) {
  ldy #rows 
fill_row: :fill(columns, value, dest)
  :add16 fill_row.dest_start: #[columns + stride]
  dey
  bne fill_row
}

.macro copy2d(source, dest, columns, rows, stride) {
  ldy #rows 
copy_row: :copy(columns, source, dest)
  :add16 copy_row.source_start: #[columns + stride]
  :add16 copy_row.dest_start: #[columns + stride]
  dey
  bne copy_row
}

.pseudocommand poke dest : source{
  :_poke bits_to_bytes(8): dest: source
}
.pseudocommand poke16 dest : source{
  :_poke bits_to_bytes(16): dest: source
}
.pseudocommand poke24 dest : source{
  :_poke bits_to_bytes(24): dest: source
}
.pseudocommand poke32 dest : source{
  :_poke bits_to_bytes(32): dest: source
}

.pseudocommand _poke bytes_count: dest: source {
  .for (var byte_id = 0; byte_id < bytes_count.getValue(); byte_id++) {
    lda extract_byte_argument(source, byte_id)
    sta extract_byte_argument(dest, byte_id)
  } 
}
