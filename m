Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAIDYm>; Mon, 8 Jan 2001 22:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129561AbRAIDYb>; Mon, 8 Jan 2001 22:24:31 -0500
Received: from cx518206-b.irvn1.occa.home.com ([24.21.107.123]:37126 "EHLO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with ESMTP
	id <S129324AbRAIDYZ>; Mon, 8 Jan 2001 22:24:25 -0500
From: "Barry K. Nathan" <barryn@cx518206-b.irvn1.occa.home.com>
Message-Id: <200101090324.TAA05331@cx518206-b.irvn1.occa.home.com>
Subject: [PATCH] 2.4.0 Changes - add compiler source code URL, minor cleanup
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Mon, 8 Jan 2001 19:24:17 -0800 (PST)
Cc: kaboom@gatech.edu, chris.ricker@genetics.utah.edu
Reply-To: barryn@pobox.com
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch:

(a) Adds a URL for the egcs 1.1.2 source code. This change is both
low-risk and important IMO.

(b) Fixes two sloppy underlines.

Please apply.

-Barry K. Nathan <barryn@pobox.com>


--- linux-2.4.0/Documentation/Changes	Mon Jan  1 10:00:04 2001
+++ linux-2.4.0bkn1/Documentation/Changes	Mon Jan  8 19:09:44 2001
@@ -31,7 +31,7 @@
 Eine deutsche Version dieser Datei finden Sie unter
 <http://www.stefan-winter.de/Changes-2.4.0.txt>.
 
-Last updated: December 11, 2000
+Last updated: January 8, 2001
 
 Chris Ricker (kaboom@gatech.edu or chris.ricker@genetics.utah.edu).
 
@@ -261,12 +261,16 @@
 Compilers
 *********
 
-egcs 1.1.2 (gcc 2.91.66)
----------
+egcs 1.1.2 (gcc 2.91.66) binaries
+---------------------------------
 o  <ftp://ftp.valinux.com/pub/support/hjl/gcc/egcs-1.1.2/egcs-1.1.2-glibc.x86.tar.bz2>
 o  <ftp://ftp.valinux.com/pub/support/hjl/gcc/egcs-1.1.2/egcs-1.1.2-libc5.x86.tar.bz2>
 o  <ftp://ftp.valinux.com/pub/support/hjl/gcc/egcs-1.1.2/egcs-1.1.2-alpha.tar.bz2>
 
+egcs 1.1.2 (gcc 2.91.66) source code
+------------------------------------
+o  <ftp://egcs.cygnus.com/pub/egcs/releases/egcs-1.1.2/>
+
 Binutils
 ********
 
@@ -275,7 +279,7 @@
 o  <ftp://ftp.valinux.com/pub/support/hjl/binutils/2.9.1/binutils-2.9.1.0.25.tar.gz>
 
 2.10 series
-------------
+-----------
 o  <ftp://ftp.valinux.com/pub/support/hjl/binutils/binutils-2.10.0.24.tar.bz2>
 
 System utilities
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
