Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbVHHXyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbVHHXyo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 19:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbVHHXyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 19:54:44 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:49545 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S932366AbVHHXyn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 19:54:43 -0400
Date: Tue, 9 Aug 2005 01:54:24 +0200
Message-Id: <200508082354.j78NsO9q028858@wscnet.wsc.cz>
Subject: [PATCH] Removing maintainer's bad e-mails
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Jones <davej@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rolf Eike Beer <eike-kernel@sf-tec.de>
In-reply-to: <20050808224917.GP4006@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes 1 whole entry, which is no longer maintained and 1 e-mail,
which is not right.
[comtrol was posted by Rolf Eike Beer]

Generated in 2.6.13-rc5-mm1 kernel version.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>
Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

diff --git a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -202,13 +202,6 @@ P:	Colin Leroy
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
@@ -1975,7 +1968,6 @@ S:	Supported
 
 ROCKETPORT DRIVER
 P:	Comtrol Corp.
-M:	support@comtrol.com
 W:	http://www.comtrol.com
 S:	Maintained
 
