Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263664AbUECMr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUECMr3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 08:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263671AbUECMr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 08:47:29 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:40325 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S263664AbUECMr1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 08:47:27 -0400
Message-Id: <200405030004.i4304mY7009198@eeyore.valparaiso.cl>
To: Marc Boucher <marc@linuxant.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Tim Connors <tconnors+linuxkernel1083378452@astro.swin.edu.au>,
       "'lkml - Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license 
In-Reply-To: Message from Marc Boucher <marc@linuxant.com> 
   of "Sat, 01 May 2004 15:12:18 -0400." <772768DC-9BA3-11D8-B83D-000A95BCAC26@linuxant.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Sun, 02 May 2004 20:04:48 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Boucher <marc@linuxant.com> said:
> On May 1, 2004, at 1:07 AM, Martin J. Bligh wrote:
> 
> >> All bugs can be debugged or fixed, it's a matter of how hard it is
> >> to do (generally easier with open-source) and *who* is responsible
> >> for doing it (i.e. supporting the modules).
> >
> > Yes, exactly. The tainted mechanism is there to tell us that it's not
> > *our* problem to support it. And you deliberately screwed that up,
> > which is why everybody is pissed at you.
> 
> It was already screwed up, and causing unnecessary support burdens
> both on the community ("help! what does tainted mean")

A minor annoyance, no head hacker did ever respond to that on LKML.

>                                                        and vendors.

... got what was comming to them. A-OK.

> This thread and previous ones have shown ample evidence of that.

Of your stubborness, clearly.

> Let's deal with the root problem and fix the messages, as Rik van Riel
> has suggested.

Your help is welcome.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
