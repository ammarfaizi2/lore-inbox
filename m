Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262163AbUKKAKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbUKKAKj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 19:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbUKKAKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 19:10:38 -0500
Received: from ozlabs.org ([203.10.76.45]:55191 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262163AbUKKAIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 19:08:15 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16786.38284.887359.768548@cargo.ozlabs.ibm.com>
Date: Thu, 11 Nov 2004 09:26:20 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: trini@kernel.crashing.org, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Update ppc list addresses in MAINTAINERS
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The linuxppc mailing lists that were at lists.linuxppc.org have moved
to ozlabs.org.  This patch updates the MAINTAINERS file to reflect
that.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/MAINTAINERS pmac-2.5/MAINTAINERS
--- linux-2.5/MAINTAINERS	2004-11-08 18:37:51.000000000 +1100
+++ pmac-2.5/MAINTAINERS	2004-11-11 09:05:04.703310232 +1100
@@ -1294,14 +1294,14 @@
 P:	Paul Mackerras
 M:	paulus@samba.org
 W:	http://www.penguinppc.org/
-L:	linuxppc-dev@lists.linuxppc.org
+L:	linuxppc-dev@ozlabs.org
 S:	Supported
 
 LINUX FOR POWER MACINTOSH
 P:	Benjamin Herrenschmidt
 M:	benh@kernel.crashing.org
 W:	http://www.penguinppc.org/
-L:	linuxppc-dev@lists.linuxppc.org
+L:	linuxppc-dev@ozlabs.org
 S:	Maintained
 
 LINUX FOR POWERPC EMBEDDED MPC52XX
@@ -1317,21 +1317,21 @@
 P:	Matt Porter
 M:	mporter@kernel.crashing.org
 W:	http://www.penguinppc.org/
-L:	linuxppc-embedded@lists.linuxppc.org
+L:	linuxppc-embedded@ozlabs.org
 S:	Maintained
 
 LINUX FOR POWERPC EMBEDDED PPC8XX AND BOOT CODE
 P:	Tom Rini
 M:	trini@kernel.crashing.org
 W:	http://www.penguinppc.org/
-L:	linuxppc-embedded@lists.linuxppc.org
+L:	linuxppc-embedded@ozlabs.org
 S:	Maintained
 
 LINUX FOR POWERPC EMBEDDED PPC85XX
 P:     Kumar Gala
 M:     kumar.gala@freescale.com
 W:     http://www.penguinppc.org/
-L:     linuxppc-embedded@lists.linuxppc.org
+L:     linuxppc-embedded@ozlabs.org
 S:     Maintained
 
 LLC (802.2)
@@ -1347,7 +1347,7 @@
 M:	anton@samba.org
 M:	anton@au.ibm.com
 W:	http://linuxppc64.org
-L:	linuxppc64-dev@lists.linuxppc.org
+L:	linuxppc64-dev@ozlabs.org
 S:	Supported
 
 LINUX SECURITY MODULE (LSM) FRAMEWORK
