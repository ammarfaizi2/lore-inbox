Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965143AbWIZX21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965143AbWIZX21 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 19:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965146AbWIZX21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 19:28:27 -0400
Received: from xenotime.net ([66.160.160.81]:5080 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965143AbWIZX20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 19:28:26 -0400
Date: Tue, 26 Sep 2006 16:29:39 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: ak@suse.de
Subject: [PATCH] Document x86_64 quilt tree in MAINTAINERS
Message-Id: <20060926162939.241f1c88.rdunlap@xenotime.net>
In-Reply-To: <200609262303.k8QN3hMr019584@hera.kernel.org>
References: <200609262303.k8QN3hMr019584@hera.kernel.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> [PATCH] Document my tree in Documentation/HOWTO
> Signed-off-by: Andi Kleen <ak@suse.de>

How about this way too (or instead)?
---

From: Randy Dunlap <rdunlap@xenotime.net>

List x86_64 quilt tree in MAINTAINERS.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 MAINTAINERS |    1 +
 1 files changed, 1 insertion(+)

--- linux-2618-g5.orig/MAINTAINERS
+++ linux-2618-g5/MAINTAINERS
@@ -3371,6 +3371,7 @@ P:	Andi Kleen
 M:	ak@suse.de
 L:	discuss@x86-64.org
 W:	http://www.x86-64.org
+T:	quilt ftp.firstfloor.org:/pub/ak/x86_64/quilt/
 S:	Maintained
 
 YAM DRIVER FOR AX.25
