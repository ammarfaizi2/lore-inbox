Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbVAIWmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbVAIWmE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 17:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbVAIWmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 17:42:03 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:23564 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261900AbVAIWmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 17:42:00 -0500
Date: Sun, 9 Jan 2005 23:41:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 =?iso-8859-1?Q?patch=5D=A0remov?=
	=?iso-8859-1?Q?e?= InterMezzo MAINTAINERS entry
Message-ID: <20050109224154.GA1483@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

InterMezzo was removed in 2.6, so there's no reason for keeping a 
MAINTAINERS entry.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.7-rc1-full/MAINTAINERS.old	2004-05-23 23:52:55.000000000 +0200
+++ linux-2.6.7-rc1-full/MAINTAINERS	2004-05-23 23:53:07.000000000 +0200
@@ -1092,13 +1092,6 @@
 W:	http://sourceforge.net/projects/e1000/
 S:	Supported
 
-INTERMEZZO FILE SYSTEM
-P:	Cluster File Systems	
-M:	intermezzo-devel@lists.sf.net
-W:	http://www.inter-mezzo.org/
-L:	intermezzo-discuss@lists.sourceforge.net
-S:	Maintained
-
 IOC3 DRIVER
 P:	Ralf Baechle
 M:	ralf@oss.sgi.com
