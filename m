Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264276AbTEaK7r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 06:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264277AbTEaK7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 06:59:47 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:62445 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264276AbTEaK7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 06:59:44 -0400
Date: Sat, 31 May 2003 13:13:01 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au, Jasper Spaans <jasper@vs19.net>
Subject: [PATCH] typo fix (fwd)
Message-ID: <20030531111301.GD2536@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The trivial typo fix by Jasper Spaans forwarded below still applies 
against 2.5.70-mm3.

cu
Adrian


----- Forwarded message from Jasper Spaans <jasper@vs19.net> -----

Date:	Mon, 26 May 2003 13:26:45 +0200
From: Jasper Spaans <jasper@vs19.net>
To: torvalds@transmeta.com,
    linux-kernel@vger.kernel.org
Subject: [PATCH] typo fix

A small documentation fix:

Index: kernel/sched.c
===================================================================
RCS file: /home/cvs/linux-2.5/kernel/sched.c,v
retrieving revision 1.175
diff -u -r1.175 sched.c
--- l/kernel/sched.c	19 May 2003 17:46:39 -0000	1.175
+++ l/kernel/sched.c	26 May 2003 10:20:14 -0000
@@ -2051,7 +2051,7 @@
 }
 
 /**
- * sys_sched_get_priority_mix - return minimum RT priority.
+ * sys_sched_get_priority_min - return minimum RT priority.
  * @policy: scheduling class.
  *
  * this syscall returns the minimum rt_priority that can be used


Bye,

Jasper
-- 
Jasper Spaans
http://jsp.vs19.net/contact/

``Got no clue? Too bad for you.''
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


----- End forwarded message -----

