Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933252AbWKXUqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933252AbWKXUqR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 15:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935056AbWKXUqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 15:46:17 -0500
Received: from www.polish-dvd.com ([69.222.0.225]:64413 "HELO
	mail.webhostingstar.com") by vger.kernel.org with SMTP
	id S933252AbWKXUqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 15:46:16 -0500
Message-ID: <20061124144015.g6dnes3jb808884k@69.222.0.225>
Date: Fri, 24 Nov 2006 14:40:15 -0600
From: art@usfltd.com
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: 2.6.19-git compilation error pulled-2006/11/24/14:30CST -
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

