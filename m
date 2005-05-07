Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262782AbVEGI2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262782AbVEGI2r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 04:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262806AbVEGI12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 04:27:28 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:54692 "EHLO
	mailout3.samsung.com") by vger.kernel.org with ESMTP
	id S262785AbVEGINP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 04:13:15 -0400
Date: Sat, 07 May 2005 17:11:35 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: [PATCH 15/17] ARMNOMMU - drivers/net/arm/*
To: linux-arm-kernel@lists.arm.linux.org.uk,
       Linux-Kernel List <linux-kernel@vger.kernel.org>,
       uClinux development list <uclinux-dev@uclinux.org>
Message-id: <0IG400GU41I1NY@mmp2.samsung.com>
Organization: Samsung Electronics Co.,Ltd.
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Thread-index: AcVS3GKr4snaXuIrSaeEyMz6ChiYlg==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nommu/mpu patch set against 2.6.12-rc3-mm3 [15/17]
 
- drivers/net/arm/*

 drivers/net/arm/Kconfig        |   29
 drivers/net/arm/Makefile       |    2
 drivers/net/arm/eth_s3c4510b.c |  544 ++++++++++++++++
 drivers/net/arm/eth_s3c4510b.h |  301 +++++++++
 drivers/net/arm/p2001_eth.c    | 1334
+++++++++++++++++++++++++++++++++++++++++
 5 files changed, 2210 insertions(+) 

Signed-off-by: Hyok S. Choi <hyok.choi@samsung.com>
the patch :
http://opensrc.sec.samsung.com/download/linux-2.6.12-rc3-mm3-hsc0-drivers_ne
t_arm.patch.bz2 
 
---
Hyok S. Choi
[Linux 2.6 for MMU-less ARM Project] http://opensrc.sec.samsung.com/

