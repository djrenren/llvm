; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=x86-64 -mattr=+rdrnd | FileCheck %s --check-prefix=CHECK --check-prefix=GENERIC
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=goldmont | FileCheck %s --check-prefix=CHECK --check-prefix=GOLDMONT
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=ivybridge | FileCheck %s --check-prefix=CHECK --check-prefix=IVY
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=haswell | FileCheck %s --check-prefix=CHECK --check-prefix=HASWELL
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=broadwell | FileCheck %s --check-prefix=CHECK --check-prefix=BROADWELL
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=skylake | FileCheck %s --check-prefix=CHECK --check-prefix=SKYLAKE
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=skx | FileCheck %s --check-prefix=CHECK --check-prefix=SKX
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -print-schedule -mcpu=znver1 | FileCheck %s --check-prefix=CHECK --check-prefix=ZNVER1

declare {i16, i32} @llvm.x86.rdrand.16()
declare {i32, i32} @llvm.x86.rdrand.32()
declare {i64, i32} @llvm.x86.rdrand.64()

define i16 @test_rdrand_16(i16* %random_val) {
; GENERIC-LABEL: test_rdrand_16:
; GENERIC:       # %bb.0:
; GENERIC-NEXT:    rdrandw %ax # sched: [100:0.33]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; GOLDMONT-LABEL: test_rdrand_16:
; GOLDMONT:       # %bb.0:
; GOLDMONT-NEXT:    rdrandw %ax # sched: [100:1.00]
; GOLDMONT-NEXT:    retq # sched: [4:1.00]
;
; IVY-LABEL: test_rdrand_16:
; IVY:       # %bb.0:
; IVY-NEXT:    rdrandw %ax # sched: [100:0.33]
; IVY-NEXT:    retq # sched: [1:1.00]
;
; HASWELL-LABEL: test_rdrand_16:
; HASWELL:       # %bb.0:
; HASWELL-NEXT:    rdrandw %ax # sched: [1:5.33]
; HASWELL-NEXT:    retq # sched: [2:1.00]
;
; BROADWELL-LABEL: test_rdrand_16:
; BROADWELL:       # %bb.0:
; BROADWELL-NEXT:    rdrandw %ax # sched: [9:1.00]
; BROADWELL-NEXT:    retq # sched: [7:1.00]
;
; SKYLAKE-LABEL: test_rdrand_16:
; SKYLAKE:       # %bb.0:
; SKYLAKE-NEXT:    rdrandw %ax # sched: [100:0.25]
; SKYLAKE-NEXT:    retq # sched: [7:1.00]
;
; SKX-LABEL: test_rdrand_16:
; SKX:       # %bb.0:
; SKX-NEXT:    rdrandw %ax # sched: [100:0.25]
; SKX-NEXT:    retq # sched: [7:1.00]
;
; ZNVER1-LABEL: test_rdrand_16:
; ZNVER1:       # %bb.0:
; ZNVER1-NEXT:    rdrandw %ax # sched: [100:?]
; ZNVER1-NEXT:    retq # sched: [1:0.50]
  %call = call {i16, i32} @llvm.x86.rdrand.16()
  %randval = extractvalue {i16, i32} %call, 0
  ret i16 %randval
}

define i32 @test_rdrand_32(i32* %random_val) {
; GENERIC-LABEL: test_rdrand_32:
; GENERIC:       # %bb.0:
; GENERIC-NEXT:    rdrandl %eax # sched: [100:0.33]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; GOLDMONT-LABEL: test_rdrand_32:
; GOLDMONT:       # %bb.0:
; GOLDMONT-NEXT:    rdrandl %eax # sched: [100:1.00]
; GOLDMONT-NEXT:    retq # sched: [4:1.00]
;
; IVY-LABEL: test_rdrand_32:
; IVY:       # %bb.0:
; IVY-NEXT:    rdrandl %eax # sched: [100:0.33]
; IVY-NEXT:    retq # sched: [1:1.00]
;
; HASWELL-LABEL: test_rdrand_32:
; HASWELL:       # %bb.0:
; HASWELL-NEXT:    rdrandl %eax # sched: [1:5.33]
; HASWELL-NEXT:    retq # sched: [2:1.00]
;
; BROADWELL-LABEL: test_rdrand_32:
; BROADWELL:       # %bb.0:
; BROADWELL-NEXT:    rdrandl %eax # sched: [9:1.00]
; BROADWELL-NEXT:    retq # sched: [7:1.00]
;
; SKYLAKE-LABEL: test_rdrand_32:
; SKYLAKE:       # %bb.0:
; SKYLAKE-NEXT:    rdrandl %eax # sched: [100:0.25]
; SKYLAKE-NEXT:    retq # sched: [7:1.00]
;
; SKX-LABEL: test_rdrand_32:
; SKX:       # %bb.0:
; SKX-NEXT:    rdrandl %eax # sched: [100:0.25]
; SKX-NEXT:    retq # sched: [7:1.00]
;
; ZNVER1-LABEL: test_rdrand_32:
; ZNVER1:       # %bb.0:
; ZNVER1-NEXT:    rdrandl %eax # sched: [100:?]
; ZNVER1-NEXT:    retq # sched: [1:0.50]
  %call = call {i32, i32} @llvm.x86.rdrand.32()
  %randval = extractvalue {i32, i32} %call, 0
  ret i32 %randval
}

define i64 @test_rdrand_64(i64* %random_val) {
; GENERIC-LABEL: test_rdrand_64:
; GENERIC:       # %bb.0:
; GENERIC-NEXT:    rdrandq %rax # sched: [100:0.33]
; GENERIC-NEXT:    retq # sched: [1:1.00]
;
; GOLDMONT-LABEL: test_rdrand_64:
; GOLDMONT:       # %bb.0:
; GOLDMONT-NEXT:    rdrandq %rax # sched: [100:1.00]
; GOLDMONT-NEXT:    retq # sched: [4:1.00]
;
; IVY-LABEL: test_rdrand_64:
; IVY:       # %bb.0:
; IVY-NEXT:    rdrandq %rax # sched: [100:0.33]
; IVY-NEXT:    retq # sched: [1:1.00]
;
; HASWELL-LABEL: test_rdrand_64:
; HASWELL:       # %bb.0:
; HASWELL-NEXT:    rdrandq %rax # sched: [1:5.33]
; HASWELL-NEXT:    retq # sched: [2:1.00]
;
; BROADWELL-LABEL: test_rdrand_64:
; BROADWELL:       # %bb.0:
; BROADWELL-NEXT:    rdrandq %rax # sched: [9:1.00]
; BROADWELL-NEXT:    retq # sched: [7:1.00]
;
; SKYLAKE-LABEL: test_rdrand_64:
; SKYLAKE:       # %bb.0:
; SKYLAKE-NEXT:    rdrandq %rax # sched: [100:0.25]
; SKYLAKE-NEXT:    retq # sched: [7:1.00]
;
; SKX-LABEL: test_rdrand_64:
; SKX:       # %bb.0:
; SKX-NEXT:    rdrandq %rax # sched: [100:0.25]
; SKX-NEXT:    retq # sched: [7:1.00]
;
; ZNVER1-LABEL: test_rdrand_64:
; ZNVER1:       # %bb.0:
; ZNVER1-NEXT:    rdrandq %rax # sched: [100:?]
; ZNVER1-NEXT:    retq # sched: [1:0.50]
  %call = call {i64, i32} @llvm.x86.rdrand.64()
  %randval = extractvalue {i64, i32} %call, 0
  ret i64 %randval
}
