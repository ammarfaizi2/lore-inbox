Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262793AbVEGIQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262793AbVEGIQz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 04:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbVEGIQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 04:16:21 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:58276 "EHLO
	mailout3.samsung.com") by vger.kernel.org with ESMTP
	id S262793AbVEGINa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 04:13:30 -0400
Date: Sat, 07 May 2005 17:11:47 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: [PATCH 16/17] ARMNOMMU - drivers/serial/*
To: linux-arm-kernel@lists.arm.linux.org.uk,
       Linux-Kernel List <linux-kernel@vger.kernel.org>,
       uClinux development list <uclinux-dev@uclinux.org>
Message-id: <0IG400GV41IDNY@mmp2.samsung.com>
Organization: Samsung Electronics Co.,Ltd.
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Thread-index: AcVS3Gns2bVTDbbGTRuigKthgxlREg==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nommu/mpu patch set against 2.6.12-rc3-mm3 [16/17]
 
- drivers/serial/*

 drivers/serial/Kconfig           |   94 +
 drivers/serial/Makefile          |    4
 drivers/serial/dcc.c             |  551 +++++++++++
 drivers/serial/p2001_uart.c      |  721 ++++++++++++++
 drivers/serial/serial_atmel.c    | 1890
+++++++++++++++++++++++++++++++++++++++
 drivers/serial/serial_atmel.h    |  125 ++
 drivers/serial/serial_s3c24a0.c  |  596 ++++++++++++
 drivers/serial/serial_s3c4510b.c |  638 +++++++++++++
 include/linux/serial_core.h      |   14
 9 files changed, 4633 insertions(+)

Signed-off-by: Hyok S. Choi <hyok.choi@samsung.com>
the patch :
http://opensrc.sec.samsung.com/download/linux-2.6.12-rc3-mm3-hsc0-drivers_se
rial.patch.bz2
 
---
Hyok S. Choi
[Linux 2.6 for MMU-less ARM Project] http://opensrc.sec.samsung.com/

