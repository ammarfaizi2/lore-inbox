Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275224AbRIZOM7>; Wed, 26 Sep 2001 10:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275225AbRIZOMt>; Wed, 26 Sep 2001 10:12:49 -0400
Received: from rover.bsdimp.com ([204.144.255.66]:45837 "EHLO
	rover.village.org") by vger.kernel.org with ESMTP
	id <S275224AbRIZOMf>; Wed, 26 Sep 2001 10:12:35 -0400
Message-Id: <200109261412.f8QECs767151@harmony.village.org>
To: linux-kernel@vger.kernel.org
Subject: Re: BSD-Linux FlameWar over SoftRAID
Date: Wed, 26 Sep 2001 08:12:54 -0600
From: Warner Losh <imp@harmony.village.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[[ This message is sent as a private person and is not an official
   statement from FreeBSD's core team. ]]

: It is clear that BSD is going off the deep end.

Actually, I'm on the FreeBSD core team.  BSD is not going off the deep
end.  People in slashdot are going off the deep end.  The reporter
that reported it didn't bother to do his homework.  The reporter erred
in not checking with those in the Linux development efforts to find if
the issue had been resolved.  The fact that it had been resolved at
least 12 hours before the story hit slashdot (I saw pointers to
patches which corrected the problems posted to an IRC channel the
night before I saw it on slashdot).

The fact of the matter is that the code was copied from FreeBSD
verbatium, or with minor alterations.  That's not a problem at all,
since our license allows for that.  The problem came in that Soren's
name was removed from the headers which he'd put a lot of time into.
The problem was corrected, no big deal except for the weirdos on
slashdot.

FreeBSD's core team has never issued any statements on this issue, nor
have we made any demands.  Frankly, I think that this is way overblown
as well.  People should remember that slashdot isn't reality and that
it should be taken with a grain of salt.

Healthy code and concept sharing between Linux and FreeBSD (and
between any opensource groups) is in everyone's best interest to
continue the cooperative competition that we've had in the past.

I won't address the supposed borrowing from Linux -> FreeBSD in the
IDE driver in the head of this thread, since I've not done any
research on that topic.  I do know Soren has access to all the IDE/ATA
specs and is bright enough to dig what's necessary out of them.  Let's
be careful of tossing accusations of theft in a public forum when it
is possible that he figured it out himself.  Prior availability in
Linux doesn't mean that later groups necessarily took anything from
Linux to make their code work.  Let's not loose sight of the fact that
there's plenty of bright people with good will who do good work in
both groups.

So take a deep breath and realize that this isn't the end of the
world.

Warner Losh

[[ who released ObjectBuilder for Linux as the first (or one of the
   first) "demoware" product for Linux back in 1992 or 1993 and did
   some Linux/Mips work.  He now happens to be the FreeBSD pccard
   maintainer and in FreeBSD's governing body named core.  ]]
