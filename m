Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263750AbUEWXo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263750AbUEWXo5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 19:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263756AbUEWXo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 19:44:57 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:41716 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263750AbUEWXoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 19:44:54 -0400
Date: Mon, 24 May 2004 01:44:48 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 =?iso-8859-1?Q?patch=5D=A0mor?=
	=?iso-8859-1?Q?e?= InterMezzo removal
Message-ID: <20040523234447.GE16099@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes the MAINTAINERS entry for InterMezzo.

Additioninally, the following file can be removed:

  include/linux/fsfilter.h

I've double-checked nothing else uses it.

cu
Adrian


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
