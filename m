Return-Path: <linux-kernel-owner+w=401wt.eu-S1753186AbWLYAJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186AbWLYAJw (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 19:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbWLYAJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 19:09:52 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:48379 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753186AbWLYAJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 19:09:51 -0500
Message-Id: <200612250009.kBP09jlE004582@laptop13.inf.utfsm.cl>
To: Rok Markovic <kernel@kanardia.eu>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Binary Drivers 
In-Reply-To: Message from Rok Markovic <kernel@kanardia.eu> 
   of "Sun, 24 Dec 2006 22:05:08 BST." <458EEB84.30509@kanardia.eu> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Sun, 24 Dec 2006 21:09:45 -0300
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Delayed for 00:14:44 by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.21.155]); Sun, 24 Dec 2006 21:09:47 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rok Markovic <kernel@kanardia.eu> wrote:
> It seems that debate around cars and drivers has gone too far (IMHO).

Ditto.

>                                                                       I
> do not think that there is a question if we have any right to demand
> details about hardware from manufactorers -> we are NOT.

OK.

>                                                          But I think that
> we have right to know how to use it.

The card is designed for use with /Windows/, you get a /Windows/ driver.
That your PC is able to also run, say, Plan 9, is not the manufacturer's
business at all, it is /your/ choice, and /your/ problem if what the
manufacturer provides doesn't help you there.

The manufacturer is keeping his part of the deal. You don't like the deal,
tough luck.

>                                       I will translate this to CAR
> language - We have to know how to drive the car but not all the details
> how is this done, so we can drive a car without the "driver". We do not
> need an exact knowledge about engine, ECU, suspension,...


Exactly.

> Now the real question:
> 
> Why are manufatorers afraid to give us this information?

Not "afraid". It is more expensive to them:

- Because they would have to pick developer's brains and write it down,
  make sure it is complete, check it for publishing, etc. That costs money
  (and ties up key developers, and...) for /very/ little gain (open source
  systems is something like a 5 to 10% of all systems, mostly servers where
  highest performance isn't asked for, so the market for current high-end
  cards (where the brains are there at all for picking) is /extremely/
  small).
- Because they would have to get permission to do so from third parties,
  that means paying real money for little gain
- Because sometimes it is just "we tried several combinations, this one(s)
  happen to work, dunno why". How do you write something like that down?
- Because wrong settings might break the hardware, people fiddling around
  would then want a replacement, a very real cost
- Because you can't write any software at all without violating some
  patent. In this area, it is probable that everybody is violating
  everybody else's patents, and making that easy to find out (via source
  code or specs) opens you up to lawsuits. Lawyers (and common sense) will
  tell yo not to go there unless it is very worthwhile. And it isn't (see
  above)
- See the bletcherous workarounds for many device bugs (or downright design
  braindamage) in the in-kernel drivers. They might be just embarrased by
  the junk they shove out the door (We all know it happens with software,
  right? Hardware is much the same...). And they can't just work a year or
  so longer to get them ironed out, by then they could be right out of
  business.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
