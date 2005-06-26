Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVFZMiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVFZMiZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 08:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVFZMiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 08:38:25 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:32780 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261193AbVFZMiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 08:38:22 -0400
Date: Sun, 26 Jun 2005 14:38:19 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] Documentation/kernel-parameters.txt: fix a typo
Message-ID: <20050626123819.GF3629@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes an obvious typo (DCHP->DHCP).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

