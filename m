Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266839AbUHTM7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266839AbUHTM7g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 08:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266846AbUHTM7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 08:59:36 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:53432 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S266839AbUHTM7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 08:59:33 -0400
Date: Fri, 20 Aug 2004 14:59:24 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andrew Morton <akpm@osdl.org>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix bad URL in BSD acct help entry
Message-ID: <Pine.LNX.4.53.0408201456230.12798@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No idea how I could mess up that badly. Maybe I typed something into the 
wrong window.

Sorry,
Tim


--- linux-2.6.8.1/init/Kconfig	2004-08-17 21:38:55.000000000 +0200
+++ linux-2.6.8.1-urlfix/init/Kconfig	2004-08-20 14:55:13.000000000 +0200
@@ -123,7 +123,7 @@ config BSD_PROCESS_ACCT_V3
 	  process and it's parent. Note that this file format is incompatible
 	  with previous v0/v1/v2 file formats, so you will need updated tools
 	  for processing it. A preliminary version of these tools is available
-	  at <http://http://www.de.kernel.org/pub/linux/utils/acct/>.
+	  at <http://www.physik3.uni-rostock.de/tim/kernel/utils/acct/>.
 
 config SYSCTL
 	bool "Sysctl support"
