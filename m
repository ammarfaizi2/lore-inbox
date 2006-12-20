Return-Path: <linux-kernel-owner+w=401wt.eu-S964999AbWLTLSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbWLTLSO (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 06:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965001AbWLTLSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 06:18:14 -0500
Received: from mail.admingilde.org ([213.95.32.147]:40931 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964999AbWLTLSO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 06:18:14 -0500
X-Greylist: delayed 2347 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Dec 2006 06:18:13 EST
Date: Wed, 20 Dec 2006 11:39:04 +0100
From: Martin Waitz <tali@admingilde.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: [PATCH] kernel-doc: remove myself from MAINTAINERS
Message-ID: <20061220103904.GP12411@admingilde.org>
Mail-Followup-To: Randy Dunlap <randy.dunlap@oracle.com>,
	lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
References: <20061219231019.6df16e1c.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061219231019.6df16e1c.randy.dunlap@oracle.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't have the time to work on Linux Documentation, so I really
should document that in MAINTAINERS.  With Randy, kernel-doc is in
good hands anyway.

Signed-off-by: Martin Waitz <tali@admingilde.org>
---

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e926e7..ba586b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -943,11 +943,8 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 
 DOCBOOK FOR DOCUMENTATION
-P:	Martin Waitz
-M:	tali@admingilde.org
 P:	Randy Dunlap
 M:	rdunlap@xenotime.net
-T:	git http://tali.admingilde.org/git/linux-docbook.git
 S:	Maintained
 
 DOCKING STATION DRIVER

-- 
Martin Waitz
