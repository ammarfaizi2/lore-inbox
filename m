Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313122AbSERReG>; Sat, 18 May 2002 13:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313254AbSERReF>; Sat, 18 May 2002 13:34:05 -0400
Received: from smtpnotes.altec.com ([209.149.164.10]:10003 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S313122AbSERReE>; Sat, 18 May 2002 13:34:04 -0400
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: linux-kernel@vger.kernel.org
Message-ID: <86256BBD.00606F38.00@smtpnotes.altec.com>
Date: Sat, 18 May 2002 12:32:25 -0500
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 3
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Why?  Because I didn't mention who said it?  OK, it was Giacomo Catenazzi.  You
can read the original article yourself at
http://marc.theaimsgroup.com/?l=linux-kernel&m=100748835520343&w=2 if you wish.
In case you don't here's the relevant part.  I had asked what the differences
were between the old and new versions, and Giacomo replied with this:


>The new kbuild-2.5 (also the new Makefile)
>will no more work with your command:
>make dep: is no more needed
>make bzlilo modules modules_install: it would be a simble
>make install: (and you configure with CML1/CML2 what install
>means).


Satisfied now?  Or did you mean I should have installed kbuild2.5 and found out
for myself?  If I had any interest in using it that would be reasonable.  But
all I wanted was to find out how bad things are going to be after I eventually
get stuck with it.  So I asked for information from someone who already knew
about it.  Do you ever take anyone else's word for anything, or do you always
have to try everything out for yourself?

This is my last post on this subject.  There doesn't seem to be anyone here who
understands the concept of being satisfied with a tool and seeing no need to
improve it.  If I'm not satisfied with something, I'll expend large amounts of
time, effort and money to achieve even trivial improvements.  But if I *am*
satisfied with something, then I don't want to spend even a trivial amount of
effort trying to achieve "improvements" that I don't need.

I never expected everyone to abandon their own needs to satisfy mine.  It would
be nice if they tried to accomodate my needs while satisfying their own, but I
didn't expect that either.  What I expect is that kbuild 2.5 (and eventually
CML2) will show up in the kernel sooner or later, and I'll just have to live
with it.  All my original message on this subject was intended to do was to
point out that not everyone was happy with the situation.  The rest of you have
reacted as if you're afraid Linus might listen to me and do it my way.  Well,
relax, I doubt he cares any more about what I want than the rest of you do.  At
least he didn't feel the need to jump down my throat about it.

I don't need the new kbuild.  I don't want the new kbuild.  But I'm going to be
stuck with it, and there's nothing I can do to stop it.  So for those of you who
DO want it, why is it such a burden to hear that not everyone thinks the way you
do?






"Mike Galbraith" <EFAULT@gmx.de> on 05/18/2002 05:25:11 AM

To:
cc:    (bcc: Wayne Brown/Corporate/Altec)

Subject:  Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 3



>Someone said here on the list a few months ago that "make bzlilo" was replaced
>by "make install" and that it was necessary to configure the "install" option's
>behavior.

Someone said?  Your opinion on this subject just lost all of it's value.

     -Mike






