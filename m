Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262243AbVAIELM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262243AbVAIELM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 23:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262247AbVAIELL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 23:11:11 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:46983 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262243AbVAIEKv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 23:10:51 -0500
Message-Id: <200501090344.j093irLf027560@laptop11.inf.utfsm.cl>
To: Jon Smirl <jonsmirl@gmail.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: kernel versions on Linus bk tree 
In-Reply-To: Message from Jon Smirl <jonsmirl@gmail.com> 
   of "Sat, 08 Jan 2005 13:23:20 CDT." <9e473391050108102355c9a714@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Sun, 09 Jan 2005 00:44:52 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.4 (inti.inf.utfsm.cl [200.1.21.155]); Sun, 09 Jan 2005 01:10:46 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl <jonsmirl@gmail.com> said:
> I just came across a problem with the way the kernel is being
> versioned. The DRM driver needs an IFDEF for the four level page table
> change depending on kernel version built against. I used this:
> #if LINUX_VERSION_CODE < 0x02060a

Wait for 2.6.11 then. It is the price you pay for fooling around with
kernels in between versions.

If you are experimenting, you know what you are working with, so what is
the problem?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
