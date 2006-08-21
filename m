Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030519AbWHUO7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030519AbWHUO7s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 10:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030520AbWHUO7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 10:59:48 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:30358 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1030519AbWHUO7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 10:59:48 -0400
Message-Id: <200608211459.k7LExQON004366@laptop13.inf.utfsm.cl>
To: Helge Hafting <helge.hafting@aitel.hist.no>
cc: Chase Venters <chase.venters@clientec.com>,
       Helge Hafting <helgehaf@aitel.hist.no>,
       David Schwartz <davids@webmaster.com>, alan@lxorguk.ukuu.org.uk,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: GPL Violation? 
In-Reply-To: Message from Helge Hafting <helge.hafting@aitel.hist.no> 
   of "Mon, 21 Aug 2006 09:58:02 +0200." <44E9678A.7050704@aitel.hist.no> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Mon, 21 Aug 2006 10:59:26 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Mon, 21 Aug 2006 10:59:26 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helge.hafting@aitel.hist.no> wrote:
> Chase Venters wrote:
> > On Saturday 19 August 2006 06:30, Helge Hafting wrote:
> >
> >> Now, if someone actually distributes a closed-source module that
> >> circumvents EXPORT_SYMBOL_GPL, or relies on an accompagnying
> >> open source patch that removes the mechanism, this happens:
> >>
> >> 1. By doing this, they clearly showed that their module is outside the
> >>    gray area of "allowed binary-only modules". They definitively
> >>    made a "derived work" and distributed it.
> >>
> >> 2. Anybody who received this module may now invoke the GPL
> >>    (and the force of law, if necessary) to extract the
> >>    module source code from the maker.  And then this source
> >>    can be freely redistributed to all interested.
> >>

> > Actually, you can't just force the vendor to open up all of their
> > source code.

> Not all their source of course, just the source for the derived work.

Not even that.

> I.e. we'll get their driver, but not anything else they might have.

You could perhaps get the driver.

> >  The GPL isn't a contract - it's a license. If a vendor makes a
> > derived work from the Linux kernel and does not GPL-license said
> > derived work, they are indeed violating copyright as the license the
> > GPL provides no longer supports their ability to redistribute.
> >
> > However, the court decides what happens to the vendor. The court
> > might force the vendor to open up their code, but to my knowledge
> > this would be breaking brand new ground. I think it is more likely
> > that the plaintiff could be awarded monetary damages and the
> > defendant enjoined from further redistribution.

> Yes the GPL is a licence. By using the code, they have accepted
> the licence.

No. GPL kicks in when they distribute code.

>               If I use a copy of windows, I'll be forced to pay.

Windows is under a different "license" (they try to make it a contract,
which is another kettle of fish altogether, so don't go there).

> The reason courts usually award monetary damages is that
> money is what almost everybody wants.

They tell the offender to pay the owner for the actual damages they
suffered, and perhaps a punishment on top. If Bad Corp distributes my code,
which I don't make money off by virtue of distributing it GPLed, there are
no damages that I could ask to be restituted to me. If I write a book and
keep in to myself in my drawer, you grab a copy and publish it on the
Internet, no judge will ask you to pay damages as if it was the loss of
revenue for history's best selling bestseller.

In any case this is wildly off-topic here, so take your comments
elsewhere. If you want to know what really happens here, talk to a lawyer
or visit sites clueful on the matter and learn.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
