; RUN: opt %loadPolly -polly-print-scops -polly-print-import-jscop -polly-import-jscop-postfix=transformed -disable-output < %s 2>&1 | FileCheck %s
; RUN: opt %loadPolly -polly-import-jscop -polly-import-jscop-postfix=transformed -polly-codegen -S < %s 2>&1 | FileCheck %s --check-prefix=CODEGEN
;
;  for (i = 0; i < _PB_NI; i++)
;    for (j = 0; j < _PB_NJ; j++)
;      for (k = 0; k < _PB_NK; ++k)
;        B[i][j] = beta * A[i][k];
;
;
; CHECK:    Arrays {
; CHECK:        double MemRef_B[*][1024]; // Element size 8
; CHECK:        double MemRef_beta; // Element size 8
; CHECK:        double MemRef_A[*][1056]; // Element size 8
; CHECK:        double D[270336]; // Element size 8
; CHECK:        double E[270336][200000]; // Element size 8
; CHECK:        i64 F[270336]; // Element size 8
;
; CHECK:New access function '{ Stmt_bb12[i0, i1, i2] -> E[i2, i0] }' detected in JSCOP file
;
; CODEGEN:define internal void @create_arrays(i32 %arg, i32 %arg1, i32 %arg2, double %arg3, double %beta, ptr %A, ptr %B, ptr %arg7) #0 {
; CODEGEN:bb:
; CODEGEN:  %beta.s2a = alloca double
; CODEGEN:  %D = alloca [270336 x double]
; CODEGEN:  %E = alloca [270336 x [200000 x double]]
; CODEGEN:  %F = alloca [270336 x i64]
; CODEGEN:  br label %bb8
;
; CODEGEN:  %beta.s2a.reload = load double, ptr %beta.s2a
; CODEGEN:  %polly.access.mul.E = mul nsw i64 %polly.indvar31, 200000
; CODEGEN:  %polly.access.add.E = add nsw i64 %polly.access.mul.E, %polly.indvar
; CODEGEN:  {{%.*}} = load double, ptr %polly.access.E, align 8, !alias.scope !4, !noalias !7
; CODEGEN:  store double {{%.*}}, ptr %scevgep34, align 8, !alias.scope !12, !noalias !13
;
; CODEGEN: !0 = distinct !{!0, !1}
; CODEGEN: !1 = !{!"llvm.loop.vectorize.enable", i32 0}
; CODEGEN: !2 = distinct !{!2, !1}
; CODEGEN: !3 = distinct !{!3, !1}
; CODEGEN: !4 = !{!5}
; CODEGEN: !5 = distinct !{!5, !6, !"polly.alias.scope.E"}
; CODEGEN: !6 = distinct !{!6, !"polly.alias.scope.domain"}
; CODEGEN: !7 = !{!8, !9, !10, !11}
; CODEGEN: !8 = distinct !{!8, !6, !"polly.alias.scope.MemRef_B"}
; CODEGEN: !9 = distinct !{!9, !6, !"polly.alias.scope.MemRef_A"}
; CODEGEN: !10 = distinct !{!10, !6, !"polly.alias.scope.D"}
; CODEGEN: !11 = distinct !{!11, !6, !"polly.alias.scope.F"}
; CODEGEN: !12 = !{!9}
; CODEGEN: !13 = !{!8, !10, !5, !11}
;
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-unknown"

; Function Attrs: nounwind uwtable
define internal void @create_arrays(i32 %arg, i32 %arg1, i32 %arg2, double %arg3, double %beta, ptr %A, ptr %B, ptr %arg7) #0 {
bb:
  br label %bb8

bb8:                                              ; preds = %bb
  br label %bb9

bb9:                                              ; preds = %bb23, %bb8
  %tmp = phi i64 [ 0, %bb8 ], [ %tmp24, %bb23 ]
  br label %bb10

bb10:                                             ; preds = %bb20, %bb9
  %tmp11 = phi i64 [ 0, %bb9 ], [ %tmp21, %bb20 ]
  br label %bb12

bb12:                                             ; preds = %bb12, %bb10
  %tmp13 = phi i64 [ 0, %bb10 ], [ %tmp18, %bb12 ]
  %tmp14 = getelementptr inbounds [1024 x double], ptr %B, i64 %tmp, i64 %tmp13
  %tmp15 = load double, ptr %tmp14, align 8
  %tmp16 = fmul double %tmp15, %beta
  %tmp17 = getelementptr inbounds [1056 x double], ptr %A, i64 %tmp, i64 %tmp11
  store double %tmp16, ptr %tmp17, align 8
  %tmp18 = add nuw nsw i64 %tmp13, 1
  %tmp19 = icmp ne i64 %tmp18, 1024
  br i1 %tmp19, label %bb12, label %bb20

bb20:                                             ; preds = %bb12
  %tmp21 = add nuw nsw i64 %tmp11, 1
  %tmp22 = icmp ne i64 %tmp21, 1056
  br i1 %tmp22, label %bb10, label %bb23

bb23:                                             ; preds = %bb20
  %tmp24 = add nuw nsw i64 %tmp, 1
  %tmp25 = icmp ne i64 %tmp24, 1056
  br i1 %tmp25, label %bb9, label %bb26

bb26:                                             ; preds = %bb23
  ret void
}

attributes #0 = { nounwind uwtable "target-cpu"="x86-64" "target-features"="+aes,+avx,+cmov,+cx16,+fxsr,+mmx,+pclmul,+popcnt,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87,+xsave,+xsaveopt" }
