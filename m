Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267373AbUHJBEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267373AbUHJBEH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 21:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267375AbUHJBEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 21:04:07 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:17143 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267373AbUHJBED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 21:04:03 -0400
Date: Mon, 9 Aug 2004 18:03:58 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] Remove spaces from Skystar2 pci_driver.name field
Message-ID: <20040810010358.GA9344@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


More...

Please apply,
~Deepak

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>


===== drivers/media/dvb/b2c2/skystar2.c 1.7 vs edited =====
--- 1.7/drivers/media/dvb/b2c2/skystar2.c	Tue Jul 13 06:27:49 2004
+++ edited/drivers/media/dvb/b2c2/skystar2.c	Mon Aug  9 17:58:34 2004
@@ -2345,7 +2345,7 @@
 MODULE_DEVICE_TABLE(pci, skystar2_pci_tbl);
 
 static struct pci_driver skystar2_pci_driver = {
-	.name = "Technisat SkyStar2 driver",
+	.name = "SkyStar2",
 	.id_table = skystar2_pci_tbl,
 	.probe = skystar2_probe,
 	.remove = skystar2_remove,

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment and
 will die here like rotten cabbages." - Number 6
