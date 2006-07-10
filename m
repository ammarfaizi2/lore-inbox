Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422755AbWGJSoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422755AbWGJSoO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 14:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422760AbWGJSoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 14:44:14 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:29071 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1422755AbWGJSoO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 14:44:14 -0400
Message-Id: <200607101841.k6AIfXgp012297@laptop11.inf.utfsm.cl>
To: "Daniel Bonekeeper" <thehazard@gmail.com>
cc: "Pavel Machek" <pavel@ucw.cz>,
       "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>,
       "Adrian Bunk" <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: Automatic Kernel Bug Report 
In-Reply-To: Message from "Daniel Bonekeeper" <thehazard@gmail.com> 
   of "Mon, 10 Jul 2006 12:40:07 EST." <e1e1d5f40607101040u3baf0da7r43d5538700b02e2@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Mon, 10 Jul 2006 14:41:33 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 10 Jul 2006 14:41:33 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Bonekeeper <thehazard@gmail.com> wrote:
> On 7/10/06, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> 
> Hi ! =)


Hi all out there!

> > Well, unless we have some volunteer to go through the bugreports and
> > sort them/kill the invalid ones/etc... this is going to do more harm
> > than good.

> As I told before, I wouldn't care to do that,

Who will, then?

>                                               as long as I know that
> it is actually being used (and useful).

If you don't care about the data...

>                                         The system (at the server
> side) could automatically

/Someone/ will have to program/configure/tweak/maintain that...

>                           route some reports (mark them as "tainted
> modules detected", etc, that sort of mechanical stuff),

Mechanical != trivial, and much less == "does it by itself, all alone"...

>                                                         and according
> to the frequency of certain bugs, I could check if they are actually
> real bugs. If so, they get reported here on LKML.

Which helps how in getting more new people up to speed and involved in bug
fixing? (Last I heard, that was the current bottleneck...)

>                                                   Since we can expect,
> maybe, dozens of thousands of reports per week, wouldn't be hard to
> distinct between real bugs, etc (if we use frequency as a marker). For
> example, if the number of reports on Suspend2 get risen up sensitively
> on some just-released kernel, this means that something that was added
> isn't working (so here comes the personal debug, where we can see if
> it's a new bug or a regression)

That kind of stuff is currently sitting in bugzillas all over the
distributions. And again, what is required is people willing to see if they
can reproduce the bug (and that may mean getting an obscure piece of
hardware, etc) and then see if they can fix it. 
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

