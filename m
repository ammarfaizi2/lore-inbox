Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282997AbRLDJ56>; Tue, 4 Dec 2001 04:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283005AbRLDJ5t>; Tue, 4 Dec 2001 04:57:49 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:11280 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S283000AbRLDJ5j>;
	Tue, 4 Dec 2001 04:57:39 -0500
Message-Id: <200112040121.fB41LkQP026663@sleipnir.valparaiso.cl>
To: "Stanislav Meduna" <stano@meduna.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Coding style - a non-issue 
In-Reply-To: Your message of "Mon, 03 Dec 2001 10:07:59 BST."
             <01Dec3.100854cet.117132@fwetm.etm.at> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Mon, 03 Dec 2001 22:21:46 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stanislav Meduna" <stano@meduna.org> said:
> Horst von Brand wrote:

[...]

> > Complex software *has* bugs, bugs which aren't apparent
> > except under unsusual circumstances are rarely found in the
> > first round of bug chasing.

> Sure. But we now have 2.4.16, not 2.4.0 and guess what? -
> there is a big thread about fs corruption going right now
> in the l-k  :-( This should _not_ happen in the stab{le,ilizing}
> series and if it happened, the cause should be identified
> and measures taken.

Glitches _do_ happen. IIRC, there have been _less_ in 2.4.x than before
(might just be skewed perspective...).

> I for one think that the kernel has overgrown its current
> development model and that some _incremental_ steps
> in the direction of both more formal control and delegation
> of responsibilities are needed. I think that the most active
> kernel developers should discuss the future of the development
> model, as they are the only ones that can really come up
> with a solution.

Right. Or somebody has to fork off a "QA-linux". Or people should help with
QA (kernel-janitors, delelop tests, run tests and report back, ...)

[...]

> > > As a user of the vendor's kernel I have no idea what to do
> > > with a bug.
> > 
> > Report it to the vendor, through the documented channels?
> 
> Did this. It is two months, I did some cornering of the problem
> and augmented the report several times. The issue is still NEW,
> without any response asking to try a patch, supply more details
> or such. Yes, this speaks more of the vendor than of the Linux.

Change vendor. That is one of the beauties of Linux: If your vendor doesn't
get their act together, you can switch.

> But what impression do you think the average user gets from
> such experience?

Bad, no doubt. But fear not, with the "marvelous engineering" of some
vendors of closed products you wait for _years_ for fixes to severe bugs.
So in perspective Linux only looks bad. They look horrible ;-/
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
