; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt -S -mtriple=amdgcn-amd-amdhsa -mcpu=gfx942 -passes=instcombine < %s | FileCheck %s

define i16 @extract_elt0_v2i16_readfirstlane(<2 x i16> %src) {
; CHECK-LABEL: define i16 @extract_elt0_v2i16_readfirstlane(
; CHECK-SAME: <2 x i16> [[SRC:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:    [[TMP1:%.*]] = extractelement <2 x i16> [[SRC]], i64 0
; CHECK-NEXT:    [[ELT:%.*]] = call i16 @llvm.amdgcn.readfirstlane.i16(i16 [[TMP1]])
; CHECK-NEXT:    ret i16 [[ELT]]
;
  %vec = call <2 x i16> @llvm.amdgcn.readfirstlane.v2i16(<2 x i16> %src)
  %elt = extractelement <2 x i16> %vec, i32 0
  ret i16 %elt
}

define i16 @extract_elt0_v1i16_readfirstlane(<1 x i16> %src) {
; CHECK-LABEL: define i16 @extract_elt0_v1i16_readfirstlane(
; CHECK-SAME: <1 x i16> [[SRC:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[TMP1:%.*]] = extractelement <1 x i16> [[SRC]], i64 0
; CHECK-NEXT:    [[ELT:%.*]] = call i16 @llvm.amdgcn.readfirstlane.i16(i16 [[TMP1]])
; CHECK-NEXT:    ret i16 [[ELT]]
;
  %vec = call <1 x i16> @llvm.amdgcn.readfirstlane.v1i16(<1 x i16> %src)
  %elt = extractelement <1 x i16> %vec, i32 0
  ret i16 %elt
}

define i16 @extract_elt1_v2i16_readfirstlane(<2 x i16> %src) {
; CHECK-LABEL: define i16 @extract_elt1_v2i16_readfirstlane(
; CHECK-SAME: <2 x i16> [[SRC:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[TMP1:%.*]] = extractelement <2 x i16> [[SRC]], i64 1
; CHECK-NEXT:    [[ELT:%.*]] = call i16 @llvm.amdgcn.readfirstlane.i16(i16 [[TMP1]])
; CHECK-NEXT:    ret i16 [[ELT]]
;
  %vec = call <2 x i16> @llvm.amdgcn.readfirstlane.v2i16(<2 x i16> %src)
  %elt = extractelement <2 x i16> %vec, i32 1
  ret i16 %elt
}

define i16 @extract_elt0_v4i16_readfirstlane(<4 x i16> %src) {
; CHECK-LABEL: define i16 @extract_elt0_v4i16_readfirstlane(
; CHECK-SAME: <4 x i16> [[SRC:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[TMP1:%.*]] = extractelement <4 x i16> [[SRC]], i64 0
; CHECK-NEXT:    [[ELT:%.*]] = call i16 @llvm.amdgcn.readfirstlane.i16(i16 [[TMP1]])
; CHECK-NEXT:    ret i16 [[ELT]]
;
  %vec = call <4 x i16> @llvm.amdgcn.readfirstlane.v4i16(<4 x i16> %src)
  %elt = extractelement <4 x i16> %vec, i32 0
  ret i16 %elt
}

define i16 @extract_elt2_v4i16_readfirstlane(<4 x i16> %src) {
; CHECK-LABEL: define i16 @extract_elt2_v4i16_readfirstlane(
; CHECK-SAME: <4 x i16> [[SRC:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[TMP1:%.*]] = extractelement <4 x i16> [[SRC]], i64 2
; CHECK-NEXT:    [[ELT:%.*]] = call i16 @llvm.amdgcn.readfirstlane.i16(i16 [[TMP1]])
; CHECK-NEXT:    ret i16 [[ELT]]
;
  %vec = call <4 x i16> @llvm.amdgcn.readfirstlane.v4i16(<4 x i16> %src)
  %elt = extractelement <4 x i16> %vec, i32 2
  ret i16 %elt
}

define <2 x i16> @extract_elt01_v4i16_readfirstlane(<4 x i16> %src) {
; CHECK-LABEL: define <2 x i16> @extract_elt01_v4i16_readfirstlane(
; CHECK-SAME: <4 x i16> [[SRC:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <4 x i16> [[SRC]], <4 x i16> poison, <2 x i32> <i32 0, i32 1>
; CHECK-NEXT:    [[SHUFFLE:%.*]] = call <2 x i16> @llvm.amdgcn.readfirstlane.v2i16(<2 x i16> [[TMP1]])
; CHECK-NEXT:    ret <2 x i16> [[SHUFFLE]]
;
  %vec = call <4 x i16> @llvm.amdgcn.readfirstlane.v4i16(<4 x i16> %src)
  %shuffle = shufflevector <4 x i16> %vec, <4 x i16> poison, <2 x i32> <i32 0, i32 1>
  ret <2 x i16> %shuffle
}

define <2 x i16> @extract_elt12_v4i16_readfirstlane(<4 x i16> %src) {
; CHECK-LABEL: define <2 x i16> @extract_elt12_v4i16_readfirstlane(
; CHECK-SAME: <4 x i16> [[SRC:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <4 x i16> [[SRC]], <4 x i16> poison, <2 x i32> <i32 1, i32 2>
; CHECK-NEXT:    [[SHUFFLE:%.*]] = call <2 x i16> @llvm.amdgcn.readfirstlane.v2i16(<2 x i16> [[TMP1]])
; CHECK-NEXT:    ret <2 x i16> [[SHUFFLE]]
;
  %vec = call <4 x i16> @llvm.amdgcn.readfirstlane.v4i16(<4 x i16> %src)
  %shuffle = shufflevector <4 x i16> %vec, <4 x i16> poison, <2 x i32> <i32 1, i32 2>
  ret <2 x i16> %shuffle
}

define <2 x i16> @extract_elt23_v4i16_readfirstlane(<4 x i16> %src) {
; CHECK-LABEL: define <2 x i16> @extract_elt23_v4i16_readfirstlane(
; CHECK-SAME: <4 x i16> [[SRC:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <4 x i16> [[SRC]], <4 x i16> poison, <2 x i32> <i32 2, i32 3>
; CHECK-NEXT:    [[SHUFFLE:%.*]] = call <2 x i16> @llvm.amdgcn.readfirstlane.v2i16(<2 x i16> [[TMP1]])
; CHECK-NEXT:    ret <2 x i16> [[SHUFFLE]]
;
  %vec = call <4 x i16> @llvm.amdgcn.readfirstlane.v4i16(<4 x i16> %src)
  %shuffle = shufflevector <4 x i16> %vec, <4 x i16> poison, <2 x i32> <i32 2, i32 3>
  ret <2 x i16> %shuffle
}

define <2 x i16> @extract_elt10_v4i16_readfirstlane(<4 x i16> %src) {
; CHECK-LABEL: define <2 x i16> @extract_elt10_v4i16_readfirstlane(
; CHECK-SAME: <4 x i16> [[SRC:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <4 x i16> [[SRC]], <4 x i16> poison, <2 x i32> <i32 0, i32 1>
; CHECK-NEXT:    [[TMP2:%.*]] = call <2 x i16> @llvm.amdgcn.readfirstlane.v2i16(<2 x i16> [[TMP1]])
; CHECK-NEXT:    [[SHUFFLE:%.*]] = shufflevector <2 x i16> [[TMP2]], <2 x i16> poison, <2 x i32> <i32 1, i32 0>
; CHECK-NEXT:    ret <2 x i16> [[SHUFFLE]]
;
  %vec = call <4 x i16> @llvm.amdgcn.readfirstlane.v4i16(<4 x i16> %src)
  %shuffle = shufflevector <4 x i16> %vec, <4 x i16> poison, <2 x i32> <i32 1, i32 0>
  ret <2 x i16> %shuffle
}

define <2 x i16> @extract_elt32_v4i16_readfirstlane(<4 x i16> %src) {
; CHECK-LABEL: define <2 x i16> @extract_elt32_v4i16_readfirstlane(
; CHECK-SAME: <4 x i16> [[SRC:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <4 x i16> [[SRC]], <4 x i16> poison, <2 x i32> <i32 2, i32 3>
; CHECK-NEXT:    [[TMP2:%.*]] = call <2 x i16> @llvm.amdgcn.readfirstlane.v2i16(<2 x i16> [[TMP1]])
; CHECK-NEXT:    [[VEC:%.*]] = shufflevector <2 x i16> [[TMP2]], <2 x i16> poison, <4 x i32> <i32 poison, i32 poison, i32 0, i32 1>
; CHECK-NEXT:    [[SHUFFLE:%.*]] = shufflevector <4 x i16> [[VEC]], <4 x i16> poison, <2 x i32> <i32 3, i32 2>
; CHECK-NEXT:    ret <2 x i16> [[SHUFFLE]]
;
  %vec = call <4 x i16> @llvm.amdgcn.readfirstlane.v4i16(<4 x i16> %src)
  %shuffle = shufflevector <4 x i16> %vec, <4 x i16> poison, <2 x i32> <i32 3, i32 2>
  ret <2 x i16> %shuffle
}

define <2 x i16> @extract_elt30_v4i16_readfirstlane(<4 x i16> %src) {
; CHECK-LABEL: define <2 x i16> @extract_elt30_v4i16_readfirstlane(
; CHECK-SAME: <4 x i16> [[SRC:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[VEC:%.*]] = call <4 x i16> @llvm.amdgcn.readfirstlane.v4i16(<4 x i16> [[SRC]])
; CHECK-NEXT:    [[SHUFFLE:%.*]] = shufflevector <4 x i16> [[VEC]], <4 x i16> poison, <2 x i32> <i32 3, i32 0>
; CHECK-NEXT:    ret <2 x i16> [[SHUFFLE]]
;
  %vec = call <4 x i16> @llvm.amdgcn.readfirstlane.v4i16(<4 x i16> %src)
  %shuffle = shufflevector <4 x i16> %vec, <4 x i16> poison, <2 x i32> <i32 3, i32 0>
  ret <2 x i16> %shuffle
}

define half @extract_elt0_v2f16_readfirstlane(<2 x half> %src) {
; CHECK-LABEL: define half @extract_elt0_v2f16_readfirstlane(
; CHECK-SAME: <2 x half> [[SRC:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[TMP1:%.*]] = extractelement <2 x half> [[SRC]], i64 0
; CHECK-NEXT:    [[ELT:%.*]] = call half @llvm.amdgcn.readfirstlane.f16(half [[TMP1]])
; CHECK-NEXT:    ret half [[ELT]]
;
  %vec = call <2 x half> @llvm.amdgcn.readfirstlane.v2i16(<2 x half> %src)
  %elt = extractelement <2 x half> %vec, i32 0
  ret half %elt
}

define half @extract_elt1_v2f16_readfirstlane(<2 x half> %src) {
; CHECK-LABEL: define half @extract_elt1_v2f16_readfirstlane(
; CHECK-SAME: <2 x half> [[SRC:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[TMP1:%.*]] = extractelement <2 x half> [[SRC]], i64 1
; CHECK-NEXT:    [[ELT:%.*]] = call half @llvm.amdgcn.readfirstlane.f16(half [[TMP1]])
; CHECK-NEXT:    ret half [[ELT]]
;
  %vec = call <2 x half> @llvm.amdgcn.readfirstlane.v2i16(<2 x half> %src)
  %elt = extractelement <2 x half> %vec, i32 1
  ret half %elt
}

; Don't break on illegal types
define i8 @extract_elt0_v4i8_readfirstlane(<4 x i8> %src) {
; CHECK-LABEL: define i8 @extract_elt0_v4i8_readfirstlane(
; CHECK-SAME: <4 x i8> [[SRC:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[VEC:%.*]] = call <4 x i8> @llvm.amdgcn.readfirstlane.v4i8(<4 x i8> [[SRC]])
; CHECK-NEXT:    [[ELT:%.*]] = extractelement <4 x i8> [[VEC]], i64 0
; CHECK-NEXT:    ret i8 [[ELT]]
;
  %vec = call <4 x i8> @llvm.amdgcn.readfirstlane.v4ii8(<4 x i8> %src)
  %elt = extractelement <4 x i8> %vec, i32 0
  ret i8 %elt
}

; Don't break on illegal types
define i32 @extract_elt0_nxv4i32_readfirstlane(<vscale x 2 x i32> %src) {
; CHECK-LABEL: define i32 @extract_elt0_nxv4i32_readfirstlane(
; CHECK-SAME: <vscale x 2 x i32> [[SRC:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[VEC:%.*]] = call <vscale x 2 x i32> @llvm.amdgcn.readfirstlane.nxv2i32(<vscale x 2 x i32> [[SRC]])
; CHECK-NEXT:    [[ELT:%.*]] = extractelement <vscale x 2 x i32> [[VEC]], i64 0
; CHECK-NEXT:    ret i32 [[ELT]]
;
  %vec = call <vscale x 2 x i32> @llvm.amdgcn.readfirstlane.nxv2i32(<vscale x 2 x i32> %src)
  %elt = extractelement <vscale x 2 x i32> %vec, i32 0
  ret i32 %elt
}

define i32 @extract_elt0_v2i32_readfirstlane(<2 x i32> %src) {
; CHECK-LABEL: define i32 @extract_elt0_v2i32_readfirstlane(
; CHECK-SAME: <2 x i32> [[SRC:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[TMP1:%.*]] = extractelement <2 x i32> [[SRC]], i64 0
; CHECK-NEXT:    [[ELT:%.*]] = call i32 @llvm.amdgcn.readfirstlane.i32(i32 [[TMP1]])
; CHECK-NEXT:    ret i32 [[ELT]]
;
  %vec = call <2 x i32> @llvm.amdgcn.readfirstlane.v2i32(<2 x i32> %src)
  %elt = extractelement <2 x i32> %vec, i32 0
  ret i32 %elt
}

define ptr addrspace(3) @extract_elt0_v2p3_readfirstlane(<2 x ptr addrspace(3)> %src) {
; CHECK-LABEL: define ptr addrspace(3) @extract_elt0_v2p3_readfirstlane(
; CHECK-SAME: <2 x ptr addrspace(3)> [[SRC:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[TMP1:%.*]] = extractelement <2 x ptr addrspace(3)> [[SRC]], i64 0
; CHECK-NEXT:    [[ELT:%.*]] = call ptr addrspace(3) @llvm.amdgcn.readfirstlane.p3(ptr addrspace(3) [[TMP1]])
; CHECK-NEXT:    ret ptr addrspace(3) [[ELT]]
;
  %vec = call <2 x ptr addrspace(3)> @llvm.amdgcn.readfirstlane.v2p3(<2 x ptr addrspace(3)> %src)
  %elt = extractelement <2 x ptr addrspace(3)> %vec, i32 0
  ret ptr addrspace(3) %elt
}

define i64 @extract_elt0_v2i64_readfirstlane(<2 x i64> %src) {
; CHECK-LABEL: define i64 @extract_elt0_v2i64_readfirstlane(
; CHECK-SAME: <2 x i64> [[SRC:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[TMP1:%.*]] = extractelement <2 x i64> [[SRC]], i64 0
; CHECK-NEXT:    [[ELT:%.*]] = call i64 @llvm.amdgcn.readfirstlane.i64(i64 [[TMP1]])
; CHECK-NEXT:    ret i64 [[ELT]]
;
  %vec = call <2 x i64> @llvm.amdgcn.readfirstlane.v2i64(<2 x i64> %src)
  %elt = extractelement <2 x i64> %vec, i32 0
  ret i64 %elt
}

define i64 @extract_elt1_v2i64_readfirstlane(<2 x i64> %src) {
; CHECK-LABEL: define i64 @extract_elt1_v2i64_readfirstlane(
; CHECK-SAME: <2 x i64> [[SRC:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[TMP1:%.*]] = extractelement <2 x i64> [[SRC]], i64 1
; CHECK-NEXT:    [[ELT:%.*]] = call i64 @llvm.amdgcn.readfirstlane.i64(i64 [[TMP1]])
; CHECK-NEXT:    ret i64 [[ELT]]
;
  %vec = call <2 x i64> @llvm.amdgcn.readfirstlane.v2i64(<2 x i64> %src)
  %elt = extractelement <2 x i64> %vec, i32 1
  ret i64 %elt
}

define <3 x i16> @extract_elt012_v4i16_readfirstlane(<4 x i16> %src) {
; CHECK-LABEL: define <3 x i16> @extract_elt012_v4i16_readfirstlane(
; CHECK-SAME: <4 x i16> [[SRC:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[VEC:%.*]] = call <4 x i16> @llvm.amdgcn.readfirstlane.v4i16(<4 x i16> [[SRC]])
; CHECK-NEXT:    [[SHUFFLE:%.*]] = shufflevector <4 x i16> [[VEC]], <4 x i16> poison, <3 x i32> <i32 0, i32 1, i32 2>
; CHECK-NEXT:    ret <3 x i16> [[SHUFFLE]]
;
  %vec = call <4 x i16> @llvm.amdgcn.readfirstlane.v4i16(<4 x i16> %src)
  %shuffle = shufflevector <4 x i16> %vec, <4 x i16> poison, <3 x i32> <i32 0, i32 1, i32 2>
  ret <3 x i16> %shuffle
}

define <3 x i16> @extract_elt123_v4i16_readfirstlane(<4 x i16> %src) {
; CHECK-LABEL: define <3 x i16> @extract_elt123_v4i16_readfirstlane(
; CHECK-SAME: <4 x i16> [[SRC:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[VEC:%.*]] = call <4 x i16> @llvm.amdgcn.readfirstlane.v4i16(<4 x i16> [[SRC]])
; CHECK-NEXT:    [[SHUFFLE:%.*]] = shufflevector <4 x i16> [[VEC]], <4 x i16> poison, <3 x i32> <i32 1, i32 2, i32 3>
; CHECK-NEXT:    ret <3 x i16> [[SHUFFLE]]
;
  %vec = call <4 x i16> @llvm.amdgcn.readfirstlane.v4i16(<4 x i16> %src)
  %shuffle = shufflevector <4 x i16> %vec, <4 x i16> poison, <3 x i32> <i32 1, i32 2, i32 3>
  ret <3 x i16> %shuffle
}

define <3 x i32> @extract_elt012_v4i32_readfirstlane(<4 x i32> %src) {
; CHECK-LABEL: define <3 x i32> @extract_elt012_v4i32_readfirstlane(
; CHECK-SAME: <4 x i32> [[SRC:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <4 x i32> [[SRC]], <4 x i32> poison, <3 x i32> <i32 0, i32 1, i32 2>
; CHECK-NEXT:    [[SHUFFLE:%.*]] = call <3 x i32> @llvm.amdgcn.readfirstlane.v3i32(<3 x i32> [[TMP1]])
; CHECK-NEXT:    ret <3 x i32> [[SHUFFLE]]
;
  %vec = call <4 x i32> @llvm.amdgcn.readfirstlane.v4i32(<4 x i32> %src)
  %shuffle = shufflevector <4 x i32> %vec, <4 x i32> poison, <3 x i32> <i32 0, i32 1, i32 2>
  ret <3 x i32> %shuffle
}

define <3 x i32> @extract_elt123_v4i32_readfirstlane(<4 x i32> %src) {
; CHECK-LABEL: define <3 x i32> @extract_elt123_v4i32_readfirstlane(
; CHECK-SAME: <4 x i32> [[SRC:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <4 x i32> [[SRC]], <4 x i32> poison, <3 x i32> <i32 1, i32 2, i32 3>
; CHECK-NEXT:    [[SHUFFLE:%.*]] = call <3 x i32> @llvm.amdgcn.readfirstlane.v3i32(<3 x i32> [[TMP1]])
; CHECK-NEXT:    ret <3 x i32> [[SHUFFLE]]
;
  %vec = call <4 x i32> @llvm.amdgcn.readfirstlane.v4i32(<4 x i32> %src)
  %shuffle = shufflevector <4 x i32> %vec, <4 x i32> poison, <3 x i32> <i32 1, i32 2, i32 3>
  ret <3 x i32> %shuffle
}

define <2 x i32> @extract_elt13_v4i32_readfirstlane(<4 x i32> %src) {
; CHECK-LABEL: define <2 x i32> @extract_elt13_v4i32_readfirstlane(
; CHECK-SAME: <4 x i32> [[SRC:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <4 x i32> [[SRC]], <4 x i32> poison, <3 x i32> <i32 1, i32 poison, i32 3>
; CHECK-NEXT:    [[TMP2:%.*]] = call <3 x i32> @llvm.amdgcn.readfirstlane.v3i32(<3 x i32> [[TMP1]])
; CHECK-NEXT:    [[VEC:%.*]] = shufflevector <3 x i32> [[TMP2]], <3 x i32> poison, <4 x i32> <i32 poison, i32 0, i32 poison, i32 2>
; CHECK-NEXT:    [[SHUFFLE:%.*]] = shufflevector <4 x i32> [[VEC]], <4 x i32> poison, <2 x i32> <i32 1, i32 3>
; CHECK-NEXT:    ret <2 x i32> [[SHUFFLE]]
;
  %vec = call <4 x i32> @llvm.amdgcn.readfirstlane.v4i32(<4 x i32> %src)
  %shuffle = shufflevector <4 x i32> %vec, <4 x i32> poison, <2 x i32> <i32 1, i32 3>
  ret <2 x i32> %shuffle
}

define <2 x i16> @extract_elt13_v4i16readfirstlane(<4 x i16> %src) {
; CHECK-LABEL: define <2 x i16> @extract_elt13_v4i16readfirstlane(
; CHECK-SAME: <4 x i16> [[SRC:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[VEC:%.*]] = call <4 x i16> @llvm.amdgcn.readfirstlane.v4i16(<4 x i16> [[SRC]])
; CHECK-NEXT:    [[SHUFFLE:%.*]] = shufflevector <4 x i16> [[VEC]], <4 x i16> poison, <2 x i32> <i32 1, i32 3>
; CHECK-NEXT:    ret <2 x i16> [[SHUFFLE]]
;
  %vec = call <4 x i16> @llvm.amdgcn.readfirstlane.v4i16(<4 x i16> %src)
  %shuffle = shufflevector <4 x i16> %vec, <4 x i16> poison, <2 x i32> <i32 1, i32 3>
  ret <2 x i16> %shuffle
}

define <2 x i32> @extract_elt13_v4i32_readfirstlane_source_simplify0(i32 %src0, i32 %src2) {
; CHECK-LABEL: define <2 x i32> @extract_elt13_v4i32_readfirstlane_source_simplify0(
; CHECK-SAME: i32 [[SRC0:%.*]], i32 [[SRC2:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.amdgcn.readfirstlane.i32(i32 [[SRC0]])
; CHECK-NEXT:    [[SHUFFLE:%.*]] = insertelement <2 x i32> poison, i32 [[TMP1]], i64 0
; CHECK-NEXT:    ret <2 x i32> [[SHUFFLE]]
;
  %ins.0 = insertelement <4 x i32> poison, i32 %src0, i32 0
  %ins.1 = insertelement <4 x i32> %ins.0, i32 %src0, i32 1
  %vec = call <4 x i32> @llvm.amdgcn.readfirstlane.v4i32(<4 x i32> %ins.1)
  %shuffle = shufflevector <4 x i32> %vec, <4 x i32> poison, <2 x i32> <i32 1, i32 3>
  ret <2 x i32> %shuffle
}

define < 2 x i32> @extract_elt13_v4i32_readfirstlane_source_simplify1(i32 %src0, i32 %src2) {
; CHECK-LABEL: define <2 x i32> @extract_elt13_v4i32_readfirstlane_source_simplify1(
; CHECK-SAME: i32 [[SRC0:%.*]], i32 [[SRC2:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <4 x i32> poison, i32 [[SRC0]], i64 0
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <4 x i32> [[TMP1]], <4 x i32> poison, <3 x i32> <i32 0, i32 poison, i32 0>
; CHECK-NEXT:    [[TMP3:%.*]] = call <3 x i32> @llvm.amdgcn.readfirstlane.v3i32(<3 x i32> [[TMP2]])
; CHECK-NEXT:    [[VEC:%.*]] = shufflevector <3 x i32> [[TMP3]], <3 x i32> poison, <4 x i32> <i32 poison, i32 0, i32 poison, i32 2>
; CHECK-NEXT:    [[SHUFFLE:%.*]] = shufflevector <4 x i32> [[VEC]], <4 x i32> poison, <2 x i32> <i32 1, i32 3>
; CHECK-NEXT:    ret <2 x i32> [[SHUFFLE]]
;
  %ins.0 = insertelement <4 x i32> poison, i32 %src0, i32 1
  %ins.1 = insertelement <4 x i32> %ins.0, i32 %src0, i32 3
  %vec = call <4 x i32> @llvm.amdgcn.readfirstlane.v4i32(<4 x i32> %ins.1)
  %shuffle = shufflevector <4 x i32> %vec, <4 x i32> poison, <2 x i32> <i32 1, i32 3>
  ret <2 x i32> %shuffle
}

define < 2 x i32> @extract_elt13_v4i32_readfirstlane_source_simplify2(i32 %src0, i32 %src2) {
; CHECK-LABEL: define <2 x i32> @extract_elt13_v4i32_readfirstlane_source_simplify2(
; CHECK-SAME: i32 [[SRC0:%.*]], i32 [[SRC2:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    ret <2 x i32> poison
;
  %ins.0 = insertelement <4 x i32> poison, i32 %src0, i32 0
  %ins.1 = insertelement <4 x i32> %ins.0, i32 %src0, i32 2
  %vec = call <4 x i32> @llvm.amdgcn.readfirstlane.v4i32(<4 x i32> %ins.1)
  %shuffle = shufflevector <4 x i32> %vec, <4 x i32> poison, <2 x i32> <i32 1, i32 3>
  ret <2 x i32> %shuffle
}

define i32 @extract_elt0_v2i32_readfirstlane_convergencetoken(<2 x i32> %src) convergent {
; CHECK-LABEL: define i32 @extract_elt0_v2i32_readfirstlane_convergencetoken(
; CHECK-SAME: <2 x i32> [[SRC:%.*]]) #[[ATTR1:[0-9]+]] {
; CHECK-NEXT:    [[T:%.*]] = call token @llvm.experimental.convergence.entry()
; CHECK-NEXT:    [[TMP1:%.*]] = extractelement <2 x i32> [[SRC]], i64 0
; CHECK-NEXT:    [[ELT:%.*]] = call i32 @llvm.amdgcn.readfirstlane.i32(i32 [[TMP1]]) [ "convergencectrl"(token [[T]]) ]
; CHECK-NEXT:    ret i32 [[ELT]]
;
  %t = call token @llvm.experimental.convergence.entry()
  %vec = call <2 x i32> @llvm.amdgcn.readfirstlane.v2i32(<2 x i32> %src) [ "convergencectrl"(token %t) ]
  %elt = extractelement <2 x i32> %vec, i32 0
  ret i32 %elt
}

define < 2 x i32> @extract_elt13_v4i32_readfirstlane_source_simplify1_convergencetoken(i32 %src0, i32 %src2) convergent {
; CHECK-LABEL: define <2 x i32> @extract_elt13_v4i32_readfirstlane_source_simplify1_convergencetoken(
; CHECK-SAME: i32 [[SRC0:%.*]], i32 [[SRC2:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[T:%.*]] = call token @llvm.experimental.convergence.entry()
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <4 x i32> poison, i32 [[SRC0]], i64 0
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <4 x i32> [[TMP1]], <4 x i32> poison, <3 x i32> <i32 0, i32 poison, i32 0>
; CHECK-NEXT:    [[TMP3:%.*]] = call <3 x i32> @llvm.amdgcn.readfirstlane.v3i32(<3 x i32> [[TMP2]]) [ "convergencectrl"(token [[T]]) ]
; CHECK-NEXT:    [[VEC:%.*]] = shufflevector <3 x i32> [[TMP3]], <3 x i32> poison, <4 x i32> <i32 poison, i32 0, i32 poison, i32 2>
; CHECK-NEXT:    [[SHUFFLE:%.*]] = shufflevector <4 x i32> [[VEC]], <4 x i32> poison, <2 x i32> <i32 1, i32 3>
; CHECK-NEXT:    ret <2 x i32> [[SHUFFLE]]
;
  %t = call token @llvm.experimental.convergence.entry()
  %ins.0 = insertelement <4 x i32> poison, i32 %src0, i32 1
  %ins.1 = insertelement <4 x i32> %ins.0, i32 %src0, i32 3
  %vec = call <4 x i32> @llvm.amdgcn.readfirstlane.v4i32(<4 x i32> %ins.1) [ "convergencectrl"(token %t) ]
  %shuffle = shufflevector <4 x i32> %vec, <4 x i32> poison, <2 x i32> <i32 1, i32 3>
  ret <2 x i32> %shuffle
}

define i1 @extract_elt0_v2i1_readfirstlane(<2 x i1> %src) {
; CHECK-LABEL: define i1 @extract_elt0_v2i1_readfirstlane(
; CHECK-SAME: <2 x i1> [[SRC:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[TMP1:%.*]] = extractelement <2 x i1> [[SRC]], i64 0
; CHECK-NEXT:    [[ELT:%.*]] = call i1 @llvm.amdgcn.readfirstlane.i1(i1 [[TMP1]])
; CHECK-NEXT:    ret i1 [[ELT]]
;
  %vec = call <2 x i1> @llvm.amdgcn.readfirstlane.v2i1(<2 x i1> %src)
  %elt = extractelement <2 x i1> %vec, i32 0
  ret i1 %elt
}

define <2 x i1> @extract_elt01_v4i1_readfirstlane(<4 x i1> %src) {
; CHECK-LABEL: define <2 x i1> @extract_elt01_v4i1_readfirstlane(
; CHECK-SAME: <4 x i1> [[SRC:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[VEC:%.*]] = call <4 x i1> @llvm.amdgcn.readfirstlane.v4i1(<4 x i1> [[SRC]])
; CHECK-NEXT:    [[SHUFFLE:%.*]] = shufflevector <4 x i1> [[VEC]], <4 x i1> poison, <2 x i32> <i32 0, i32 1>
; CHECK-NEXT:    ret <2 x i1> [[SHUFFLE]]
;
  %vec = call <4 x i1> @llvm.amdgcn.readfirstlane.v4i1(<4 x i1> %src)
  %shuffle = shufflevector <4 x i1> %vec, <4 x i1> poison, <2 x i32> <i32 0, i32 1>
  ret <2 x i1> %shuffle
}

define <2 x i32> @extract_elt13_v8i32_readfirstlane(<8 x i32> %src) {
; CHECK-LABEL: define <2 x i32> @extract_elt13_v8i32_readfirstlane(
; CHECK-SAME: <8 x i32> [[SRC:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <8 x i32> [[SRC]], <8 x i32> poison, <3 x i32> <i32 1, i32 poison, i32 3>
; CHECK-NEXT:    [[TMP2:%.*]] = call <3 x i32> @llvm.amdgcn.readfirstlane.v3i32(<3 x i32> [[TMP1]])
; CHECK-NEXT:    [[VEC:%.*]] = shufflevector <3 x i32> [[TMP2]], <3 x i32> poison, <8 x i32> <i32 poison, i32 0, i32 poison, i32 2, i32 poison, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[SHUFFLE:%.*]] = shufflevector <8 x i32> [[VEC]], <8 x i32> poison, <2 x i32> <i32 1, i32 3>
; CHECK-NEXT:    ret <2 x i32> [[SHUFFLE]]
;
  %vec = call <8 x i32> @llvm.amdgcn.readfirstlane.v8i32(<8 x i32> %src)
  %shuffle = shufflevector <8 x i32> %vec, <8 x i32> poison, <2 x i32> <i32 1, i32 3>
  ret <2 x i32> %shuffle
}

define <2 x i32> @extract_elt03_v4i32_readfirstlane(<4 x i32> %src) {
; CHECK-LABEL: define <2 x i32> @extract_elt03_v4i32_readfirstlane(
; CHECK-SAME: <4 x i32> [[SRC:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[VEC:%.*]] = call <4 x i32> @llvm.amdgcn.readfirstlane.v4i32(<4 x i32> [[SRC]])
; CHECK-NEXT:    [[SHUFFLE:%.*]] = shufflevector <4 x i32> [[VEC]], <4 x i32> poison, <2 x i32> <i32 0, i32 3>
; CHECK-NEXT:    ret <2 x i32> [[SHUFFLE]]
;
  %vec = call <4 x i32> @llvm.amdgcn.readfirstlane.v4i32(<4 x i32> %src)
  %shuffle = shufflevector <4 x i32> %vec, <4 x i32> poison, <2 x i32> <i32 0, i32 3>
  ret <2 x i32> %shuffle
}

define <3 x i32> @extract_elt124_v8i32_readfirstlane(<8 x i32> %src) {
; CHECK-LABEL: define <3 x i32> @extract_elt124_v8i32_readfirstlane(
; CHECK-SAME: <8 x i32> [[SRC:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <8 x i32> [[SRC]], <8 x i32> poison, <4 x i32> <i32 1, i32 2, i32 poison, i32 4>
; CHECK-NEXT:    [[TMP2:%.*]] = call <4 x i32> @llvm.amdgcn.readfirstlane.v4i32(<4 x i32> [[TMP1]])
; CHECK-NEXT:    [[VEC:%.*]] = shufflevector <4 x i32> [[TMP2]], <4 x i32> poison, <8 x i32> <i32 poison, i32 0, i32 1, i32 poison, i32 3, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[SHUFFLE:%.*]] = shufflevector <8 x i32> [[VEC]], <8 x i32> poison, <3 x i32> <i32 1, i32 2, i32 4>
; CHECK-NEXT:    ret <3 x i32> [[SHUFFLE]]
;
  %vec = call <8 x i32> @llvm.amdgcn.readfirstlane.v8i32(<8 x i32> %src)
  %shuffle = shufflevector <8 x i32> %vec, <8 x i32> poison, <3 x i32> <i32 1, i32 2, i32 4>
  ret <3 x i32> %shuffle
}
