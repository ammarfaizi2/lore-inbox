Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262778AbVEGIYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262778AbVEGIYg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 04:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262800AbVEGIOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 04:14:24 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:14687 "EHLO
	mailout2.samsung.com") by vger.kernel.org with ESMTP
	id S262782AbVEGIL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 04:11:57 -0400
Date: Sat, 07 May 2005 17:10:18 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: [PATCH 6/17] ARMNOMMU - nommu/mpu patch for arch/arm/*
To: linux-arm-kernel@lists.arm.linux.org.uk,
       Linux-Kernel List <linux-kernel@vger.kernel.org>,
       uClinux development list <uclinux-dev@uclinux.org>
Message-id: <0IG40013L1FVFD@mmp2.samsung.com>
Organization: Samsung Electronics Co.,Ltd.
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Thread-index: AcVS3DR/1Pp1nyG5Q4m+MYg2fftJRg==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nommu/mpu patch set against 2.6.12-rc3-mm3 [6/17]

- nommu/mpu patch for arch/arm/*

 arch/arm/Kconfig       |  163
++++++++++++++++++++++++++++++++++++++++++++++---
 arch/arm/Kconfig-nommu |   57 +++++++++++++++++
 arch/arm/Makefile      |   51 ++++++++++++++-
 3 files changed, 262 insertions(+), 9 deletions(-)
 
Signed-off-by: Hyok S. Choi <hyok.choi@samsung.com>
the patch :
http://opensrc.sec.samsung.com/download/linux-2.6.12-rc3-mm3-hsc0-kconfig_ma
kefile.patch.bz2
 
---
Hyok S. Choi
[Linux 2.6 for MMU-less ARM Project] http://opensrc.sec.samsung.com/


