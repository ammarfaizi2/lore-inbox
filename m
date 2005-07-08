Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVGHBM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVGHBM5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 21:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbVGHBM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 21:12:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13038 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261172AbVGHBMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 21:12:50 -0400
Date: Thu, 7 Jul 2005 18:12:23 -0700
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org, linux-audit@redhat.com
Subject: [PATCH] Add MAINTAINERS entry for audit subsystem
Message-ID: <20050708011223.GS9046@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been asked about this a couple times, and there's no info in
MAINTAINERS file.  Add MAINTAINERS entry for audit subsystem.

Signed-off-by: Chris Wright <chrisw@osdl.org>
---

diff --git a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -370,6 +370,10 @@ W:	http://www.thekelleys.org.uk/atmel
 W:	http://atmelwlandriver.sourceforge.net/
 S:	Maintained
 
+AUDIT SUBSYSTEM
+L:	linux-audit@redhat.com (subscribers-only)
+S:	Maintained
+
 AX.25 NETWORK LAYER
 P:	Ralf Baechle
 M:	ralf@linux-mips.org
