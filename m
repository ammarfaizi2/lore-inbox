Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262537AbVDLSfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262537AbVDLSfJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 14:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbVDLSdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 14:33:03 -0400
Received: from fire.osdl.org ([65.172.181.4]:41419 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262119AbVDLKgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:36:16 -0400
Message-Id: <200504121033.j3CAX1gx005744@shell0.pdx.osdl.net>
Subject: [patch 149/198] MAINTAINERS: remove obsolete ACP/MWAVE MODEM entry
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, bunk@stusta.de
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:54 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Adrian Bunk <bunk@stusta.de>

Both maintainer email addresses are bouncing and the web address is no
longer valid.

Seems to be a good time to remove the entry.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/MAINTAINERS |    8 --------
 1 files changed, 8 deletions(-)

diff -puN MAINTAINERS~maintainers-remove-obsolete-acp-mwave-modem-entry MAINTAINERS
--- 25/MAINTAINERS~maintainers-remove-obsolete-acp-mwave-modem-entry	2005-04-12 03:21:39.070197328 -0700
+++ 25-akpm/MAINTAINERS	2005-04-12 03:21:39.368152032 -0700
@@ -172,14 +172,6 @@ L:	linux-sound@vger.kernel.org
 W:	http://www.stud.uni-karlsruhe.de/~uh1b/
 S:	Maintained
 
-ACP/MWAVE MODEM
-P:	Paul B Schroeder
-M:	paulsch@us.ibm.com
-P:	Mike Sullivan
-M:	sullivam@us.ibm.com
-W:	http://www.ibm.com/linux/ltc/
-S:	Supported
-
 AACRAID SCSI RAID DRIVER
 P:	Adaptec OEM Raid Solutions
 L:	linux-scsi@vger.kernel.org
_
