Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262789AbUKRRNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262789AbUKRRNa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 12:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbUKRRK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 12:10:59 -0500
Received: from www.ssc.unict.it ([151.97.230.9]:4870 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S262779AbUKRRJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 12:09:06 -0500
Subject: [patch 1/1] Uml - update some copyright
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 18 Nov 2004 18:11:08 +0100
Message-Id: <20041118171108.3B70A55C98@zion.localdomain>
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.28.0.18; VDF: 6.28.0.80; host: ssc.unict.it)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Update/add some copyright notices.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.10-rc-paolo/arch/um/kernel/sigio_kern.c |    2 +-
 linux-2.6.10-rc-paolo/arch/um/sys-i386/sysrq.c    |    5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff -puN arch/um/kernel/sigio_kern.c~uml-comments arch/um/kernel/sigio_kern.c
--- linux-2.6.10-rc/arch/um/kernel/sigio_kern.c~uml-comments	2004-11-18 18:00:11.537308448 +0100
+++ linux-2.6.10-rc-paolo/arch/um/kernel/sigio_kern.c	2004-11-18 18:00:11.541307840 +0100
@@ -1,5 +1,5 @@
 /* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Copyright (C) 2002 - 2003 Jeff Dike (jdike@addtoit.com)
  * Licensed under the GPL
  */
 
diff -puN arch/um/sys-i386/sysrq.c~uml-comments arch/um/sys-i386/sysrq.c
--- linux-2.6.10-rc/arch/um/sys-i386/sysrq.c~uml-comments	2004-11-18 18:00:11.539308144 +0100
+++ linux-2.6.10-rc-paolo/arch/um/sys-i386/sysrq.c	2004-11-18 18:00:11.541307840 +0100
@@ -1,3 +1,8 @@
+/*
+ * Copyright (C) 2001 - 2003 Jeff Dike (jdike@addtoit.com)
+ * Licensed under the GPL
+ */
+
 #include "linux/kernel.h"
 #include "linux/smp.h"
 #include "linux/sched.h"
_
