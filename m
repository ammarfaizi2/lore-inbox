Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261765AbUJYL4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbUJYL4j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 07:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbUJYL4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 07:56:39 -0400
Received: from 202-47-55-78.adsl.gil.com.au ([202.47.55.78]:44040 "EHLO
	longlandclan.hopto.org") by vger.kernel.org with ESMTP
	id S261765AbUJYL4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 07:56:33 -0400
Message-ID: <417CE970.4010300@longlandclan.hopto.org>
Date: Mon, 25 Oct 2004 21:54:24 +1000
From: Stuart Longland <stuartl@longlandclan.hopto.org>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
References: <4176E08B.2050706@techsource.com>
In-Reply-To: <4176E08B.2050706@techsource.com>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Timothy Miller wrote:
[ ... snip ... ]

> In short, what I have been proposing to my superiors is the development
> of a graphics card specifically for open source systems.  This means
> full disclosure on all register interfaces so that no one has to deal
> with anything closed source (BIOS included).  The goal here is to
> produce a graphics card which is a Free Software geek's dream in terms
> of openness.

This would be my dreams come true.  At the moment I'm running a Radeon
9200SE in my box -- which really under-performs under Linux using the
opensource driver.  Unfortunately, ATI's crappy binary (yick! I hate
binary drivers in general) messed up my X server settings, needless to
say it was gone in 5 minutes flat.

An alternate video card manufacturer who is open to everyone would make
a nice change.

Perhaps you could test the water with other devices?  Some people
mentioned sound cards, but also why not ethernet, wireless network
cards, etc?

> I can produce more detail later, but first, some characteristics and
> advantages of what I'm proposing:
>
[ ... snip ... ]
> - The card "just works" with Linux because, maybe, the drivers would go
> into main-line

This would be a *big* bonus.  One of the things that drove me away fron
nVidia and the later ATI cards is having to recompile their crappy
driver each time I update the kernel.

Not to mention the pain when to compilling programs, only to discover
that they've fiddled with the openGL libraries.

> (1) Would the sales volumes of this product be enough to make it worth
> producing (ie. profitable)?

Difficult to say.  Provided it wasn't too expensive, I'd consider it
worth while.  This is why I suggest testing the water with something
else for starters... that would get you income you can pour into
researching and developing a video card chipset.

> (2) How much would you be willing to pay for it?

Bear in mind that I'm a poor uni student :-)
I spose AU $80 would be as much as I'd pay for a purely 2D graphic card.

> (3) How do you feel about the choice of neglecting 3D performance as a
> priority?  How important is 3D performance?  In what cases is it not?

This is fair enough... suppose you went with the fully programmable
firmware idea -- upgrading the card would largely be a case of replacing
the firmware.  In that case, this would seem reasonable to me.

> (4) How much extra would you be willing to pay for excellent 3D
> performance?

Quadruple the above price maybe?  That would be absolute TOPS for me.

One question that needs to be asked -- how would one obtain one of these
cards?  Would I have to somehow order it online or would there be a
distributor somewhere in Australia where I could obtain one?

> (5) What's most important to you, performance, price, or stability?

1. Stability
2. Price
3. Performance

> I haven't worked out a complete design spec for this product.  The
> reason is that what we think people want and what people REALLY want may
> not be congruent.  If you have a good idea for a piece of graphics
> hardware which you think would be beneficial to the free software
> community (and worth it for a company to produce), then Tech Source, as
> a graphics company, might be willing to sell it.

I think the idea of implementing OpenGL fully in hardware has some nice
benefits.  A bit point is that there's less in the driver to go wrong,
less code to debug.  The other point is that it makes cross-platform
drivers more trivial.

> Oh, and before you flame me, YES, I AM doing market research for Tech
> Source here, but NO, I am not doing it at THEIR request.

Hey... I'm glad you had the courage to come here and ask :-) I get to
have my say that way. :-D

Probably my main comment, if anything would be to initially start small.
 Okay, the 2D market is more or less sorted -- one can pick up a decent
Matrox or S3 video card to perform that task for under AU$20, so unless
you we're really able to cut the costs down, this would not be so
profitable (except for the embedded market of course).

Is it worth perhaps looking at implementing a card with crude OpenGL
(i.e. ATI Mach64/NVidia Riva grade) and working up from there?

Again, I'll make the point that it may be worth producing some other
hardware (e.g. network cards, sound cards, etc) to test the water.  That
way, you get an idea of what the market is for opensource hardware in
general.  This will also give you an income that can help fund the
development of a GPU for use on your final holy grail.

I'd be interested to see how it goes... Good luck with this venture.
Hope it goes well.
- --
+-------------------------------------------------------------+
| Stuart Longland -oOo- http://stuartl.longlandclan.hopto.org |
| Atomic Linux Project     -oOo-    http://atomicl.berlios.de |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
| I haven't lost my mind - it's backed up on a tape somewhere |
+-------------------------------------------------------------+
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBfOlvuarJ1mMmSrkRApNiAJ0TVNnlANztd3KTfCyvYQem3nLPVQCeMCxG
4WbFlfSAw5k+xfvFmuR42Fs=
=JkPG
-----END PGP SIGNATURE-----
