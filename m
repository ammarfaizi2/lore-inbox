Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313016AbSEXX2k>; Fri, 24 May 2002 19:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313038AbSEXX2j>; Fri, 24 May 2002 19:28:39 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36357 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313016AbSEXX2j>; Fri, 24 May 2002 19:28:39 -0400
Date: Fri, 24 May 2002 16:27:24 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Karim Yaghmour <karim@opersys.com>
cc: Andrea Arcangeli <andrea@e-mind.com>, Dan Kegel <dank@kegel.com>,
        Andrew Morton <akpm@zip.com.au>, Hugh Dickins <hugh@veritas.com>,
        Christoph Rohland <cr@sap.com>, Jens Axboe <axboe@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
In-Reply-To: <3CEEC729.74625C2B@opersys.com>
Message-ID: <Pine.LNX.4.44.0205241619590.28735-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 May 2002, Karim Yaghmour wrote:
>
> This matter remained unchanged until the FSF came out later and
> declared publicly that the patent was violating the GPL.

Side note: they did this, apparently while Caldera was in the process of
suing FSMlabs over the fact that they didn't want to pay for their
OpenUnix usage... Hmm..

> I could have understood that this was indeed genuine, but here we
> have Eben Moglen, a respected lawyer,

I would be a _lot_ happier with Moglen if he didn't have so many ties to
the FSF, and being biased. These days you can apparently buy a "gpl
compliance certification" from the FSF for $20k. Those kinds of ties do
_not_ make me any happier about the FSF's status as an independent entity.

The RT part of an app under RTLinux has to be a kernel module anyway, and
as I personally consider the GPL to be the only kind of module I care
about, I think that is good.

Whatever non-RT tools used to visualize the RT data equally clearly aren't
covered by _that_ particular patent, so I think the whole thing is a
complete and utter red herring.

		Linus


