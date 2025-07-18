; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt -S -passes=loop-fusion -loop-fusion-peel-max-count=3 < %s | FileCheck %s

; Tests whether we can fuse two loops together if they have constant but a
; different tripcount.
; The first three iterations of the first loop should be peeled, and then the
; two loops should be fused together in this example.

; C Code
;
; int B[1024];
;
; void function(int *arg) {
;   for (int i = 0; i != 100; ++i)
;     arg[i] = ((i - 3)*(i+3)) % i;
;
;   for (int i = 3; i != 100; ++i)
;     B[i] = ((i-6)*(i+3)) % i;
; }


@B = common global [1024 x i32] zeroinitializer, align 16

define void @function(ptr noalias %arg) {
; CHECK-LABEL: define void @function(
; CHECK-SAME: ptr noalias [[ARG:%.*]]) {
; CHECK-NEXT:  [[FOR_FIRST_PREHEADER:.*:]]
; CHECK-NEXT:    br label %[[FOR_FIRST_PEEL_BEGIN:.*]]
; CHECK:       [[FOR_FIRST_PEEL_BEGIN]]:
; CHECK-NEXT:    br label %[[FOR_FIRST_PEEL:.*]]
; CHECK:       [[FOR_FIRST_PEEL]]:
; CHECK-NEXT:    [[TMP_PEEL:%.*]] = add nsw i32 0, -3
; CHECK-NEXT:    [[TMP8_PEEL:%.*]] = add nuw nsw i64 0, 3
; CHECK-NEXT:    [[TMP9_PEEL:%.*]] = trunc i64 [[TMP8_PEEL]] to i32
; CHECK-NEXT:    [[TMP10_PEEL:%.*]] = mul nsw i32 [[TMP_PEEL]], [[TMP9_PEEL]]
; CHECK-NEXT:    [[TMP11_PEEL:%.*]] = trunc i64 0 to i32
; CHECK-NEXT:    [[TMP12_PEEL:%.*]] = srem i32 [[TMP10_PEEL]], [[TMP11_PEEL]]
; CHECK-NEXT:    [[TMP13_PEEL:%.*]] = getelementptr inbounds i32, ptr [[ARG]], i64 0
; CHECK-NEXT:    store i32 [[TMP12_PEEL]], ptr [[TMP13_PEEL]], align 4
; CHECK-NEXT:    br label %[[FOR_FIRST_LATCH_PEEL:.*]]
; CHECK:       [[FOR_FIRST_LATCH_PEEL]]:
; CHECK-NEXT:    [[INDVARS_IV_NEXT3_PEEL:%.*]] = add nuw nsw i64 0, 1
; CHECK-NEXT:    [[TMP15_PEEL:%.*]] = add nuw nsw i32 0, 1
; CHECK-NEXT:    [[EXITCOND4_PEEL:%.*]] = icmp ne i64 [[INDVARS_IV_NEXT3_PEEL]], 100
; CHECK-NEXT:    br label %[[FOR_FIRST_PEEL_NEXT:.*]]
; CHECK:       [[FOR_FIRST_PEEL_NEXT]]:
; CHECK-NEXT:    br label %[[FOR_FIRST_PEEL2:.*]]
; CHECK:       [[FOR_FIRST_PEEL2]]:
; CHECK-NEXT:    [[TMP_PEEL3:%.*]] = add nsw i32 [[TMP15_PEEL]], -3
; CHECK-NEXT:    [[TMP8_PEEL4:%.*]] = add nuw nsw i64 [[INDVARS_IV_NEXT3_PEEL]], 3
; CHECK-NEXT:    [[TMP9_PEEL5:%.*]] = trunc i64 [[TMP8_PEEL4]] to i32
; CHECK-NEXT:    [[TMP10_PEEL6:%.*]] = mul nsw i32 [[TMP_PEEL3]], [[TMP9_PEEL5]]
; CHECK-NEXT:    [[TMP11_PEEL7:%.*]] = trunc i64 [[INDVARS_IV_NEXT3_PEEL]] to i32
; CHECK-NEXT:    [[TMP12_PEEL8:%.*]] = srem i32 [[TMP10_PEEL6]], [[TMP11_PEEL7]]
; CHECK-NEXT:    [[TMP13_PEEL9:%.*]] = getelementptr inbounds i32, ptr [[ARG]], i64 [[INDVARS_IV_NEXT3_PEEL]]
; CHECK-NEXT:    store i32 [[TMP12_PEEL8]], ptr [[TMP13_PEEL9]], align 4
; CHECK-NEXT:    br label %[[FOR_FIRST_LATCH_PEEL10:.*]]
; CHECK:       [[FOR_FIRST_LATCH_PEEL10]]:
; CHECK-NEXT:    [[INDVARS_IV_NEXT3_PEEL11:%.*]] = add nuw nsw i64 [[INDVARS_IV_NEXT3_PEEL]], 1
; CHECK-NEXT:    [[TMP15_PEEL12:%.*]] = add nuw nsw i32 [[TMP15_PEEL]], 1
; CHECK-NEXT:    [[EXITCOND4_PEEL13:%.*]] = icmp ne i64 [[INDVARS_IV_NEXT3_PEEL11]], 100
; CHECK-NEXT:    br label %[[FOR_FIRST_PEEL_NEXT1:.*]]
; CHECK:       [[FOR_FIRST_PEEL_NEXT1]]:
; CHECK-NEXT:    br label %[[FOR_FIRST_PEEL15:.*]]
; CHECK:       [[FOR_FIRST_PEEL15]]:
; CHECK-NEXT:    [[TMP_PEEL16:%.*]] = add nsw i32 [[TMP15_PEEL12]], -3
; CHECK-NEXT:    [[TMP8_PEEL17:%.*]] = add nuw nsw i64 [[INDVARS_IV_NEXT3_PEEL11]], 3
; CHECK-NEXT:    [[TMP9_PEEL18:%.*]] = trunc i64 [[TMP8_PEEL17]] to i32
; CHECK-NEXT:    [[TMP10_PEEL19:%.*]] = mul nsw i32 [[TMP_PEEL16]], [[TMP9_PEEL18]]
; CHECK-NEXT:    [[TMP11_PEEL20:%.*]] = trunc i64 [[INDVARS_IV_NEXT3_PEEL11]] to i32
; CHECK-NEXT:    [[TMP12_PEEL21:%.*]] = srem i32 [[TMP10_PEEL19]], [[TMP11_PEEL20]]
; CHECK-NEXT:    [[TMP13_PEEL22:%.*]] = getelementptr inbounds i32, ptr [[ARG]], i64 [[INDVARS_IV_NEXT3_PEEL11]]
; CHECK-NEXT:    store i32 [[TMP12_PEEL21]], ptr [[TMP13_PEEL22]], align 4
; CHECK-NEXT:    br label %[[FOR_FIRST_LATCH_PEEL23:.*]]
; CHECK:       [[FOR_FIRST_LATCH_PEEL23]]:
; CHECK-NEXT:    [[INDVARS_IV_NEXT3_PEEL24:%.*]] = add nuw nsw i64 [[INDVARS_IV_NEXT3_PEEL11]], 1
; CHECK-NEXT:    [[TMP15_PEEL25:%.*]] = add nuw nsw i32 [[TMP15_PEEL12]], 1
; CHECK-NEXT:    [[EXITCOND4_PEEL26:%.*]] = icmp ne i64 [[INDVARS_IV_NEXT3_PEEL24]], 100
; CHECK-NEXT:    br label %[[FOR_FIRST_PEEL_NEXT14:.*]]
; CHECK:       [[FOR_FIRST_PEEL_NEXT14]]:
; CHECK-NEXT:    br label %[[FOR_FIRST_PEEL_NEXT27:.*]]
; CHECK:       [[FOR_FIRST_PEEL_NEXT27]]:
; CHECK-NEXT:    br label %[[FOR_FIRST_PREHEADER_PEEL_NEWPH:.*]]
; CHECK:       [[FOR_FIRST_PREHEADER_PEEL_NEWPH]]:
; CHECK-NEXT:    br label %[[FOR_FIRST:.*]]
; CHECK:       [[FOR_FIRST]]:
; CHECK-NEXT:    [[DOT014:%.*]] = phi i32 [ [[TMP15_PEEL25]], %[[FOR_FIRST_PREHEADER_PEEL_NEWPH]] ], [ [[TMP15:%.*]], %[[FOR_SECOND_LATCH:.*]] ]
; CHECK-NEXT:    [[INDVARS_IV23:%.*]] = phi i64 [ [[INDVARS_IV_NEXT3_PEEL24]], %[[FOR_FIRST_PREHEADER_PEEL_NEWPH]] ], [ [[INDVARS_IV_NEXT3:%.*]], %[[FOR_SECOND_LATCH]] ]
; CHECK-NEXT:    [[DOT02:%.*]] = phi i32 [ 0, %[[FOR_FIRST_PREHEADER_PEEL_NEWPH]] ], [ [[TMP28:%.*]], %[[FOR_SECOND_LATCH]] ]
; CHECK-NEXT:    [[INDVARS_IV1:%.*]] = phi i64 [ 3, %[[FOR_FIRST_PREHEADER_PEEL_NEWPH]] ], [ [[INDVARS_IV_NEXT:%.*]], %[[FOR_SECOND_LATCH]] ]
; CHECK-NEXT:    [[TMP:%.*]] = add nsw i32 [[DOT014]], -3
; CHECK-NEXT:    [[TMP8:%.*]] = add nuw nsw i64 [[INDVARS_IV23]], 3
; CHECK-NEXT:    [[TMP9:%.*]] = trunc i64 [[TMP8]] to i32
; CHECK-NEXT:    [[TMP10:%.*]] = mul nsw i32 [[TMP]], [[TMP9]]
; CHECK-NEXT:    [[TMP11:%.*]] = trunc i64 [[INDVARS_IV23]] to i32
; CHECK-NEXT:    [[TMP12:%.*]] = srem i32 [[TMP10]], [[TMP11]]
; CHECK-NEXT:    [[TMP13:%.*]] = getelementptr inbounds i32, ptr [[ARG]], i64 [[INDVARS_IV23]]
; CHECK-NEXT:    store i32 [[TMP12]], ptr [[TMP13]], align 4
; CHECK-NEXT:    br label %[[FOR_FIRST_LATCH:.*]]
; CHECK:       [[FOR_FIRST_LATCH]]:
; CHECK-NEXT:    [[TMP20:%.*]] = add nsw i32 [[DOT02]], -3
; CHECK-NEXT:    [[TMP21:%.*]] = add nuw nsw i64 [[INDVARS_IV1]], 3
; CHECK-NEXT:    [[TMP22:%.*]] = trunc i64 [[TMP21]] to i32
; CHECK-NEXT:    [[TMP23:%.*]] = mul nsw i32 [[TMP20]], [[TMP22]]
; CHECK-NEXT:    [[TMP24:%.*]] = trunc i64 [[INDVARS_IV1]] to i32
; CHECK-NEXT:    [[TMP25:%.*]] = srem i32 [[TMP23]], [[TMP24]]
; CHECK-NEXT:    [[TMP26:%.*]] = getelementptr inbounds [1024 x i32], ptr @B, i64 0, i64 [[INDVARS_IV1]]
; CHECK-NEXT:    store i32 [[TMP25]], ptr [[TMP26]], align 4
; CHECK-NEXT:    br label %[[FOR_SECOND_LATCH]]
; CHECK:       [[FOR_SECOND_LATCH]]:
; CHECK-NEXT:    [[INDVARS_IV_NEXT3]] = add nuw nsw i64 [[INDVARS_IV23]], 1
; CHECK-NEXT:    [[TMP15]] = add nuw nsw i32 [[DOT014]], 1
; CHECK-NEXT:    [[EXITCOND4:%.*]] = icmp ne i64 [[INDVARS_IV_NEXT3]], 100
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV1]], 1
; CHECK-NEXT:    [[TMP28]] = add nuw nsw i32 [[DOT02]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp ne i64 [[INDVARS_IV_NEXT]], 100
; CHECK-NEXT:    br i1 [[EXITCOND]], label %[[FOR_FIRST]], label %[[FOR_END:.*]]
; CHECK:       [[FOR_END]]:
; CHECK-NEXT:    ret void
;
for.first.preheader:
  br label %for.first

for.first:                                       ; preds = %for.first.preheader, %for.first.latch
  %.014 = phi i32 [ 0, %for.first.preheader ], [ %tmp15, %for.first.latch ]
  %indvars.iv23 = phi i64 [ 0, %for.first.preheader ], [ %indvars.iv.next3, %for.first.latch ]
  %tmp = add nsw i32 %.014, -3
  %tmp8 = add nuw nsw i64 %indvars.iv23, 3
  %tmp9 = trunc i64 %tmp8 to i32
  %tmp10 = mul nsw i32 %tmp, %tmp9
  %tmp11 = trunc i64 %indvars.iv23 to i32
  %tmp12 = srem i32 %tmp10, %tmp11
  %tmp13 = getelementptr inbounds i32, ptr %arg, i64 %indvars.iv23
  store i32 %tmp12, ptr %tmp13, align 4
  br label %for.first.latch

for.first.latch:                                 ; preds = %for.first
  %indvars.iv.next3 = add nuw nsw i64 %indvars.iv23, 1
  %tmp15 = add nuw nsw i32 %.014, 1
  %exitcond4 = icmp ne i64 %indvars.iv.next3, 100
  br i1 %exitcond4, label %for.first, label %for.second.preheader

for.second.preheader:                            ; preds = %for.first.latch
  br label %for.second

for.second:                                      ; preds = %for.second.preheader, %for.second.latch
  %.02 = phi i32 [ 0, %for.second.preheader ], [ %tmp28, %for.second.latch ]
  %indvars.iv1 = phi i64 [ 3, %for.second.preheader ], [ %indvars.iv.next, %for.second.latch ]
  %tmp20 = add nsw i32 %.02, -3
  %tmp21 = add nuw nsw i64 %indvars.iv1, 3
  %tmp22 = trunc i64 %tmp21 to i32
  %tmp23 = mul nsw i32 %tmp20, %tmp22
  %tmp24 = trunc i64 %indvars.iv1 to i32
  %tmp25 = srem i32 %tmp23, %tmp24
  %tmp26 = getelementptr inbounds [1024 x i32], ptr @B, i64 0, i64 %indvars.iv1
  store i32 %tmp25, ptr %tmp26, align 4
  br label %for.second.latch

for.second.latch:                                ; preds = %for.second
  %indvars.iv.next = add nuw nsw i64 %indvars.iv1, 1
  %tmp28 = add nuw nsw i32 %.02, 1
  %exitcond = icmp ne i64 %indvars.iv.next, 100
  br i1 %exitcond, label %for.second, label %for.end

for.end:                                        ; preds = %for.second.latch
  ret void
}
