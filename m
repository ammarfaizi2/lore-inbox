Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261500AbTCGK4o>; Fri, 7 Mar 2003 05:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261501AbTCGK4n>; Fri, 7 Mar 2003 05:56:43 -0500
Received: from [195.39.17.254] ([195.39.17.254]:772 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261500AbTCGK4l>;
	Fri, 7 Mar 2003 05:56:41 -0500
Date: Thu, 6 Mar 2003 17:41:46 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed *notrademarkhere* clone
Message-ID: <20030306164146.GF2781@zaurus.ucw.cz>
References: <200303020011.QAA13450@adam.yggdrasil.com> <3E615C38.7030609@pobox.com> <20030302014039.GC1364@dualathlon.random> <3E616224.6040003@pobox.com> <b3rtr2_rmg_1@cesium.transmeta.com> <3E623B9A.8050405@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E623B9A.8050405@pobox.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> While people would certainly use it, I can't help but think that a BK 
> clone would damage other open source SCM efforts.  I call this the 
> "SourceForge Syndrome":

Where do I get pills for that one? :-)

> 	Q. I found a problem/bug/annoyance, how do I solve it?
> 	A. Clearly, a brand new sourceforge project is called for.
> 
> My counter-question is, why not improve an _existing_ open source SCM 
> to read and write BitKeeper files?

I of course thought about that (I'm not yet
hit *that* hard by sf syndrome :-), but:

a) I might extend cssc, but bitbucket is
naturally layer *over* cssc, and cssc
is GNU program (copyright assignment
needed) and is C++. I do not feel like
writing new code in C++, and I do not
like their codingstyle.

b) take something else, *merge cssc to
it*, then add my stuff. Ouch. svn is out
because of licensing, cvs is not powerfull
enough, and I do not like arch. (I did
not know abojt opencm, sorry). Ouch
and this would mean fork, anyway,
because developers of that project
would probably not be happy about
those copyrights (FSF!).

c) so new sf project is indeed way to go :-(.

I hope you understand now,

				Pavel

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

