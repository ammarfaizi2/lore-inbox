Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317121AbSFBEDX>; Sun, 2 Jun 2002 00:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317122AbSFBEDW>; Sun, 2 Jun 2002 00:03:22 -0400
Received: from age.cs.columbia.edu ([128.59.22.100]:43535 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S317121AbSFBEDV>; Sun, 2 Jun 2002 00:03:21 -0400
Date: Sun, 2 Jun 2002 00:03:06 -0400 (EDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Keith Owens <kaos@ocs.com.au>, Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: KBuild 2.5 Impressions
In-Reply-To: <E17DZCa-0007hI-00@starship>
Message-ID: <Pine.LNX.4.44.0206012349360.671-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 May 2002, Daniel Phillips wrote:

> > Are YOU willing to maintain it if Keith abandons it, though?
> 
> That is pure FUD, shame on you.

FUD? Heh. No, it's a simple question and you haven't answered it.

> What I do not appreciate about Kai's effort is that it is divisive.

Read below. I don't have much time to waste on this topic, so I'll be 
brief.

> There is exactly one valid objection I've seen to kbuild 2.5 inclusion,
> and that is the matter of breaking up the patch.  Having done a quick
> tour through the whole patch set, I now know that there are some
> easy places to break it up:

And that's precisely the wrong way to break it up. You'll waste your time
and you'll probably hit Linus' bit bucket in no time. Thank you very much,
but I can split patches based on the files they touch by myself, I don't
need your help.

What you and other very vocal proponents of kbuild25 don't understand is 
that you need break it up __functionally__. That is, add one feature at a 
time. That way, good features can be added without much of a discussion, 
and debatable features can be, well, debated.

Unfortunately, I don't see Keith doing this anytime soon. He's too much in 
love with his baby to risk seeing parts of it being thrown away, so he's 
taking an all-or-nothing attitude.

Fortunately, it is precisely what Kai is doing. He deserves a big THANKS 
for doing it, not your silly bashing. I also saw some good work on this 
from Sam Ravnborg on the list.

Anyway, EOT for me.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

