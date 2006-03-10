Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWCJFwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWCJFwP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 00:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbWCJFwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 00:52:15 -0500
Received: from koto.vergenet.net ([210.128.90.7]:60061 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1751153AbWCJFwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 00:52:14 -0500
Date: Fri, 10 Mar 2006 14:52:01 +0900
From: Horms <horms@verge.net.au>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org, kfish@verge.net.au
Subject: [PATCH] Documentation: Reorder documentation of nomca and nomce
Message-ID: <20060310055200.GA13545@verge.net.au>
References: <20060222005755.GA4903@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222005755.GA4903@verge.net.au>
X-Cluestick: seven
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My patch to add brief documentation of the nomca boot parameter
added it out of alphabetical order.

Signed-Off-By: Horms <horms@verge.net.au>

 kernel-parameters.txt |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

d6235c651c5241208e67cdfb2ab6aa23c877a178
diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 7520539..86eee2c 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1032,10 +1032,10 @@ running once the system is up.
 	noltlbs		[PPC] Do not use large page/tlb entries for kernel
 			lowmem mapping on PPC40x.
 
-	nomce		[IA-32] Machine Check Exception
-
 	nomca		[IA-64] Disable machine check abort handling
 
+	nomce		[IA-32] Machine Check Exception
+
 	noresidual	[PPC] Don't use residual data on PReP machines.
 
 	noresume	[SWSUSP] Disables resume and restores original swap
