Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbUJWNEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbUJWNEg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 09:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbUJWNEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 09:04:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:13460 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261164AbUJWNEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 09:04:07 -0400
Date: Sat, 23 Oct 2004 06:04:05 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200410231304.i9ND45jZ023006@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.10-rc1 - 2004-10-22.21.30) - 36 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/mtd/devices/doc2000.c:1052: warning: assignment makes integer from pointer without a cast
drivers/mtd/devices/doc2000.c:1108: warning: initialization makes integer from pointer without a cast
drivers/mtd/devices/doc2000.c:117: warning: initialization makes integer from pointer without a cast
drivers/mtd/devices/doc2000.c:1238: warning: assignment makes integer from pointer without a cast
drivers/mtd/devices/doc2000.c:143: warning: initialization makes integer from pointer without a cast
drivers/mtd/devices/doc2000.c:178: warning: assignment makes integer from pointer without a cast
drivers/mtd/devices/doc2000.c:246: warning: assignment makes integer from pointer without a cast
drivers/mtd/devices/doc2000.c:277: warning: assignment makes integer from pointer without a cast
drivers/mtd/devices/doc2000.c:295: warning: initialization makes integer from pointer without a cast
drivers/mtd/devices/doc2000.c:319: warning: initialization makes integer from pointer without a cast
drivers/mtd/devices/doc2000.c:649: warning: assignment makes integer from pointer without a cast
drivers/mtd/devices/doc2000.c:809: warning: assignment makes integer from pointer without a cast
drivers/mtd/devices/doc2000.c:92: warning: initialization makes integer from pointer without a cast
drivers/mtd/devices/doc2001.c:192: warning: passing arg 1 of `DoC_SelectFloor' makes integer from pointer without a cast
drivers/mtd/devices/doc2001.c:193: warning: passing arg 1 of `DoC_SelectChip' makes integer from pointer without a cast
drivers/mtd/devices/doc2001.c:196: warning: passing arg 1 of `DoC_Command' makes integer from pointer without a cast
drivers/mtd/devices/doc2001.c:197: warning: passing arg 1 of `DoC_WaitReady' makes integer from pointer without a cast
drivers/mtd/devices/doc2001.c:200: warning: passing arg 1 of `DoC_Command' makes integer from pointer without a cast
drivers/mtd/devices/doc2001.c:203: warning: passing arg 1 of `DoC_Address' makes integer from pointer without a cast
drivers/mtd/devices/doc2001.c:208: warning: passing arg 1 of `DoC_Delay' makes integer from pointer without a cast
drivers/mtd/devices/doc2001.c:211: warning: passing arg 1 of `DoC_Delay' makes integer from pointer without a cast
drivers/mtd/devices/doc2001.c:420: warning: initialization makes integer from pointer without a cast
drivers/mtd/devices/doc2001.c:546: warning: initialization makes integer from pointer without a cast
drivers/mtd/devices/doc2001.c:681: warning: initialization makes integer from pointer without a cast
drivers/mtd/devices/doc2001.c:733: warning: initialization makes integer from pointer without a cast
drivers/mtd/devices/doc2001.c:802: warning: initialization makes integer from pointer without a cast
drivers/mtd/devices/doc2001plus.c:1064: warning: initialization makes integer from pointer without a cast
drivers/mtd/devices/doc2001plus.c:136: warning: initialization makes integer from pointer without a cast
drivers/mtd/devices/doc2001plus.c:283: warning: initialization makes integer from pointer without a cast
drivers/mtd/devices/doc2001plus.c:374: warning: passing arg 1 of `writeb' makes integer from pointer without a cast
drivers/mtd/devices/doc2001plus.c:619: warning: initialization makes integer from pointer without a cast
drivers/mtd/devices/doc2001plus.c:758: warning: initialization makes integer from pointer without a cast
drivers/mtd/devices/doc2001plus.c:884: warning: initialization makes integer from pointer without a cast
drivers/mtd/devices/doc2001plus.c:962: warning: initialization makes integer from pointer without a cast
drivers/mtd/devices/docprobe.c:273: warning: assignment makes pointer from integer without a cast
net/ipv4/netfilter/ipt_CONNMARK.c:63: warning: suggest parentheses around arithmetic in operand of ^
