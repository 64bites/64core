#importonce
.filenamespace break

.var break_file = null

.macro @break_init(breakpoints_file_path) {
  .eval break_file = createFile(breakpoints_file_path)
}

.macro @break_here() {
  break_pc(*)
}

.macro @break_pc(address) {
  .eval write_to_file("break " + toHexString(address))
}

.macro @break_raster(line) {
  .eval write_to_file("breakraster " + toHexString(line))
}

.macro @break_mem_eq(address, value) {
  break_mem(address, "==", value)
}
.macro @break_mem_neq(address, value) {
  break_mem(address, "!=", value)
}
.macro @break_mem_gteq(address, value) {
  break_mem(address, ">=", value)
}
.macro @break_mem_lteq(address, value) {
  break_mem(address, "<=", value)
}
.macro @break_mem_gt(address, value) {
  break_mem(address, ">", value)
}
.macro @break_mem_lt(address, value) {
  break_mem(address, "<", value)
}
.macro break_mem(address, operand, value) {
  .eval write_to_file("breakraster " + toHexString(address) + " " + toHexString(operand) + " " + toHexString(value) + " ")
}

.macro @break_vic() {
  .eval write_to_file("breakvic")
}

.macro @break_cia() {
  .eval write_to_file("breakcia")
}

.macro @break_nmi() {
  .eval write_to_file("breaknmi")
}

.function write_to_file(string) {
  .eval break_file.writeln(string)
}

