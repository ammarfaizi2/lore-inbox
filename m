Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136040AbRD0OQM>; Fri, 27 Apr 2001 10:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136037AbRD0OQB>; Fri, 27 Apr 2001 10:16:01 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:15108 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S136040AbRD0OPn>;
	Fri, 27 Apr 2001 10:15:43 -0400
Message-ID: <20010426213545.A803@bug.ucw.cz>
Date: Thu, 26 Apr 2001 21:35:45 +0200
From: Pavel Machek <pavel@suse.cz>
To: imel96@trustix.co.id, Daniel Stone <daniel@kabuki.openfridge.net>,
        Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Single user linux
In-Reply-To: <20010424225841.D5803@piro.kabuki.openfridge.net> <Pine.LNX.4.33.0104242018410.16215-100000@tessy.trustix.co.id> <20010424233801.A6067@piro.kabuki.openfridge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010424233801.A6067@piro.kabuki.openfridge.net>; from Daniel Stone on Tue, Apr 24, 2001 at 11:38:01PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Since when, did mobile phones == computers?
> > 
> > read the news! i'm programming nokia 9210 with c++, is that
> > computer enough?
> 
> Aah. I see. Where was this? I never saw it.

9210 has qwerty keyboard.

> > i bet if you programmed one, you'd wish you have posix
> > interface.
> 
> That may be so, so hack up your own OS. It's a MOBILE PHONE, it needs to be
> absolutely *rock solid*. Look at the 5110, that's just about perfect. The
> 7110, on the other hand ...

And point is?

> > > > that also explain why win95 user doesn't want to use NT. not
> > > > because they can't afford it (belive me, here NT costs only
> > > > us$2), but additional headache isn't acceptable.
> > >
> > > So, let them stay in Win95. They don't *need* NT.
> > 
> > and how's stability, speed, etc. they read. is there a linux
> > advocate around here?
> 
> There are Linux advocates, but I'd say most of us are sane enough to use the
> right-tool-for-the-job approach. And UNIX on a phone is pure
> overkill.

Is it? Let's see.

You want your mobile phone to read mail. That's SMTP. Oh, and SMTP
needs to run over something. That's TCP/IP over PPP or SLIP. Oh and
you want web access. Add HTTP to the list.

[above is reasonable even for "normal" mobile phone; those below
require keyboard]

You'd like to ssh from your mobile phone. Add ssh. You'd like to ssh
*to* your mobile phone, because it keyboard sucks. That sshd. You'd
like to be able to let others to play games on your mobile phone, oh
that means multiuser mode.

You see? Linux has much stuff you'll need.

> > okay, it wouldn't cost me. but it surely easier if everybody used
> > linux, so i could put my ext2 disk everywhere i want.
> >
> > hey, it's obvious that it's not for a server!
> > i try to point out a problem for people not on this list, don't
> > work around that problem.
> 
> Your sister won't notice much advantage. Linux on a workstation actually has
> *disadvantages* (unfamiliar interface, unintuitive same, etc), as opposed to
> 'Doze on a workstation. Sure it's more stable, and the tiniest bit faster,
> but what's that really matter to your sister, if she can't even figure out
> how to use it?

My brother is 10 and he uses suse7.2 installation just fine. He likes
it more than windoze 2000 (I deleted) because there are more games in
kde than in windows. [I'd prefer gnome.]

> -d, who owns a 7110 and can lock it solid, or get it to do funny resetting
> tricks, at least once every 2 days

Hmm, maybe your 7110 needs memory protection so that runaway calendar
can not hurt basic functions? ;-).
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
