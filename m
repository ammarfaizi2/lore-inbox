Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbUCSUVm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 15:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbUCSUVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 15:21:42 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:13823 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261933AbUCSUVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 15:21:39 -0500
Date: Fri, 19 Mar 2004 21:21:28 +0100
From: Armin Schindler <armin@melware.de>
Message-Id: <200403192021.i2JKLS3f020374@phoenix.one.melware.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6 i386 Kconfig typo fix
Cc: akpm@osdl.org, torvalds@osdl.org
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:4f0aeee4703bc17a8237042c4702a75a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

just a small patch to fix a typo.


Armin


--- linux/arch/i386/Kconfig.orig	2004-03-19 21:15:29.000000000 +0100
+++ linux/arch/i386/Kconfig	2004-03-19 21:16:37.000000000 +0100
@@ -819,7 +819,7 @@
 	depends on SMP && X86_IO_APIC
 	default y
 	help
- 	  The defalut yes will allow the kernel to do irq load balancing.
+ 	  The default yes will allow the kernel to do irq load balancing.
 	  Saying no will keep the kernel from doing irq load balancing.
 
 config HAVE_DEC_LOCK
