Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWGBC2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWGBC2d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 22:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWGBC2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 22:28:33 -0400
Received: from xenotime.net ([66.160.160.81]:58763 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750792AbWGBC2c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 22:28:32 -0400
Date: Sat, 1 Jul 2006 19:31:16 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, tali@admingilde.org
Subject: [PATCH] kernel-doc MAINTAINERS
Message-Id: <20060701193116.6b7bc7ae.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Martin says that I can add self to MAINTAINERS.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 MAINTAINERS |    2 ++
 1 files changed, 2 insertions(+)

--- linux-2617-g19.orig/MAINTAINERS
+++ linux-2617-g19/MAINTAINERS
@@ -861,6 +861,8 @@ S:	Maintained
 DOCBOOK FOR DOCUMENTATION
 P:	Martin Waitz
 M:	tali@admingilde.org
+P:	Randy Dunlap
+M:	rdunlap@xenotime.net
 T:	git http://tali.admingilde.org/git/linux-docbook.git
 S:	Maintained
 


---
