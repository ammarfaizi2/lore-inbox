Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263033AbVGIBfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263033AbVGIBfb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 21:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263043AbVGIBfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 21:35:31 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:5127 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263033AbVGIBem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 21:34:42 -0400
Date: Sat, 9 Jul 2005 03:34:40 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] Documentation/kernel-parameters.txt: fix a typo
Message-ID: <20050709013440.GP3671@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes an obvious typo (DCHP->DHCP).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 26 Jun 2005

--- linux-2.6.12-mm2-full/Documentation/kernel-parameters.txt.old	2005-06-26 14:36:44.000000000 +0200
+++ linux-2.6.12-mm2-full/Documentation/kernel-parameters.txt	2005-06-26 14:36:54.000000000 +0200
@@ -37,7 +37,7 @@
 	IA-32	IA-32 aka i386 architecture is enabled.
 	IA-64	IA-64 architecture is enabled.
 	IOSCHED	More than one I/O scheduler is enabled.
-	IP_PNP	IP DCHP, BOOTP, or RARP is enabled.
+	IP_PNP	IP DHCP, BOOTP, or RARP is enabled.
 	ISAPNP	ISA PnP code is enabled.
 	ISDN	Appropriate ISDN support is enabled.
 	JOY	Appropriate joystick support is enabled.

