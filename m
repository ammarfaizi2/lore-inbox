Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318198AbSG3C6m>; Mon, 29 Jul 2002 22:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318196AbSG3C6m>; Mon, 29 Jul 2002 22:58:42 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:59056 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318195AbSG3C6l>;
	Mon, 29 Jul 2002 22:58:41 -0400
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL] Mark sparc32 unmaintained in 2.5
Date: Tue, 30 Jul 2002 12:44:12 +1000
Message-Id: <20020730030325.68AEB4360@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  Rusty Russell <rusty@rustcorp.com.au>

	DaveM said this was fine.

--- trivial-2.5.29/MAINTAINERS.orig	Tue Jul 30 12:15:14 2002
+++ trivial-2.5.29/MAINTAINERS	Tue Jul 30 12:15:14 2002
@@ -1487,7 +1487,7 @@
 L:	alsa-devel@alsa-project.org
 S:	Maintained
 
-SPARC:
+UltraSPARC (sparc64):
 P:	David S. Miller
 M:	davem@redhat.com
 P:	Eddie C. Dost
@@ -1499,6 +1499,9 @@
 L:	sparclinux@vger.kernel.org
 L:	ultralinux@vger.kernel.org
 S:	Maintained
+
+SPARC (sparc32):
+S:	Unmaintained
 
 SPECIALIX IO8+ MULTIPORT SERIAL CARD DRIVER
 P:	Roger Wolff
-- 
  Don't blame me: the Monkey is driving
