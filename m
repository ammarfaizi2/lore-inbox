Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262481AbSI2N7b>; Sun, 29 Sep 2002 09:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262483AbSI2N7b>; Sun, 29 Sep 2002 09:59:31 -0400
Received: from medelec.uia.ac.be ([143.169.17.1]:30993 "EHLO medelec.uia.ac.be")
	by vger.kernel.org with ESMTP id <S262481AbSI2N7b>;
	Sun, 29 Sep 2002 09:59:31 -0400
Date: Sun, 29 Sep 2002 16:04:49 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] linux-2.5.39 - i8xx series chipsets patches (patch1)
Message-ID: <20020929160449.A7353@medelec.uia.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

a patch to make the documentation for the i810_rng module the same as in 2.4.19 .

Greetings,
Wim.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.634   -> 1.635  
#	Documentation/i810_rng.txt	1.4     -> 1.5    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/29	wim@iguana.be	1.635
# [PATCH] 2.5.39 - i8xx series chipsets patches (patch 1)
# 
# Make i810_rng documentation the same as in 2.4.19
# --------------------------------------------
#
diff -Nru a/Documentation/i810_rng.txt b/Documentation/i810_rng.txt
--- a/Documentation/i810_rng.txt	Sun Sep 29 15:06:18 2002
+++ b/Documentation/i810_rng.txt	Sun Sep 29 15:06:18 2002
@@ -72,6 +72,7 @@
 
 	Version 0.9.8:
 	* Support other i8xx chipsets by adding 82801E detection
+	* 82801DB detection is the same as for 82801CA.
 
 	Version 0.9.7:
 	* Support other i8xx chipsets too (by adding 82801BA(M) and
