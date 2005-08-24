Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbVHXKg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbVHXKg4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 06:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbVHXKg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 06:36:56 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:785 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750776AbVHXKgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 06:36:55 -0400
Date: Wed, 24 Aug 2005 12:36:53 +0200
From: Adrian Bunk <bunk@stusta.de>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] Documentation/arm/README: small update
Message-ID: <20050824103653.GI5603@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- egcs is not supported by kernel 2.6
- Am I right to assume that gcc 2.95.3 is not worse than gcc 2.95.1?


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc6-mm2-full/Documentation/arm/README.old	2005-08-24 11:51:22.000000000 +0200
+++ linux-2.6.13-rc6-mm2-full/Documentation/arm/README	2005-08-24 11:51:52.000000000 +0200
@@ -8,8 +8,8 @@
 ---------------------
 
   In order to compile ARM Linux, you will need a compiler capable of
-  generating ARM ELF code with GNU extensions.  GCC 2.95.1, EGCS
-  1.1.2, and GCC 3.3 are known to be good compilers.  Fortunately, you
+  generating ARM ELF code with GNU extensions.  GCC 2.95.3 and
+  GCC 3.3 are known to be good compilers.  Fortunately, you
   needn't guess.  The kernel will report an error if your compiler is
   a recognized offender.
 

