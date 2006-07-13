Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbWGMBOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbWGMBOK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 21:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbWGMBOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 21:14:09 -0400
Received: from xenotime.net ([66.160.160.81]:61139 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932478AbWGMBOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 21:14:08 -0400
Date: Wed, 12 Jul 2006 18:15:54 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, jketreno@linux.intel.com, oliver@neukum.name
Subject: [PATCH] actual mailing list in MAINTAINERS
Message-Id: <20060712181554.5c6fcece.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Add actual mailing list email addresses for the 4 that were only
listing a web page.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 MAINTAINERS |    4 ++++
 1 files changed, 4 insertions(+)

--- linux-2618-rc1mm1.orig/MAINTAINERS
+++ linux-2618-rc1mm1/MAINTAINERS
@@ -771,6 +771,7 @@ M:	aliakc@web.de
 P:	Jamie Lenehan
 M:	lenehan@twibble.org
 W:	http://twibble.org/dist/dc395x/
+L:	dc395x@twibble.org
 L:	http://lists.twibble.org/mailman/listinfo/dc395x/
 S:	Maintained
 
@@ -1531,6 +1532,7 @@ P:	Yi Zhu
 M:	yi.zhu@intel.com
 P:	James Ketrenos
 M:	jketreno@linux.intel.com
+L:	ipw2100-devel@lists.sourceforge.net
 L:	http://lists.sourceforge.net/mailman/listinfo/ipw2100-devel
 W:	http://ipw2100.sourceforge.net
 S:	Supported
@@ -1540,6 +1542,7 @@ P:	Yi Zhu
 M:	yi.zhu@intel.com
 P:	James Ketrenos
 M:	jketreno@linux.intel.com
+L:	ipw2100-devel@lists.sourceforge.net
 L:	http://lists.sourceforge.net/mailman/listinfo/ipw2100-devel
 W:	http://ipw2200.sourceforge.net
 S:	Supported
@@ -2264,6 +2267,7 @@ S:	Maintained
 
 PCMCIA SUBSYSTEM
 P:	Linux PCMCIA Team
+L:	linux-pcmcia@lists.infradead.org
 L:	http://lists.infradead.org/mailman/listinfo/linux-pcmcia
 T:	git kernel.org:/pub/scm/linux/kernel/git/brodo/pcmcia-2.6.git
 S:	Maintained


---
