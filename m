Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262528AbVDLSkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbVDLSkc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 14:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262302AbVDLSgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 14:36:51 -0400
Received: from fire.osdl.org ([65.172.181.4]:7371 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262305AbVDLKeF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:34:05 -0400
Message-Id: <200504121033.j3CAXffJ005948@shell0.pdx.osdl.net>
Subject: [patch 196/198] fbdev MAINTAINERS update
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, benh@kernel.crashing.org
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:35 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

This patch does the long overdue updates to MAINTAINERS file for aty128fb
and radeonfb.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/MAINTAINERS |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -puN MAINTAINERS~fbdev-maintainers-update MAINTAINERS
--- 25/MAINTAINERS~fbdev-maintainers-update	2005-04-12 03:21:50.014533536 -0700
+++ 25-akpm/MAINTAINERS	2005-04-12 03:21:50.019532776 -0700
@@ -1852,14 +1852,14 @@ W:	http://www.alarsen.net/linux/qnx4fs/
 S:	Maintained
 
 RADEON FRAMEBUFFER DISPLAY DRIVER
-P:	Ani Joshi
-M:	ajoshi@shell.unixbox.com
+P:	Benjamin Herrenschmidt
+M:	benh@kernel.crashing.org
 L:	linux-fbdev-devel@lists.sourceforge.net
 S:	Maintained
 
 RAGE128 FRAMEBUFFER DISPLAY DRIVER
-P:	Ani Joshi
-M:	ajoshi@shell.unixbox.com
+P:	Paul Mackerras
+M:	paulus@samba.org
 L:	linux-fbdev-devel@lists.sourceforge.net
 S:	Maintained
 
_
