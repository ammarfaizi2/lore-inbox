Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262798AbVEGIYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262798AbVEGIYh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 04:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbVEGIOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 04:14:44 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:61858 "EHLO
	mailout1.samsung.com") by vger.kernel.org with ESMTP
	id S262780AbVEGILq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 04:11:46 -0400
Date: Sat, 07 May 2005 17:10:07 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: [PATCH 5/17] ARMNOMMU - nommu/mpu patch for arch/arm/configs/*
To: linux-arm-kernel@lists.arm.linux.org.uk,
       Linux-Kernel List <linux-kernel@vger.kernel.org>,
       uClinux development list <uclinux-dev@uclinux.org>
Message-id: <0IG400D0T1FLYM@mmp1.samsung.com>
Organization: Samsung Electronics Co.,Ltd.
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Thread-index: AcVS3C5xyumU7NuVSd6sdT+j4xhhYA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nommu/mpu patch set against 2.6.12-rc3-mm3 [5/17]
 
- nommu/mpu patch for arch/arm/configs/*

 arch/arm/configs/GDB_ARMulator_defconfig |  482 +++++++++++++++++++++++
 arch/arm/configs/atmel_defconfig         |  482 +++++++++++++++++++++++
 arch/arm/configs/espd_4510b_defconfig    |  649
+++++++++++++++++++++++++++++++
 arch/arm/configs/p2001_defconfig         |  634
++++++++++++++++++++++++++++++
 arch/arm/configs/s3c24a0_mmu_defconfig   |  522 ++++++++++++++++++++++++
 arch/arm/configs/s3c24a0_nommu_defconfig |  518 ++++++++++++++++++++++++
 arch/arm/configs/s3c3410_defconfig       |  470 ++++++++++++++++++++++
 arch/arm/configs/s3c44b0x_defconfig      |  619
+++++++++++++++++++++++++++++
 arch/arm/configs/s5c7375_defconfig       |  482 +++++++++++++++++++++++
 9 files changed, 4858 insertions(+)
 
Signed-off-by: Hyok S. Choi <hyok.choi@samsung.com>
the patch :
http://opensrc.sec.samsung.com/download/linux-2.6.12-rc3-mm3-hsc0-configs.pa
tch.bz2
 
---
Hyok S. Choi
[Linux 2.6 for MMU-less ARM Project] http://opensrc.sec.samsung.com/



