Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314278AbSGYN0b>; Thu, 25 Jul 2002 09:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314284AbSGYN0a>; Thu, 25 Jul 2002 09:26:30 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:65276 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314278AbSGYN03>; Thu, 25 Jul 2002 09:26:29 -0400
From: Alan Cox <alan@irongate.swansea.linux.org.uk>
Message-Id: <200207251443.g6PEhfMV010382@irongate.swansea.linux.org.uk>
Subject: PATCH: 2.5.28 - backpack driver only needs module license in one file
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Thu, 25 Jul 2002 15:43:41 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/drivers/block/paride/ppc6lnx.c linux-2.5.28-ac1/drivers/block/paride/ppc6lnx.c
--- linux-2.5.28/drivers/block/paride/ppc6lnx.c	Thu Jul 25 10:49:19 2002
+++ linux-2.5.28-ac1/drivers/block/paride/ppc6lnx.c	Thu Jul 25 12:05:23 2002
@@ -724,4 +724,3 @@
 
 //***************************************************************************
 
-MODULE_LICENSE("GPL");
