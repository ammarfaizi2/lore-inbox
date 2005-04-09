Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbVDIXTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbVDIXTU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 19:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbVDIXRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 19:17:50 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6407 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261423AbVDIXPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 19:15:49 -0400
Date: Sun, 10 Apr 2005 01:15:45 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] MAINTAINERS: remove obsolete ACP/MWAVE MODEM entry
Message-ID: <20050409231545.GU3632@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Both maintainer email addresses are bouncing and the web address is no 
longer valid.

Seems to be a good time to remove the entry.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc2-mm2-full/MAINTAINERS.old	2005-04-10 01:12:58.000000000 +0200
+++ linux-2.6.12-rc2-mm2-full/MAINTAINERS	2005-04-10 01:13:14.000000000 +0200
@@ -172,14 +172,6 @@
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

