Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbWCMTYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWCMTYn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 14:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbWCMTYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 14:24:43 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:27848 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932296AbWCMTYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 14:24:41 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 13 Mar 2006 20:21:09 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 1/3] Doc/kernel-parameters.txt: delete false version
 information and history
To: linux-kernel@vger.kernel.org
cc: Randy Dunlap <rdunlap@xenotime.net>
Message-ID: <tkrat.f6b9032d78fc1d70@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.771) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doc/kernel-parameters.txt: delete false version information and history

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>

--- linux/Documentation/kernel-parameters.txt.0	2006-03-13 19:28:13.000000000 +0100
+++ linux/Documentation/kernel-parameters.txt	2006-03-13 19:32:28.000000000 +0100
@@ -1,4 +1,4 @@
-February 2003             Kernel Parameters                     v2.5.59
+                          Kernel Parameters
                           ~~~~~~~~~~~~~~~~~
 
 The following is a consolidated list of the kernel parameters as implemented
@@ -1664,20 +1664,6 @@
 
 
 ______________________________________________________________________
-Changelog:
-
-2000-06-??	Mr. Unknown
-	The last known update (for 2.4.0) - the changelog was not kept before.
-
-2002-11-24	Petr Baudis <pasky@ucw.cz>
-		Randy Dunlap <randy.dunlap@verizon.net>
-	Update for 2.5.49, description for most of the options introduced,
-	references to other documentation (C files, READMEs, ..), added S390,
-	PPC, SPARC, MTD, ALSA and OSS category. Minor corrections and
-	reformatting.
-
-2005-10-19	Randy Dunlap <rdunlap@xenotime.net>
-	Lots of typos, whitespace, some reformatting.
 
 TODO:
 


