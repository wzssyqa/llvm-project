; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt -mtriple=x86_64-pc-linux-gnu -passes=pre-isel-intrinsic-lowering -S -o - %s | FileCheck %s

; Constant length memset.inline should be left unmodified.
define void @memset_32(ptr %a, i8 %value) nounwind {
; CHECK-LABEL: define void @memset_32(
; CHECK-SAME: ptr [[A:%.*]], i8 [[VALUE:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:    call void @llvm.memset.inline.p0.i64(ptr [[A]], i8 [[VALUE]], i64 32, i1 false)
; CHECK-NEXT:    tail call void @llvm.memset.inline.p0.i64(ptr [[A]], i8 [[VALUE]], i64 32, i1 true)
; CHECK-NEXT:    ret void
;
  call void @llvm.memset.inline.p0.i64(ptr %a, i8 %value, i64 32, i1 0)
  tail call void @llvm.memset.inline.p0.i64(ptr %a, i8 %value, i64 32, i1 1)
  ret void
}

define void @memset_x(ptr %a, i8 %value, i64 %x) nounwind {
; CHECK-LABEL: define void @memset_x(
; CHECK-SAME: ptr [[A:%.*]], i8 [[VALUE:%.*]], i64 [[X:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[TMP1:%.*]] = icmp eq i64 0, [[X]]
; CHECK-NEXT:    br i1 [[TMP1]], label %[[SPLIT:.*]], label %[[LOADSTORELOOP:.*]]
; CHECK:       [[LOADSTORELOOP]]:
; CHECK-NEXT:    [[TMP2:%.*]] = phi i64 [ 0, [[TMP0:%.*]] ], [ [[TMP4:%.*]], %[[LOADSTORELOOP]] ]
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds i8, ptr [[A]], i64 [[TMP2]]
; CHECK-NEXT:    store i8 [[VALUE]], ptr [[TMP3]], align 1
; CHECK-NEXT:    [[TMP4]] = add i64 [[TMP2]], 1
; CHECK-NEXT:    [[TMP5:%.*]] = icmp ult i64 [[TMP4]], [[X]]
; CHECK-NEXT:    br i1 [[TMP5]], label %[[LOADSTORELOOP]], label %[[SPLIT]]
; CHECK:       [[SPLIT]]:
; CHECK-NEXT:    [[TMP6:%.*]] = icmp eq i64 0, [[X]]
; CHECK-NEXT:    br i1 [[TMP6]], label %[[SPLIT1:.*]], label %[[LOADSTORELOOP2:.*]]
; CHECK:       [[LOADSTORELOOP2]]:
; CHECK-NEXT:    [[TMP7:%.*]] = phi i64 [ 0, %[[SPLIT]] ], [ [[TMP9:%.*]], %[[LOADSTORELOOP2]] ]
; CHECK-NEXT:    [[TMP8:%.*]] = getelementptr inbounds i8, ptr [[A]], i64 [[TMP7]]
; CHECK-NEXT:    store volatile i8 [[VALUE]], ptr [[TMP8]], align 1
; CHECK-NEXT:    [[TMP9]] = add i64 [[TMP7]], 1
; CHECK-NEXT:    [[TMP10:%.*]] = icmp ult i64 [[TMP9]], [[X]]
; CHECK-NEXT:    br i1 [[TMP10]], label %[[LOADSTORELOOP2]], label %[[SPLIT1]]
; CHECK:       [[SPLIT1]]:
; CHECK-NEXT:    ret void
;
  call void @llvm.memset.inline.p0.i64(ptr %a, i8 %value, i64 %x, i1 0)
  tail call void @llvm.memset.inline.p0.i64(ptr %a, i8 %value, i64 %x, i1 1)
  ret void
}
