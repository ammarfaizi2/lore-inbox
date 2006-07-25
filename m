Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWGYOgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWGYOgX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 10:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbWGYOgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 10:36:23 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:26854 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932263AbWGYOgX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 10:36:23 -0400
Message-Id: <200607251435.k6PEZwh7004162@laptop13.inf.utfsm.cl>
To: Al Boldi <a1426z@gawab.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org 
In-Reply-To: Message from Al Boldi <a1426z@gawab.com> 
   of "Tue, 25 Jul 2006 07:57:00 +0300." <200607250757.00643.a1426z@gawab.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Tue, 25 Jul 2006 10:35:58 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Tue, 25 Jul 2006 10:35:58 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi <a1426z@gawab.com> wrote:
> H. Peter Anvin wrote:
> > Al Boldi wrote:
> > > Respect what?  The process or the content?

> > > Rejecting content due to disrespect for process guidelines would be
> > > rather sad.

> > No, it's not.  That's what you have to do to keep the kernel maintainable.
> >
> > > If the content is worth its salt, it should be accepted w/o delay, then
> > > modified to comply with the process guidelines as necessary.  It's what
> > > the GPL allows, afterall.

> > Uhm, no.  That's basically "throw it over the fence and let someone
> > else fix the crap."  Fix it first, then it can go in.

> Sure, it would be terrible, if we started to accept "crap", but I wouldn't 
> consider content that is worth its "salt", like reiserfs4, to be "crap".

If the content is OK, but requires a /lot/ of work to integrate, it is a
liability. 

> Rejection of content should be based on technical merits only, and no
> process guidelines should stay in the way of its preliminary acceptance.

Reiser 4 has been accepted in principle, so this isn't an issue at
all. There have been /serious/ technical objections to its current state,
tho...

> Otherwise, we would be asking for a return to a bureaucratic system that
> inhibits innovation, which I'm sure is not the intention of anybody, I
> hope.

There was never any bureaucratic system here, just a meritocracy. And yes,
the merits are not only in terms of "this code is cool" but also in terms
of "this code integrates well with the rest" and "there is a very good
chance that it will be maintained in-kernel by its creator"

> BTW, this does not mean that impoliteness should be rewarded, on the 
> contrary, impoliteness has no place anywhere, and should just be ignored, 
> even if the content is worth its salt.

How is that not rewarding impoliteness? Nobody here is forced to work on
the kernel. Somebody who doesn't want to play nice with others has no place
here.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
