Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263673AbTCUSEH>; Fri, 21 Mar 2003 13:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263674AbTCUSEH>; Fri, 21 Mar 2003 13:04:07 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:30595
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263673AbTCUSEG>; Fri, 21 Mar 2003 13:04:06 -0500
Date: Fri, 21 Mar 2003 19:19:21 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211919.h2LJJLIt025687@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: __NO_VERSION_ for ati_pcigart
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/char/drm/ati_pcigart.h linux-2.5.65-ac2/drivers/char/drm/ati_pcigart.h
--- linux-2.5.65/drivers/char/drm/ati_pcigart.h	2003-02-10 18:38:53.000000000 +0000
+++ linux-2.5.65-ac2/drivers/char/drm/ati_pcigart.h	2003-03-14 00:52:15.000000000 +0000
@@ -27,7 +27,6 @@
  *   Gareth Hughes <gareth@valinux.com>
  */
 
-#define __NO_VERSION__
 #include "drmP.h"
 
 #if PAGE_SIZE == 65536
