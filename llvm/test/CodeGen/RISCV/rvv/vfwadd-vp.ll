; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=riscv64 -mattr=+v,+zvfh,+zvfbfmin | FileCheck %s --check-prefixes=CHECK,ZVFH
; RUN: llc < %s -mtriple=riscv64 -mattr=+v,+zvfhmin,+zvfbfmin | FileCheck %s --check-prefixes=CHECK,ZVFHMIN

define <vscale x 2 x float> @vfwadd_same_operand_nxv2bf16(<vscale x 2 x bfloat> %arg, i32 signext %vl) {
; CHECK-LABEL: vfwadd_same_operand_nxv2bf16:
; CHECK:       # %bb.0: # %bb
; CHECK-NEXT:    slli a0, a0, 32
; CHECK-NEXT:    srli a0, a0, 32
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vfwcvtbf16.f.f.v v9, v8
; CHECK-NEXT:    vsetvli zero, zero, e32, m1, ta, ma
; CHECK-NEXT:    vfadd.vv v8, v9, v9
; CHECK-NEXT:    ret
bb:
  %tmp = call <vscale x 2 x float> @llvm.vp.fpext.nxv2f32.nxv2bf16(<vscale x 2 x bfloat> %arg, <vscale x 2 x i1> splat (i1 true), i32 %vl)
  %tmp2 = call <vscale x 2 x float> @llvm.vp.fadd.nxv2f32(<vscale x 2 x float> %tmp, <vscale x 2 x float> %tmp, <vscale x 2 x i1> splat (i1 true), i32 %vl)
  ret <vscale x 2 x float> %tmp2
}

; Make sure we don't widen vfmadd.vv -> vfwmaccvbf16.vv if there's other
; unwidenable uses
define <vscale x 2 x float> @vfwadd_same_operand_nxv2bf16_multiuse(<vscale x 2 x bfloat> %arg, <vscale x 2 x float> %acc, i32 signext %vl, ptr %p) {
; CHECK-LABEL: vfwadd_same_operand_nxv2bf16_multiuse:
; CHECK:       # %bb.0: # %bb
; CHECK-NEXT:    slli a0, a0, 32
; CHECK-NEXT:    srli a0, a0, 32
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vfwcvtbf16.f.f.v v10, v8
; CHECK-NEXT:    vsetvli zero, zero, e32, m1, ta, ma
; CHECK-NEXT:    vfadd.vv v8, v10, v10
; CHECK-NEXT:    vfmadd.vv v10, v10, v9
; CHECK-NEXT:    vs1r.v v10, (a1)
; CHECK-NEXT:    ret
bb:
  %tmp = call <vscale x 2 x float> @llvm.vp.fpext.nxv2f32.nxv2bf16(<vscale x 2 x bfloat> %arg, <vscale x 2 x i1> splat (i1 true), i32 %vl)
  %tmp2 = call <vscale x 2 x float> @llvm.vp.fadd.nxv2f32(<vscale x 2 x float> %tmp, <vscale x 2 x float> %tmp, <vscale x 2 x i1> splat (i1 true), i32 %vl)
  %tmp3 = call <vscale x 2 x float> @llvm.vp.fma.nxv2f32(<vscale x 2 x float> %tmp, <vscale x 2 x float> %tmp, <vscale x 2 x float> %acc, <vscale x 2 x i1> splat (i1 true), i32 %vl)
  store <vscale x 2 x float> %tmp3, ptr %p
  ret <vscale x 2 x float> %tmp2
}

define <vscale x 2 x float> @vfwadd_same_operand(<vscale x 2 x half> %arg, i32 signext %vl) {
; ZVFH-LABEL: vfwadd_same_operand:
; ZVFH:       # %bb.0: # %bb
; ZVFH-NEXT:    slli a0, a0, 32
; ZVFH-NEXT:    srli a0, a0, 32
; ZVFH-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; ZVFH-NEXT:    vfwadd.vv v9, v8, v8
; ZVFH-NEXT:    vmv1r.v v8, v9
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfwadd_same_operand:
; ZVFHMIN:       # %bb.0: # %bb
; ZVFHMIN-NEXT:    slli a0, a0, 32
; ZVFHMIN-NEXT:    srli a0, a0, 32
; ZVFHMIN-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfadd.vv v8, v9, v9
; ZVFHMIN-NEXT:    ret
bb:
  %tmp = call <vscale x 2 x float> @llvm.vp.fpext.nxv2f32.nxv2f16(<vscale x 2 x half> %arg, <vscale x 2 x i1> splat (i1 true), i32 %vl)
  %tmp2 = call <vscale x 2 x float> @llvm.vp.fadd.nxv2f32(<vscale x 2 x float> %tmp, <vscale x 2 x float> %tmp, <vscale x 2 x i1> splat (i1 true), i32 %vl)
  ret <vscale x 2 x float> %tmp2
}

define <vscale x 2 x float> @vfwadd_tu(<vscale x 2 x half> %arg, <vscale x 2 x float> %arg1, i32 signext %arg2) {
; ZVFH-LABEL: vfwadd_tu:
; ZVFH:       # %bb.0: # %bb
; ZVFH-NEXT:    slli a0, a0, 32
; ZVFH-NEXT:    srli a0, a0, 32
; ZVFH-NEXT:    vsetvli zero, a0, e16, mf2, tu, ma
; ZVFH-NEXT:    vfwadd.wv v9, v9, v8
; ZVFH-NEXT:    vmv1r.v v8, v9
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfwadd_tu:
; ZVFHMIN:       # %bb.0: # %bb
; ZVFHMIN-NEXT:    slli a0, a0, 32
; ZVFHMIN-NEXT:    srli a0, a0, 32
; ZVFHMIN-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m1, tu, ma
; ZVFHMIN-NEXT:    vfadd.vv v9, v9, v10
; ZVFHMIN-NEXT:    vmv1r.v v8, v9
; ZVFHMIN-NEXT:    ret
bb:
  %tmp = call <vscale x 2 x float> @llvm.vp.fpext.nxv2f32.nxv2f16(<vscale x 2 x half> %arg, <vscale x 2 x i1> splat (i1 true), i32 %arg2)
  %tmp3 = call <vscale x 2 x float> @llvm.vp.fadd.nxv2f32(<vscale x 2 x float> %arg1, <vscale x 2 x float> %tmp, <vscale x 2 x i1> splat (i1 true), i32 %arg2)
  %tmp4 = call <vscale x 2 x float> @llvm.vp.merge.nxv2f32(<vscale x 2 x i1> splat (i1 true), <vscale x 2 x float> %tmp3, <vscale x 2 x float> %arg1, i32 %arg2)
  ret <vscale x 2 x float> %tmp4
}

declare <vscale x 2 x float> @llvm.vp.fpext.nxv2f32.nxv2f16(<vscale x 2 x half>, <vscale x 2 x i1>, i32)
declare <vscale x 2 x float> @llvm.vp.fadd.nxv2f32(<vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x i1>, i32)
declare <vscale x 2 x float> @llvm.vp.merge.nxv2f32(<vscale x 2 x i1>, <vscale x 2 x float>, <vscale x 2 x float>, i32)
