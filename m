Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316512AbSE0C4W>; Sun, 26 May 2002 22:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316514AbSE0C4V>; Sun, 26 May 2002 22:56:21 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:17851 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S316512AbSE0C4U>; Sun, 26 May 2002 22:56:20 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, viro@math.psu.edu
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [PATCH] MAINTAINERS file addition: Al Viro
Date: Mon, 27 May 2002 12:59:35 +1000
Message-Id: <E17CAjP-0005eK-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sick of searching my mail archives to find that email addr.

Rusty.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.18/MAINTAINERS working-2.5.18-viro/MAINTAINERS
--- linux-2.5.18/MAINTAINERS	Sat May 25 14:34:34 2002
+++ working-2.5.18-viro/MAINTAINERS	Mon May 27 12:57:42 2002
@@ -574,6 +574,11 @@
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
 
+FILESYSTEMS (VFS and infrastructure)
+P:	Alexander Viro
+M:	viro@math.psu.edu
+S:	Maintained
+
 FPU EMULATOR
 P:	Bill Metzenthen
 M:	billm@suburbia.net

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
