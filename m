Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136044AbRD0O14>; Fri, 27 Apr 2001 10:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136045AbRD0O1r>; Fri, 27 Apr 2001 10:27:47 -0400
Received: from [203.36.158.121] ([203.36.158.121]:50826 "EHLO
	piro.kabuki.openfridge.net") by vger.kernel.org with ESMTP
	id <S136044AbRD0O1o>; Fri, 27 Apr 2001 10:27:44 -0400
Date: Sat, 28 Apr 2001 00:26:46 +1000
From: Daniel Stone <daniel@kabuki.openfridge.net>
To: Pavel Machek <pavel@suse.cz>
Cc: imel96@trustix.co.id, Alexander Viro <viro@math.psu.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Single user linux
Message-ID: <20010428002646.A30498@kabuki.openfridge.net>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>, imel96@trustix.co.id,
	Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <20010424225841.D5803@piro.kabuki.openfridge.net> <Pine.LNX.4.33.0104242018410.16215-100000@tessy.trustix.co.id> <20010424233801.A6067@piro.kabuki.openfridge.net> <20010426213545.A803@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010426213545.A803@bug.ucw.cz>; from pavel@suse.cz on Thu, Apr 26, 2001 at 09:35:45PM +0200
Organisation: Sadly lacking
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2001 at 09:35:45PM +0200, Pavel Machek wrote:
> Hi!

Hola.
 
> > > read the news! i'm programming nokia 9210 with c++, is that
> > > computer enough?
> > 
> > Aah. I see. Where was this? I never saw it.
> 
> 9210 has qwerty keyboard.

He said "read the news". I've seen the 9110 and 9210's, I was asking where
this news was.
 
> > > i bet if you programmed one, you'd wish you have posix
> > > interface.
> > 
> > That may be so, so hack up your own OS. It's a MOBILE PHONE, it needs to be
> > absolutely *rock solid*. Look at the 5110, that's just about perfect. The
> > 7110, on the other hand ...
> 
> And point is?

The point is that you need a known good, absolutely rock-solid OS to do it,
and IMHO, you really need a customised job, not something like Linux, which
is a monolith in comparison.

> > > and how's stability, speed, etc. they read. is there a linux
> > > advocate around here?
> > 
> > There are Linux advocates, but I'd say most of us are sane enough to use the
> > right-tool-for-the-job approach. And UNIX on a phone is pure
> > overkill.
> 
> Is it? Let's see.
> 
> You want your mobile phone to read mail. That's SMTP. Oh, and SMTP
> needs to run over something. That's TCP/IP over PPP or SLIP. Oh and
> you want web access. Add HTTP to the list.

In the mobile world, that is *all* WAP.
 
> [above is reasonable even for "normal" mobile phone; those below
> require keyboard]
> 
> You'd like to ssh from your mobile phone. Add ssh. You'd like to ssh
> *to* your mobile phone, because it keyboard sucks. That sshd. You'd
> like to be able to let others to play games on your mobile phone, oh
> that means multiuser mode.

I'd *like* to, sure, but this is impractical because the mobile links suck
so hard. Dunno about you, but it takes a few seconds to pull in a <1k page.
Ugh. SSH? Games, sure, I point my phone at a 7110 or 6210 and I can play
2-player Snake 2 :)

> You see? Linux has much stuff you'll need.

True, but you have to be wary of overkill, like I said.

> > Your sister won't notice much advantage. Linux on a workstation actually has
> > *disadvantages* (unfamiliar interface, unintuitive same, etc), as opposed to
> > 'Doze on a workstation. Sure it's more stable, and the tiniest bit faster,
> > but what's that really matter to your sister, if she can't even figure out
> > how to use it?
> 
> My brother is 10 and he uses suse7.2 installation just fine. He likes
> it more than windoze 2000 (I deleted) because there are more games in
> kde than in windows. [I'd prefer gnome.]

I've used RedHat since I was about 11, Debian since 13. It's not that hard,
if you can just get used to it. But you're playing with yourself if you
think that KDE has more games than Win2k ... Black & White? All the Star
Wars games? etc ... I know a lot of them are being ported to Linux, most via
Loki, but still ...

(I use GNOME, and the panel giving me Bus errors is starting to annoy me).
 
> > -d, who owns a 7110 and can lock it solid, or get it to do funny resetting
> > tricks, at least once every 2 days
> 
> Hmm, maybe your 7110 needs memory protection so that runaway calendar
> can not hurt basic functions? ;-).

Oh, I think it's just to do with changing state, seeing as most of the
lockups I get are when I hit keys really, really quickly in sequence, and
one lands just as the screen's blank, and it's changing state (snake 2 can
also kill it).

-- 
Daniel Stone
daniel@kabuki.openfridge.net
