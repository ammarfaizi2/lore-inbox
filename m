Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUJHS3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUJHS3x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 14:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264377AbUJHS0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 14:26:48 -0400
Received: from witte.sonytel.be ([80.88.33.193]:43412 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S270051AbUJHSYz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 14:24:55 -0400
Date: Fri, 8 Oct 2004 20:24:32 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ingo Molnar <mingo@elte.hu>
cc: "Jeff V. Merkey" <jmerkey@drdos.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       "jmerkey@comcast.net" <jmerkey@comcast.net>, jonathan@jonmasters.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Possible GPL Violation of Linux in Amstrad's E3 Videophone
In-Reply-To: <20041008122703.GA15604@elte.hu>
Message-ID: <Pine.GSO.4.61.0410082019100.12999@waterleaf.sonytel.be>
References: <100120041740.9915.415D967600014EC2000026BB2200758942970A059D0A0306@comcast.net>
 <35fb2e590410011509712b7d1@mail.gmail.com> <415DD1ED.6030101@drdos.com>
 <1096738439.25290.13.camel@localhost.localdomain> <41659748.9090906@drdos.com>
 <8B592DC4-18A9-11D9-ABEB-000393ACC76E@mac.com> <4165B265.2050506@drdos.com>
 <8550FDB8-18AC-11D9-ABEB-000393ACC76E@mac.com> <4165B53F.2060707@drdos.com>
 <20041008122703.GA15604@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Oct 2004, Ingo Molnar wrote:
> * Jeff V. Merkey <jmerkey@drdos.com> wrote:
> 
> > In business, counter negotiation is allowed. We will pay $50,000.00 in
> > cold, hard cash to be allowed to snapshot a single 2.<even number>
> > release that allows GPL conversion to a BSD style license. This offer
> > is real and we are ready to write a check today.
> 
> all the politics aside, the Linux 2.6 kernel, if developed from scratch
> as commercial software, takes at least this much effort under the
> default COCOMO model:
> 
>  Total Physical Source Lines of Code (SLOC)                = 4,287,449
>  Development Effort Estimate, Person-Years (Person-Months) = 1,302.68 (15,632.20) (Basic COCOMO model, Person-Months = 2.4 * (KSLOC**1.05))
>  Schedule Estimate, Years (Months)                         = 8.17 (98.10)
>   (Basic COCOMO model, Months = 2.5 * (person-months**0.38))
>  Estimated Average Number of Developers (Effort/Schedule)  = 159.35
>  Total Estimated Cost to Develop                           = $ 175,974,824
>   (average salary = $56,286/year, overhead = 2.40).
>  SLOCCount is Open Source Software/Free Software, licensed under the FSF GPL.
>  Please credit this data as "generated using David A. Wheeler's 'SLOCCount'."
> 
> and you want an unlimited license for $0.05m? What is this, the latest
> variant of the Nigerian/419 scam?

The biggest problem I have with counting `code size' (yes, we use sloccount at
work), is that given more time and resources than needed to implement the
required functionality, code size usually shrinks due to clean ups. So it costs
_more_ money to decrease the #loc. Software is just like protocols design:

| In protocol design, perfection has been reached not when there is nothing
| left to add, but when there is nothing left to take away.
|                                 -- RFC1925: The Twelve Networking Truths

Of course this is less true for the Linux kernel than for proprietary
commercial software, since we don't care about deadlines and take our time to
clean up bad code ;-)

So please don't settle for less than $500000000 :-) ... and I actually prefer
500000000 EUR :-) Which is actually pretty close to $500000 for each of the
10000 monkeys...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
