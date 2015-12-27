.importonce
.const _64CORE_VERSION_MAJOR = 0
.const _64CORE_VERSION_MINOR = 1
.const _64CORE_VERSION_PATCH = 0

.function _64core_version() {
  .return "" + _64CORE_VERSION_MAJOR + '.' + _64CORE_VERSION_MINOR + '.' + _64CORE_VERSION_PATCH
}

