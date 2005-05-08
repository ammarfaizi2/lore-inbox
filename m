Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262838AbVEHTQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbVEHTQk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 15:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbVEHTPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 15:15:23 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:58518 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262759AbVEHTJm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:09:42 -0400
Message-Id: <20050508184346.575481000@abc>
References: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:42:40 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-av7110-debug-comment.patch
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 11/37] av7110: fix comment
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fixed debugging instructions: av7110_debug -> debug (Oliver Endirss)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/ttpci/av7110_ir.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/ttpci/av7110_ir.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/ttpci/av7110_ir.c	2005-05-08 15:55:38.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/ttpci/av7110_ir.c	2005-05-08 16:14:54.000000000 +0200
@@ -10,7 +10,7 @@
 
 #define UP_TIMEOUT (HZ/4)
 
-/* enable ir debugging by or'ing av7110_debug with 16 */
+/* enable ir debugging by or'ing debug with 16 */
 
 static int ir_initialized;
 static struct input_dev input_dev;

--

