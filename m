Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264342AbTEZLNi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 07:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264343AbTEZLNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 07:13:38 -0400
Received: from xs4all.vs19.net ([213.84.236.198]:65331 "EHLO spaans.vs19.net")
	by vger.kernel.org with ESMTP id S264342AbTEZLNh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 07:13:37 -0400
Date: Mon, 26 May 2003 13:26:45 +0200
From: Jasper Spaans <jasper@vs19.net>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] typo fix
Message-ID: <20030526112645.GA15462@spaans.vs19.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Organization: http://www.insultant.nl/
X-Copyright: Copyright 2003 C. Jasper Spaans - All Rights Reserved
Keywords: Uzi constitution Vickie Weaver Marxist radar cryptographic SDI Semtex 
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A small documentation fix:

Index: kernel/sched.c
===================================================================
RCS file: /home/cvs/linux-2.5/kernel/sched.c,v
retrieving revision 1.175
diff -u -r1.175 sched.c
--- kernel/sched.c	19 May 2003 17:46:39 -0000	1.175
+++ kernel/sched.c	26 May 2003 10:20:14 -0000
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
