Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263346AbTCUS3O>; Fri, 21 Mar 2003 13:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263689AbTCUS2a>; Fri, 21 Mar 2003 13:28:30 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:58499
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263757AbTCUS10>; Fri, 21 Mar 2003 13:27:26 -0500
Date: Fri, 21 Mar 2003 19:42:37 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211942.h2LJgbE1025911@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: typo fix for tulip
Cc: jgarzik@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/net/tulip/winbond-840.c linux-2.5.65-ac2/drivers/net/tulip/winbond-840.c
--- linux-2.5.65/drivers/net/tulip/winbond-840.c	2003-03-06 17:04:27.000000000 +0000
+++ linux-2.5.65-ac2/drivers/net/tulip/winbond-840.c	2003-03-20 18:48:31.000000000 +0000
@@ -17,7 +17,7 @@
 	Support and updates available at
 	http://www.scyld.com/network/drivers.html
 
-	Do not remove the copyright infomation.
+	Do not remove the copyright information.
 	Do not change the version information unless an improvement has been made.
 	Merely removing my name, as Compex has done in the past, does not count
 	as an improvement.
