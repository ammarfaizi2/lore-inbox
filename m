Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264815AbUEPUgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264815AbUEPUgH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 16:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264816AbUEPUgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 16:36:07 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:57086 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264815AbUEPUgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 16:36:04 -0400
Date: Sun, 16 May 2004 22:35:57 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.6.6-mm3: remove PC9800 from should-fix
Message-ID: <20040516203557.GR22742@fs.tum.de>
References: <20040516025514.3fe93f0c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040516025514.3fe93f0c.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PC9800 gets removed.

cu
Adrian

--- linux-2.6.6-mm3-full/Documentation/should-fix.txt.old	2004-05-16 22:34:03.000000000 +0200
+++ linux-2.6.6-mm3-full/Documentation/should-fix.txt	2004-05-16 22:34:18.000000000 +0200
@@ -404,10 +404,6 @@
 arch/i386/
 ~~~~~~~~~~
 
-o Also PC9800 merge needs finishing to the point we want for 2.6 (not all).
-
-  PRI3
-
 o davej: PAT support (for mtrr exhaustion w/ AGP)
 
   PRI2
