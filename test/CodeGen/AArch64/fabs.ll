; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-unknown-unknown | FileCheck %s

; Test against PR36600: https://bugs.llvm.org/show_bug.cgi?id=36600
; This is not fabs. If X = -0.0, it should return -0.0 not 0.0.

define double @not_fabs(double %x) #0 {
; CHECK-LABEL: not_fabs:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fneg d1, d0
; CHECK-NEXT:    fcmp d0, #0.0
; CHECK-NEXT:    fcsel d0, d1, d0, le
; CHECK-NEXT:    ret
  %cmp = fcmp nnan ole double %x, 0.0
  %sub = fsub nnan double -0.0, %x
  %cond = select i1 %cmp, double %sub, double %x
  ret double %cond
}

; Try again with different type, predicate, and compare constant.

define float @still_not_fabs(float %x) #0 {
; CHECK-LABEL: still_not_fabs:
; CHECK:       // %bb.0:
; CHECK-NEXT:    adrp x8, .LCPI1_0
; CHECK-NEXT:    ldr s1, [x8, :lo12:.LCPI1_0]
; CHECK-NEXT:    fneg s2, s0
; CHECK-NEXT:    fcmp s0, s1
; CHECK-NEXT:    fcsel s0, s0, s2, ge
; CHECK-NEXT:    ret
  %cmp = fcmp nnan oge float %x, -0.0
  %sub = fsub nnan float -0.0, %x
  %cond = select i1 %cmp, float %x, float %sub
  ret float %cond
}

attributes #0 = { "no-nans-fp-math"="true" }
