# 64core

Useful C64 development tools for KickAssembler. 
Aiming to be the standard library someday.

Work in Progress.

## Idea

The aim of this library is to make common tasks a bit more easier, but not necessary most efficient.

It is best used at the beginning of the project where you want to just start with something. And later, when your project matures, you can replace 64core routines with optimized ones.

## Installation

### Recommended way

1. Create a dir for libraries that your KickAssembler projects use.
2. Get the current version of the 64core and copy contents of /lib into this dir along with other libraries. 
3. Import it in your files as <code>.import source "64core.asm" or select specific modules</code>
4. Make sure to pass option <code>-libdir <path-to-your-libraries-dir></code> when compiling with KickAssembler.

### If you just want to try it out

1. Get the latest version of the 64core and copy contents of /lib into your project dir.
2. Import it in your any files files as <code>.import source "./64core.asm"</code>

## Existing modules

#### 1. 64core/common

Contains function used by other modules. Currently bit/byte extraction operations.

#### 2. Encoding

Functions for creating characters and strings in screencode or PETSCII encoding.

#### 4. Kernal

Pseudocommands and macros for Kernal routines

#### 5. Math

Multibyte arithmetic and logical operations.

#### 6. Memory

Helper functions for filling and copying data in memory.

#### 7. Version

One function <code>_64core_version()</code> returning current version of the library.

## License
The MIT License (MIT)

Copyright (c) 2015 Michał Taszycki

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
