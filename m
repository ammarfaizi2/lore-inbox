Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbVIBTuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbVIBTuM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 15:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbVIBTuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 15:50:12 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:47495 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1750877AbVIBTuK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 15:50:10 -0400
Date: Fri, 2 Sep 2005 21:49:47 +0200
Message-Id: <200509021949.j82JnlKl026403@wscnet.wsc.cz>
Subject: [PATCH, repost] Removing maintainer's bad e-mails
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rolf Eike Beer <eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes 1 whole entry, which is no longer maintained and 1 e-mail,
which is not right.
[comtrol was posted by Rolf Eike Beer]

Generated in 2.6.13-mm1 kernel version.

This patch was posted yet on:
21 Jul 2005
09 Sep 2005

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>
Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

 MAINTAINERS |    8 --------
 1 files changed, 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -208,13 +208,6 @@ P:	Colin Leroy
 M:	colin@colino.net
 S:	Maintained
 
-ADVANSYS SCSI DRIVER
-P:	Bob Frey
-M:	linux@advansys.com
-W:	http://www.advansys.com/linux.html
-L:	linux-scsi@vger.kernel.org
-S:	Maintained
-
 AEDSP16 DRIVER
 P:	Riccardo Facchetti
 M:	fizban@tin.it
@@ -2026,7 +2019,6 @@ S:	Supported
 
 ROCKETPORT DRIVER
 P:	Comtrol Corp.
-M:	support@comtrol.com
 W:	http://www.comtrol.com
 S:	Maintained
 
