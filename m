Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315358AbSEYUy3>; Sat, 25 May 2002 16:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315372AbSEYUy2>; Sat, 25 May 2002 16:54:28 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15364 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315358AbSEYUy1>; Sat, 25 May 2002 16:54:27 -0400
Date: Sat, 25 May 2002 13:53:41 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Karim Yaghmour <karim@opersys.com>, <linux-kernel@vger.kernel.org>
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
In-Reply-To: <E17BhpC-0003nd-00@starship>
Message-ID: <Pine.LNX.4.44.0205251349420.3923-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 25 May 2002, Daniel Phillips wrote:
>
> I'd like to take this opportunity to take a turn back towards the original
> issue: supposing that Ingo's/Red Hat's patented extension to the dcache is
> accepted into the kernel.  Would not the GPL's patent trap provision
> prevent Red Hat from distributing the result, unless Red Hat also provides
> a license for the patent permitting unrestricted use *regardless of
> commercial or noncommercial use* of the patent in the context of the GPL'd
> code?

Absolutely.

Patents are bad, but I think peoples "charge the red flag" reactions to
them are also bad.

I think it was Alan who just suggested to Andrea that he'd ask for an
explicit piece of paper _saying_ it was ok, instead of paniccing.

I don't much like patents, but we're forced to live with them. I suspect
the best thing we can do is to use them as well as we can. Which is why I
don't personally think it's a problem that RedHat, FSMlabs etc get
patents.

Can those patents result in trouble? Sure as hell. But let's put it this
way: I'm a _lot_ happier about a RedHat/FSMlabs patent that gets licensed
to GPL users than I am about a patent by somebody who would want to screw
with the GPL.

		Linus

