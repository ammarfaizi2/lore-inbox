Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132130AbRDFRah>; Fri, 6 Apr 2001 13:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132167AbRDFRa1>; Fri, 6 Apr 2001 13:30:27 -0400
Received: from tstac.esa.lanl.gov ([128.165.46.3]:30344 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S132130AbRDFRaM>; Fri, 6 Apr 2001 13:30:12 -0400
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
Date: Fri, 6 Apr 2001 11:29:39 -0600
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, chris.ricker@genetics.utah.edu
Subject: [PATCH] 2.4.3-ac3 update Documentation/Changes URLs for e2fsprogs
MIME-Version: 1.0
Message-Id: <01040611293901.12098@spc.esa.lanl.gov>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all,

It appears that the URLs listed in Documentation/Changes for e2fsprogs
are stale.  This patch, against 2.4.3-ac3, provides accurate URLs.

Steven

--- linux/Documentation/Changes.orig    Fri Apr  6 11:13:10 2001
+++ linux/Documentation/Changes Fri Apr  6 11:15:00 2001
@@ -31,7 +31,7 @@
 Eine deutsche Version dieser Datei finden Sie unter
 <http://www.stefan-winter.de/Changes-2.4.0.txt>.
 
-Last updated: January 11, 2001
+Last updated: April 6, 2001
 
 Chris Ricker (kaboom@gatech.edu or chris.ricker@genetics.utah.edu).
 
@@ -311,8 +311,8 @@
 
 E2fsprogs
 ---------
-o  <ftp://download.sourceforge.net/pub/sourceforge/e2fsprogs/e2fsprogs-1.19.tar.gz>
-o  <ftp://download.sourceforge.net/pub/sourceforge/e2fsprogs/e2fsprogs-1.19.src.rpm>
+o  <http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-1.19.tar.gz>
+o  <http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-1.19-0.src.rpm>
 
 Reiserfsprogs
 -------------
