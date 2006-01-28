Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWA1XPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWA1XPy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 18:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWA1XPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 18:15:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9883 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750790AbWA1XPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 18:15:53 -0500
Date: Sat, 28 Jan 2006 18:14:29 -0500 (EST)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chase Venters <chase.venters@clientec.com>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Marc Perkel <marc@perkel.com>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Patrick McLean <pmclean@cs.ubishops.ca>,
       Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
In-Reply-To: <20060128062504.GW27946@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0601281805300.3812@evo.osdl.org>
References: <43D7B20D.7040203@wolfmountaingroup.com> <43D7B5C4.5040601@wolfmountaingroup.com>
 <43D7D05D.7030101@perkel.com> <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com>
 <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com>
 <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse>
 <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org> <1138387136.26811.8.camel@localhost>
 <Pine.LNX.4.64.0601272101510.3192@evo.osdl.org> <Pine.LNX.4.64.0601280001000.2909@evo.osdl.org>
 <20060128062504.GW27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 28 Jan 2006, Al Viro wrote:
> > 
> > 	- You may not distibute this for a fee, not even "handling"
> > 	  costs.
> > 
> >   Mail me at "torvalds@kruuna.helsinki.fi" if you have any questions."
> > 
> > and that one was only valid between kernel versions 0.01 and 0.12 or 
> > something like that.
> 
> Interesting...  What does that do to e.g. DVD with full (OK, modulo missing
> early versions) kernel history all way back to 0.01?

Well, the good news is that I was the only real copyright holder back then 
(there's a couple of other people who contributed to 0.11 and/or 0.12, 
mainly Ted T'so with the BSD terminal control stuff - ^Z and friends).

I used to even re-write patches to suit my style (this was back then, the 
patches were smaller, and I was younger and had more energy). So some 
things that others sent in patches for (I think Peter McDonald did pty's) 
I ended up re-writing myself (and in the process I mixed up the master and 
slave pty major number, iirc ;)

> Even funnier question is what does that do to full CVS including the
> early versions.  Can that be distributed at all and what license would
> fit it?  Arguing that it's mere aggregation is possible, but it's a
> bit of a stretch...

I think you can take it for granted that the GPL re-licensing was 
retro-active. I'm the sole copyright holder for 99% of it, and there were 
no objections to the relicensing even back when it happened, so I can 
pretty much guarantee that there would be none now ;)

It was a kind of strange license. I didn't spend a whole lot of time 
thinking about it ;)

		Linus
