Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbWIVTgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbWIVTgt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 15:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWIVTgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 15:36:49 -0400
Received: from xenotime.net ([66.160.160.81]:2244 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964811AbWIVTgs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 15:36:48 -0400
Date: Fri, 22 Sep 2006 12:37:56 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: ricknu-0@student.ltu.se, lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] dontdiff: add utsrelease.h
Message-Id: <20060922123756.15e8dbfb.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Add auto-generated utsrelease.h to dontdiff file.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/dontdiff |    1 +
 1 files changed, 1 insertion(+)

--- linux-2618-all.orig/Documentation/dontdiff
+++ linux-2618-all/Documentation/dontdiff
@@ -135,6 +135,7 @@ tags
 times.h*
 tkparse
 trix_boot.h
+utsrelease.h*
 version.h*
 vmlinux
 vmlinux-*


---
