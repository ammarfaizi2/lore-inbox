Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261556AbSJMRTo>; Sun, 13 Oct 2002 13:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261557AbSJMRTo>; Sun, 13 Oct 2002 13:19:44 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49526 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261556AbSJMRTn>; Sun, 13 Oct 2002 13:19:43 -0400
To: Linus Torvalds <torvalds@transmeta.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Update changes to point to make 3.78
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 Oct 2002 11:24:15 -0600
Message-ID: <m1r8eumev4.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The Documentation/Changes in the summary has been updated to require
make 3.78 but the other references were not updated.  And 3.78 really
is required.  This patch updates the other locations.

Eric


--- linux-2.5.42/Documentation/Changes	Fri Oct 11 22:22:19 2002
+++ linux-2.5.42.eb1/Documentation/Changes	Sun Oct 13 11:19:05 2002
@@ -95,7 +95,7 @@
 Make
 ----
 
-You will need Gnu make 3.77 or later to build the kernel.
+You will need Gnu make 3.78 or later to build the kernel.
 
 Binutils
 --------
@@ -287,9 +287,9 @@
 ----------
 o  <ftp://ftp.gnu.org/gnu/gcc/gcc-2.95.3.tar.gz>
 
-Make 3.77
+Make 3.78
 ---------
-o  <ftp://ftp.gnu.org/gnu/make/make-3.77.tar.gz>
+o  <ftp://ftp.gnu.org/gnu/make/make-3.78.1.tar.gz>
 
 Binutils
 --------
