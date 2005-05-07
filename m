Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262799AbVEGI00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262799AbVEGI00 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 04:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbVEGINL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 04:13:11 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:22623 "EHLO
	mailout2.samsung.com") by vger.kernel.org with ESMTP
	id S262785AbVEGIMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 04:12:22 -0400
Date: Sat, 07 May 2005 17:10:40 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: [PATCH 9/17] ARMNOMMU - platform patch for integrator
To: linux-arm-kernel@lists.arm.linux.org.uk,
       Linux-Kernel List <linux-kernel@vger.kernel.org>,
       uClinux development list <uclinux-dev@uclinux.org>
Message-id: <0IG400GRA1GINY@mmp2.samsung.com>
Organization: Samsung Electronics Co.,Ltd.
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Thread-index: AcVS3EICpDwxj+PBT1WWj7+plmz9AA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nommu/mpu patch set against 2.6.12-rc3-mm3 [9/17]
 
- platform patch for integrator
 
 arch/arm/mach-integrator/integrator_cp.c   |   10 ++++++++++
 include/asm-arm/arch-integrator/hardware.h |   18 ++++++++++++++++++
 2 files changed, 28 insertions(+)
 
Signed-off-by: Catalin Marnias <catalin.marinas@arm.com>
the patch :
http://opensrc.sec.samsung.com/download/linux-2.6.12-rc3-mm3-hsc0-integrator
.patch.bz2
 
---
Hyok S. Choi
[Linux 2.6 for MMU-less ARM Project] http://opensrc.sec.samsung.com/


