Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261814AbTCQRyC>; Mon, 17 Mar 2003 12:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261815AbTCQRyC>; Mon, 17 Mar 2003 12:54:02 -0500
Received: from pasky.ji.cz ([62.44.12.54]:41204 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S261814AbTCQRx7>;
	Mon, 17 Mar 2003 12:53:59 -0500
Date: Mon, 17 Mar 2003 19:04:47 +0100
From: Petr Baudis <pasky@ucw.cz>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Roman Zippel <zippel@linux-m68k.org>, Nicolas Pitre <nico@cam.org>,
       Andrea Arcangeli <andrea@suse.de>, Ben Collins <bcollins@debian.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030317180447.GQ11761@pasky.ji.cz>
Mail-Followup-To: Horst von Brand <vonbrand@inf.utfsm.cl>,
	Roman Zippel <zippel@linux-m68k.org>, Nicolas Pitre <nico@cam.org>,
	Andrea Arcangeli <andrea@suse.de>,
	Ben Collins <bcollins@debian.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0303162014090.12110-100000@serv> <200303171741.h2HHfYqq006184@pincoya.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303171741.h2HHfYqq006184@pincoya.inf.utfsm.cl>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Mon, Mar 17, 2003 at 06:41:33PM CET, I got a letter,
where Horst von Brand <vonbrand@inf.utfsm.cl> told me, that...
> Roman Zippel <zippel@linux-m68k.org> said:
> 
> [...]
> 
> > If you want to test an alternative system to see whether it's usable for 
> > kernel development, what better data is there? How could you compare it 
> > against bk?

It is perfectly reasonable for Larry not to support such a thing (unless he is
so beated down by lkml people already that he seeks a way to escape, though
still with grace yet ;).

Still the potential competing version control would have *MUCH* larger test
base than without BitKeeper at all --- it is IMHO fine to politely ask for
more, but if Larry doesn't want to do it, why to beat it from him so
agressively?  It's an added value which is here *thanks* to BitKeeper (and
noone was able to pose any what BitKeeper *removed*, so the value has to be
positive, mathematically speaking ;) so I think it is in competency of
KitBeeper maintainers to regulate the size of such a value --- BitKeeper will
probably be used as long as the value will stay high at least short-term (for
runtime maintainement of various trees) and even if the value will approach
zero by time (ie. only partial records in CVS, and it looks they are almost
complete), as long as it's not negative I can't see why people whine about it
so much.

> Either it is a bk clone of some sort (which adds little value, and probably
> won't get the head hackers to switch)
..snip..

If it will approach the feature set AND usability of bk (or at least the subset
which matters for kernel development), the information are somehow translatable
from the bk's format AND it has acceptable licence, I can see big potential
audience for it, at least to keep private trees (and merge together busily
behind the Linus' back ;). Also the licence can be a big plus given the current
state of things, even for Linus (he even stated so before some time, IIRC).

Kind regards,

-- 
 
				Petr "Pasky busy playing with own
					supposedly-BK-alike SCM" Baudis
.
The pure and simple truth is rarely pure and never simple.
		-- Oscar Wilde
.
Stuff: http://pasky.ji.cz/
