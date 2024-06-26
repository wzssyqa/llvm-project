; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64 -mcpu=apple-m1 -mattr=+store-pair-suppress -o - %s | FileCheck %s

; Check that stp are not suppressed at minsize.

define void @test_default(ptr %dst, <8 x i32> %v0) {
; CHECK-LABEL: test_default:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    uzp1 v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    xtn v0.8b, v0.8h
; CHECK-NEXT:    mul v1.8b, v0.8b, v0.8b
; CHECK-NEXT:    str d1, [x0, #8]
; CHECK-NEXT:    str d0, [x0]
; CHECK-NEXT:    ret
entry:
  %add.ptr.1 = getelementptr i8, ptr %dst, i64 8
  %t = trunc <8 x i32> %v0 to <8 x i8>
  %mul = mul <8 x i8> %t, %t
  store <8 x i8> %mul, ptr %add.ptr.1, align 1
  store <8 x i8> %t, ptr %dst, align 1
  ret void
}

define void @test_minsize(ptr %dst, <8 x i32> %v0) minsize {
; CHECK-LABEL: test_minsize:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    uzp1 v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    xtn v0.8b, v0.8h
; CHECK-NEXT:    mul v1.8b, v0.8b, v0.8b
; CHECK-NEXT:    stp d0, d1, [x0]
; CHECK-NEXT:    ret
entry:
  %add.ptr.1 = getelementptr i8, ptr %dst, i64 8
  %t = trunc <8 x i32> %v0 to <8 x i8>
  %mul = mul <8 x i8> %t, %t
  store <8 x i8> %mul, ptr %add.ptr.1, align 1
  store <8 x i8> %t, ptr %dst, align 1
  ret void
}

define void @test_optsize(ptr %dst, <8 x i32> %v0) optsize {
; CHECK-LABEL: test_optsize:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    uzp1 v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    xtn v0.8b, v0.8h
; CHECK-NEXT:    mul v1.8b, v0.8b, v0.8b
; CHECK-NEXT:    stp d0, d1, [x0]
; CHECK-NEXT:    ret
entry:
  %add.ptr.1 = getelementptr i8, ptr %dst, i64 8
  %t = trunc <8 x i32> %v0 to <8 x i8>
  %mul = mul <8 x i8> %t, %t
  store <8 x i8> %mul, ptr %add.ptr.1, align 1
  store <8 x i8> %t, ptr %dst, align 1
  ret void
}
