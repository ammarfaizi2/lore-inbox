Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263677AbTCUS3N>; Fri, 21 Mar 2003 13:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263698AbTCUS2f>; Fri, 21 Mar 2003 13:28:35 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:56707
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263748AbTCUS0W>; Fri, 21 Mar 2003 13:26:22 -0500
Date: Fri, 21 Mar 2003 19:41:37 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211941.h2LJfbjE025899@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: sk98 typo fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/net/sk98lin/skvpd.c linux-2.5.65-ac2/drivers/net/sk98lin/skvpd.c
--- linux-2.5.65/drivers/net/sk98lin/skvpd.c	2003-03-06 17:04:27.000000000 +0000
+++ linux-2.5.65-ac2/drivers/net/sk98lin/skvpd.c	2003-03-20 18:48:07.000000000 +0000
@@ -121,7 +121,7 @@
  ******************************************************************************/
 
 /*
-	Please refer skvpd.txt for infomation how to include this module
+	Please refer skvpd.txt for information how to include this module
  */
 static const char SysKonnectFileId[] =
 	"@(#)$Id: skvpd.c,v 1.26 2000/06/13 08:00:01 mkarl Exp $ (C) SK" ;
