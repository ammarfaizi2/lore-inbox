Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267554AbUG2STY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267554AbUG2STY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 14:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265201AbUG2SRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 14:17:07 -0400
Received: from ozlabs.org ([203.10.76.45]:3532 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264936AbUG2SQ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 14:16:27 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16649.16040.106272.54705@cargo.ozlabs.ibm.com>
Date: Thu, 29 Jul 2004 13:15:04 -0500
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, trini@kernel.crashing.org
Subject: PPC8xx Maintainer patch
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom is looking after PPC8xx and the PPC boot code.

Please apply.

Thanks,
Paul.

===== MAINTAINERS 1.229 vs edited =====
--- 1.229/MAINTAINERS	2004-07-24 22:00:59 -07:00
+++ edited/MAINTAINERS	2004-07-26 12:30:21 -07:00
@@ -1283,6 +1283,13 @@
 L:	linuxppc-embedded@lists.linuxppc.org
 S:	Maintained
 
+LINUX FOR POWERPC EMBEDDED PPC8XX AND BOOT CODE
+P:	Tom Rini
+M:	trini@kernel.crashing.org
+W:	http://www.penguinppc.org/
+L:	linuxppc-embedded@lists.linuxppc.org
+S:	Maintained
+
 LINUX FOR POWERPC EMBEDDED PPC85XX
 P:     Kumar Gala
 M:     kumar.gala@freescale.com

