Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbWEQASJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWEQASJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWEQARv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:17:51 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:3997 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932324AbWEQARF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:17:05 -0400
Date: Wed, 17 May 2006 02:16:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 20/50] genirq: update copyrights
Message-ID: <20060517001647.GU12877@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

update/add copyrights in the generic IRQ code.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/handle.c |    6 +++++-
 kernel/irq/manage.c |    3 ++-
 2 files changed, 7 insertions(+), 2 deletions(-)

Index: linux-genirq.q/kernel/irq/handle.c
===================================================================
--- linux-genirq.q.orig/kernel/irq/handle.c
+++ linux-genirq.q/kernel/irq/handle.c
@@ -1,9 +1,13 @@
 /*
  * linux/kernel/irq/handle.c
  *
- * Copyright (C) 1992, 1998-2004 Linus Torvalds, Ingo Molnar
+ * Copyright (C) 1992, 1998-2006 Linus Torvalds, Ingo Molnar
+ * Copyright (C) 2005-2006, Thomas Gleixner, Russell King
  *
  * This file contains the core interrupt handling code.
+ *
+ * Detailed information is available in Documentation/DocBook/genericirq
+ *
  */
 
 #include <linux/irq.h>
Index: linux-genirq.q/kernel/irq/manage.c
===================================================================
--- linux-genirq.q.orig/kernel/irq/manage.c
+++ linux-genirq.q/kernel/irq/manage.c
@@ -1,7 +1,8 @@
 /*
  * linux/kernel/irq/manage.c
  *
- * Copyright (C) 1992, 1998-2004 Linus Torvalds, Ingo Molnar
+ * Copyright (C) 1992, 1998-2006 Linus Torvalds, Ingo Molnar
+ * Copyright (C) 2005-2006 Thomas Gleixner
  *
  * This file contains driver APIs to the irq subsystem.
  */
