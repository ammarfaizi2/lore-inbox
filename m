Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261834AbULOBib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbULOBib (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 20:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbULOBhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 20:37:35 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1551 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261848AbULOBas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 20:30:48 -0500
Date: Wed, 15 Dec 2004 02:30:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: wensong@linux-vs.org, ja@ssi.bg
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove subscribers-only ipvs mailing list
Message-ID: <20041215013043.GI12937@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's generally agreed, that maintainers mustn't contain subscribers-only 
lists.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc3-mm1-full/MAINTAINERS.old	2004-12-15 02:28:33.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/MAINTAINERS	2004-12-15 02:28:43.000000000 +0100
@@ -1595,11 +1595,10 @@
 IPVS
 P:	Wensong Zhang
 M:	wensong@linux-vs.org
 P:	Julian Anastasov
 M:	ja@ssi.bg
-L:	lvs-users@linuxvirtualserver.org
 S:	Maintained
 
 NFS CLIENT
 P:	Trond Myklebust
 M:	trond.myklebust@fys.uio.no

