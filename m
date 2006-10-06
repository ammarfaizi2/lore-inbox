Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWJFQFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWJFQFK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 12:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbWJFQFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 12:05:09 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:63880 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932111AbWJFQFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 12:05:08 -0400
Message-Id: <200610061605.k96G56iB007083@laptop13.inf.utfsm.cl>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.19-rc1 (git 49f19ce401edfff937c448dd74c22497da361889)
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Fri, 06 Oct 2006 12:05:06 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Fri, 06 Oct 2006 12:05:06 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On sparc64 I'm getting:

  CC      arch/sparc64/kernel/irq.o
In file included from arch/sparc64/kernel/irq.c:24:
include/linux/irq.h:24:26: error: asm/irq_regs.h: No such file or directory
arch/sparc64/kernel/irq.c: In function 'handler_irq':
arch/sparc64/kernel/irq.c:561: error: too many arguments to function '__do_IRQ'
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
