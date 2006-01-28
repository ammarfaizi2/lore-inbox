Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422829AbWA1FX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422829AbWA1FX1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 00:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422830AbWA1FX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 00:23:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52932 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422829AbWA1FX0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 00:23:26 -0500
Date: Sat, 28 Jan 2006 00:22:58 -0500 (EST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Chase Venters <chase.venters@clientec.com>,
       "linux-os \\(Dick Johnson\\)" <linux-os@analogic.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Marc Perkel <marc@perkel.com>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Patrick McLean <pmclean@cs.ubishops.ca>,
       Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
In-Reply-To: <Pine.LNX.4.64.0601272101510.3192@evo.osdl.org>
Message-ID: <Pine.LNX.4.64.0601280001000.2909@evo.osdl.org>
References: <43D114A8.4030900@wolfmountaingroup.com> 
 <20060120111103.2ee5b531@dxpl.pdx.osdl.net>  <43D13B2A.6020504@cs.ubishops.ca>
 <43D7C780.6080000@perkel.com>  <43D7B20D.7040203@wolfmountaingroup.com> 
 <43D7B5C4.5040601@wolfmountaingroup.com> <43D7D05D.7030101@perkel.com> 
 <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com> 
 <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com> 
 <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse> 
 <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org> <1138387136.26811.8.camel@localhost>
 <Pine.LNX.4.64.0601272101510.3192@evo.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Jan 2006, Linus Torvalds wrote:
> 
> This is basic copyright law, btw, and has nothing to do with the GPL per 
> se. If you don't have a license, you don't have any copyright AT ALL.

This is really important, btw.

Yes, when we speak colloquially we talk about the fact that Linux is 
licensed "under the GPL", but that is _not_ how anybody actually has ever 
gotten a license legally. The ONLY way anybody has ever legally licensed 
Linux is either with the original very strict copyright _or_ thanks to the 
COPYING file. Nothing else really matters. 

So the version of the GPL has always been explicit. At no point has the 
kernel been distributed without a specific version being clearly mentioned 
in the ONLY PLACE that gave you rights to copy the kernel in the first 
place. So either you knew it was GPLv2, or you didn't have the right to 
copy it in the first place.

In other words, Linux has _never_ been licensed under anything but the GPL 
v2, and nobody has _ever_ gotten a legal Linux source distribution with 
anything but a complete copy of GPLv2 license file.

So when I say that the additions at the top of the COPYING file are 
nothing but clarifications, I'm not just making that up. Anybody who 
claims that any Linux kernel I've ever made has ever been licensed under 
anything else than those exact two licenses is just not correct.

And Alan, I know we've had this discussion before. You've claimed before 
that my clarifications are somehow "changing" the license, and I've told 
you before that no, they don't change the license, they just clarify 
things that people keep on gettign wrong, or keep on being nervous about.

So people can argue all they want about this. But unless you get a real 
legal opinion (not just any random shyster - a real judge making a 
statement, or a respected professional who states his firm legal opinion 
in no uncertain terms), I don't think you have a legal leg to stand on.

But no, IANAL. I'd be willing to bet real money that a real lawyer would 
back me up on this, though.

			Linus

---

PS. Just out of historical interest, the only other copyright license ever 
distributed with the kernel was this one:

 "This kernel is (C) 1991 Linus Torvalds, but all or part of it may be
  redistributed provided you do the following:

	- Full source must be available (and free), if not with the
	  distribution then at least on asking for it.

	- Copyright notices must be intact. (In fact, if you distribute
	  only parts of it you may have to add copyrights, as there aren't
	  (C)'s in all files.) Small partial excerpts may be copied
	  without bothering with copyrights.

	- You may not distibute this for a fee, not even "handling"
	  costs.

  Mail me at "torvalds@kruuna.helsinki.fi" if you have any questions."

and that one was only valid between kernel versions 0.01 and 0.12 or 
something like that.
