Return-Path: <linux-kernel-owner+w=401wt.eu-S932786AbWLZU5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932786AbWLZU5h (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 15:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932789AbWLZU5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 15:57:36 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:45612 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932786AbWLZU5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 15:57:35 -0500
Message-Id: <200612261637.kBQGbmoI016617@laptop13.inf.utfsm.cl>
To: James C Georgas <jgeorgas@rogers.com>
cc: knobi@knobisoft.de, linux-kernel@vger.kernel.org
Subject: Re: Binary Drivers 
In-Reply-To: Message from James C Georgas <jgeorgas@rogers.com> 
   of "Tue, 26 Dec 2006 08:28:52 CDT." <1167139732.15424.48.camel@Rainsong> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Tue, 26 Dec 2006 13:37:48 -0300
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.19.1]); Tue, 26 Dec 2006 17:57:22 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James C Georgas <jgeorgas@rogers.com> wrote:

[...]

> Let's summarize the current situation:
> 1) Hardware vendors don't have to tell us how to program their products,
> as long as they provide some way to use it (i.e. binary blob driver).

No. They have absolutely no obligation to tell you anything. If they sell
you a card with a binary driver that /only/ works with, say, Minix, it is
up to you to buy it or not.

> 2) Hardware vendors don't want to tell us how to program their products,
> because they think this information is their secret sauce (or maybe
> their competitor's secret sauce).

And lots of other reasons, including that with detailed specs you might be
able to continue using the same card for 3 or 5 years, when they'd love to
sell you a replacement next year... Creating, vetting and maintaining specs
is /hard/ work, and costs money. If it won't bring a measurable increase in
income, why do it?

> 3) Hardware vendors don't tell us how to program their products, because
> they know about (1) and they believe (2).

The law says (1), and they know (2) for a fact.

> 4) We need products with datasheets because of our development model.

Yep.

> 5) We want products with capabilities that these vendors advertise.

Yep.

> 6) Products that satisfy both (4) and (5) are often scarce or
> non-existent.

Just too bad.

> So far, the suggestions I've seen to resolve the above conflict fall
> into three categories:

> a) Force vendors to provide datasheets. 

How?

> b) Entice vendors to provide datasheets.

How?

> c) Reverse engineer the hardware and write our own datasheets.

Not always legal...

> Solution (a) involves denial of point (1), mostly through the use of
> analogy and allegory.

These are big companies, who deal in hard realities and cold cash. Poetry
won't get you anywhere.

>                       Alternatively, one can try to change the law
> through government channels.

Won't happen before open source is so prevalent that the point has long
become moot.

> Solution (b) requires market pressure,

Will happen once open source has a large enough slice of a lucrative pie.
I.e., it is happening today with "server class" machines.

>                                        charity,

A company is bound /by law/ to make as much profit as possible. Whoever
wants to go this route might spend some time as a neighbor to the Enron et
al folks.

>                                                 or visionary management.

This cuts both ways... visionary management made small companies big, and
huge companies dissappear from the face of the earth.

> We can't exert enough market pressure currently to make much difference.

OK.

> Charity sometimes gives us datasheets for old hardware.

OK.

>                                                         Visionary
> management is the future.

Don't they tell that all aspiring MBAs...

> Solution (c) is what we do now, with varying degrees of success. A good
> example is the R300 support in the radeon DRM module.

And others.

And this is not the only avenue persued, not by far. Some developers are
chummy with the engineers behind the devices they support, and get some
help that way. There are people who convinced their companies to let them
work on Linux drivers on their own time (with access to the people in the
know and datasheets, one would presume), others have gone so far as to be
able to work part-time on Linux drivers. Some companies have hired
developers under NDA to develop drivers, others have given out datasheets
(and access to sample hardware) under NDA (or just "don't give this out too
freely") to interested developers. Then there are others (IBM comes to
mind) where the company itself is officially developing drivers for their
hardware. Sure, most of the more backstage deals you won't ever hear about,
and for some of the other cases you might have absolutely no interest. Fact
is, Linux has /by far/ the best hardware support of all operating systems
out there. You only notice the (small) minority of devices that don't work
(yet). Sure, it is mostly in the latest glitter where support is currently
lacking, and this distorts the perspective quite a bit.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
