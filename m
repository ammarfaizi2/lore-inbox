Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756782AbWKXUx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756782AbWKXUx1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 15:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757490AbWKXUx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 15:53:27 -0500
Received: from tedsautoline.com ([69.222.0.225]:16798 "HELO
	mail.webhostingstar.com") by vger.kernel.org with SMTP
	id S1756782AbWKXUx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 15:53:27 -0500
Message-ID: <20061124144728.mcjynan4ylnwow04@69.222.0.225>
Date: Fri, 24 Nov 2006 14:47:28 -0600
From: art@usfltd.com
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: 2.6.19-git compilation error pull-2006/11/24/14:30 CST -
	spin_lock_irqsave_nested
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.1.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.19-git compilation error pull-2006/11/24/14:30 CST -  
spin_lock_irqsave_nested

compiled for 2.6.19 SMP PREEMPT x86_64


[linux-git-pull]$ make -j 8
   CHK     include/linux/version.h
   CHK     include/linux/utsrelease.h
   CHK     include/linux/compile.h
   MODPOST vmlinux
   Building modules, stage 2.
Kernel: arch/x86_64/boot/bzImage is ready  (#26)
   MODPOST 1290 modules
WARNING: "spin_lock_irqsave_nested" [net/irda/irda.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

xboom
