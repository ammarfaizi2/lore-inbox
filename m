Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315921AbSGVDkq>; Sun, 21 Jul 2002 23:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315923AbSGVDkq>; Sun, 21 Jul 2002 23:40:46 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:45219 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S315921AbSGVDkq>;
	Sun, 21 Jul 2002 23:40:46 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: [TRIVIAL] Remove stupid attribution.
Date: Mon, 22 Jul 2002 12:27:16 +1000
Message-Id: <20020722034447.7D9604352@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of tiny patches and several mails to Ingo does not justify a
mention in the comments.  If everyone did that, the kernel size would
double.

It's demeaning to those making significant contributions,
Rusty.

diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.27/kernel/sched.c working-2.5.27-trivial/kernel/sched.c
--- linux-2.5.27/kernel/sched.c	Sun Jul 21 17:43:10 2002
+++ working-2.5.27-trivial/kernel/sched.c	Mon Jul 22 12:22:15 2002
@@ -13,7 +13,7 @@
  *		hybrid priority-list and round-robin design with
  *		an array-switch method of distributing timeslices
  *		and per-CPU runqueues.  Additional code by Davide
- *		Libenzi, Robert Love, and Rusty Russell.
+ *		Libenzi, Robert Love.
  */
 
 #include <linux/mm.h>

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
