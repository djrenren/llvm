; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -O0 -mtriple=powerpc64le-unknown-linux-gnu < %s | FileCheck %s

; xscvdpsxds should NOT be emitted, since it saturates the result down to i64.
define float @f_i128_f(float %v) {
; CHECK-LABEL: f_i128_f:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    friz 1, 1
; CHECK-NEXT:    blr
entry:
  %a = fptosi float %v to i128
  %b = sitofp i128 %a to float
  ret float %b
}