Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263262AbUCNCrl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 21:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbUCNCri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 21:47:38 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:25769 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S263257AbUCNCqx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 21:46:53 -0500
Message-Id: <200403140245.i2E2jKSx005375@eeyore.valparaiso.cl>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: finding out the value of HZ from userspace 
In-Reply-To: Message from Micha Feigin <michf@post.tau.ac.il> 
   of "Thu, 11 Mar 2004 16:17:03 +0200." <20040311141703.GE3053@luna.mooo.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Sat, 13 Mar 2004 23:45:17 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Micha Feigin <michf@post.tau.ac.il> said:
> Is it possible to find out what the kernel's notion of HZ is from user
> space?

What for? It should be invisible to userspace...

> It seem to change from system to system and between 2.4 (100 on i386)
> to 2.6 (1000 on i386).

And can also be tweaked when compiling, and depends on architecture, and...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
