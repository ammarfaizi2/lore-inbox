Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266310AbUHWRpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266310AbUHWRpI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 13:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266333AbUHWRmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 13:42:40 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:43181 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S266295AbUHWRkY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 13:40:24 -0400
Message-Id: <200408231740.i7NHeC3V003763@laptop9.inf.utfsm.cl>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: DTrace-like analysis possible with future Linux kernels? 
In-Reply-To: Message from Joerg Schilling <schilling@fokus.fraunhofer.de> 
   of "Sun, 22 Aug 2004 22:14:12 +0200." <4128FE94.nail9U42DA799@burner> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Mon, 23 Aug 2004 13:40:12 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling <schilling@fokus.fraunhofer.de> said:
> Alan Cox wrote:
> 
> >> In Solaris DTrace is enabled in _normal production_ kernel and you can 
> >> hang any probe or probes set without restarting system or any runed
> >> application which was compiled withoud debug info.
> >
> >Solaris only runs on large computers. You don't want kprobes randomly on
> >your phone, pda, wireless router. Solaris deals with an extremely narrow
> >market segment of "big computers for people with lots of money".
> ...
> >> http://blogs.sun.com/roller/page/bmc/20040820#dtrace_on_lkml
> >> Bryan blog is also yet another Dtrace knowledge source ..
> >
> >Coo I thought only the Sun CEO spent his life making inappropriate
> >comments 8)
> 
> It seems that Alan does not like to miss a single day to degrade his 
> credibiltiy :-(

Strangely, it doesn't seem to affect his credibility at all. Yours, OTOH...

> A fact based discussion looks different...
> 
> -	What is a "large computer"?

Current Sun Enterprise. Typically several CPUs, several GiB RAM, connected
via fiber to TiB storage array.

> -	What is an "extremely narrow market segment"?

The one for the above machines. Duh...

> 	What is the evidence of this statement compared to Linux?

Millions of machines vs a few tens of thousands?

> -	What are the minimum requirements for a machine to run Linux?

Palm Pilot V or thereabouts.

> -	What are the minimum requirements for a machine to run Solaris?

Out of my league. My Sparc Ultra 1 can't. It is running Linux (Aurora)
quite happily, BTW.

> People who cannot answer these questions should not try to start mad
> speculations on derived conclusions.

Great! Does that mean you will /finally/ shut up?

PS: I do know for a fact that Alan did/does meddle with this kind of hardware.

> The size of the loadable dtrace module is ~ 100 kB, this is nothing bad even 
> for small appliances these days.

Add that, and a lot of other similarly small random junk, and we are soon
talking serious MiBs... Larry McVoy has made it very clear here that
Slowlaris got that bloated way one tiny, unnoticeable, not too relevant
feature at a time.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
