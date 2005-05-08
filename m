Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262847AbVEHTQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262847AbVEHTQi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 15:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbVEHTQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 15:16:30 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:59542 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262847AbVEHTJn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:09:43 -0400
Message-Id: <20050508184346.661263000@abc>
References: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:42:41 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-av7110-ca-formatting.patch
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 12/37] av7110: fix indentation
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fix indentation

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/ttpci/av7110_ca.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/ttpci/av7110_ca.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/ttpci/av7110_ca.c	2005-05-08 15:55:38.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/ttpci/av7110_ca.c	2005-05-08 16:15:50.000000000 +0200
@@ -123,7 +123,7 @@ static void ci_ll_release(struct dvb_rin
 }
 
 static int ci_ll_reset(struct dvb_ringbuffer *cibuf, struct file *file,
-		int slots, ca_slot_info_t *slot)
+		       int slots, ca_slot_info_t *slot)
 {
 	int i;
 	int len = 0;

--

