Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263748AbTDHADK (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 20:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263820AbTDGX1T (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:27:19 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:9601
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263888AbTDGXQT (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:16:19 -0400
Date: Tue, 8 Apr 2003 01:35:09 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080035.h380Z93S009233@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: hdreg.h typo fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/include/linux/hdreg.h linux-2.5.67-ac1/include/linux/hdreg.h
--- linux-2.5.67/include/linux/hdreg.h	2003-02-10 18:38:30.000000000 +0000
+++ linux-2.5.67-ac1/include/linux/hdreg.h	2003-04-06 18:37:04.000000000 +0100
@@ -355,7 +355,7 @@
 #define SETFEATURES_DIS_MSN	0x31	/* Disable Media Status Notification */
 #define SETFEATURES_DIS_RETRY	0x33	/* Disable Retry */
 #define SETFEATURES_EN_AAM	0x42	/* Enable Automatic Acoustic Management */
-#define SETFEATURES_RW_LONG	0x44	/* Set Lenght of VS bytes */
+#define SETFEATURES_RW_LONG	0x44	/* Set Length of VS bytes */
 #define SETFEATURES_SET_CACHE	0x54	/* Set Cache segments to SC Reg. Val */
 #define SETFEATURES_DIS_RLA	0x55	/* Disable read look-ahead feature */
 #define SETFEATURES_EN_RI	0x5D	/* Enable release interrupt */
