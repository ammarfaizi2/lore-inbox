Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129727AbRCHVdS>; Thu, 8 Mar 2001 16:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129730AbRCHVdJ>; Thu, 8 Mar 2001 16:33:09 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:63129 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129727AbRCHVc7>;
	Thu, 8 Mar 2001 16:32:59 -0500
Date: Thu, 8 Mar 2001 16:31:27 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: God <atm@pinky.penguinpowered.com>
cc: Ben Greear <greearb@candelatech.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2 ext2 filesystem corruption ? (was 2.4.2: What happened
 ?(No
In-Reply-To: <Pine.LNX.4.21.0103081511560.878-100000@scotch.homeip.net>
Message-ID: <Pine.GSO.4.21.0103081556460.12913-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 8 Mar 2001, God wrote:

> > *users* have no business changing the system configuration. End of story.
> > Again, if somebody doesn't read manpages before doing stuff under root -
> > no point trying to protect him. He will find a way to fsck up, no matter
> > how many "safety" checks you put in.
> 
> Just curious, but do you administer any kind of network with users?  Are

Fortunately, not anymore.

> they all perfect?  Never changing a setting?  Never screwing anything

Thanks $DEITY, never really had to deal with DOS/MacOS/Windows. So that
was not that much of a problem system-wide. Power-lusers screwing their
.profile, .forward, yodda, yodda? You bet.

> up?  ... If so , then it must get boring sitting in your office all day.

Not really ;-/

> According to you, I, nor any of the other millions of computer users/game
> players out there, should ever do anything more then install a game and
> run it.  Oh wait .. ya know what? .. that involves changing system
> settings too ..... darn .. ya know .. I guess I just shouldn't use a
> computer at all.... -end of story

Not exactly. It's not a matter of should or shouldn't. It's much simpler -
if you do something you'd better get some idea of potential scale of
screwups you can cause doing that. Anyone who uses sharp tools and doesn't
watch his steps is going to get hurt, be it buzz-saw or root. When you
are logged in as root you can cause _any_ damage to system. If you do
that - blame yourself. It sucks to spend a weekend with backups because
of a typo, but if you screw yourself because you didn't RTFM... <shrug>
You don't take random pills without checking the side effects, do you?
Same principle...

> > BTW, that's the first time I've seen
> > "elite" used as a term for "able to understand the meaning of words 'use
> > with extreme caution'". Oh, well...
> 
> What? .... that is very, VERY, low and stupid.

Would you mind rereading the posting I replied to? Previous poster apparently
implied that ability to read the manpage is a sign of being a member
of some elite. No arguments - it's _very_ stupid. Your point being?

