Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266588AbUGPRIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266588AbUGPRIf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 13:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266598AbUGPRIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 13:08:35 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:51380 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266588AbUGPRId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 13:08:33 -0400
Date: Fri, 16 Jul 2004 10:08:32 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH TRIVIAL] Add Intel IXP2400 & IXP2800 to PCI.ids
Message-ID: <20040716170832.GA4997@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is already in sf.net, just not upstream.

~Deepak


===== drivers/pci/pci.ids 1.64 vs edited =====
--- 1.64/drivers/pci/pci.ids	Sat Jun 12 11:29:20 2004
+++ edited/drivers/pci/pci.ids	Wed Jul 14 21:02:42 2004
@@ -8174,7 +8174,9 @@
 	84e6  460GX - 82466GX Wide and fast PCI eXpander Bridge (WXB)
 	84ea  460GX - 84460GX AGP Bridge (GXB function 1)
 	8500  IXP4xx Family  Network Processor (IXP420, 421, 422, 425 and IXC1100)
-	9000  Intel IXP2000 Familly Network Processor
+	9000  IXP2000 Family Network Processor
+	9001  IXP2400 Network Processor
+	9004  IXP2800 Network Processor
 	9621  Integrated RAID
 	9622  Integrated RAID
 	9641  Integrated RAID

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment and
 will die here like rotten cabbages." - Number 6
