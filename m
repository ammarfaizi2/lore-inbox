Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278462AbRJOWYM>; Mon, 15 Oct 2001 18:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278458AbRJOWYD>; Mon, 15 Oct 2001 18:24:03 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:59403 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S278457AbRJOWX4>; Mon, 15 Oct 2001 18:23:56 -0400
Date: Mon, 15 Oct 2001 18:19:16 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Tim Moore <timothymoore@bigfoot.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Breaking system configuration in stable kernels
In-Reply-To: <3BC35A71.9F783868@bigfoot.com>
Message-ID: <Pine.LNX.3.96.1011015180116.21451B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2001, Tim Moore wrote:

> Bill Davidsen wrote:
> > 
> >   I've beaten this dead horse before, but Linux will not look to
> > management like a viable candidate for default o/s until whoever releases
> > new versions of *stable* kernel series with cosmetic changes which break
> > existing systems running earlier releases of the same stable kernel
> > series.
 
> I wouldn't use a new release of Windows or OSF/1 or Digital Unix or
> Solaris in a commercial situation and linux is no different.  In this
> case [cmpci] it sounds like some user's desktop which is also asking for
> problems.  Having it visible to management is just too much risk
> regardless of the os. 

The bad performance of the VM in earlier kernels is really visible to
management, which is why going to something more capable is desirable (and
works well). The issue was that Linux has always taken too long to get the
development kernel series out, which encourages development work in the
"stable" kernel. Currently the -ac kernels tend to avoid flights of fancy
and "jackpot" bad VM bahaviour. Making a parameter name change just seems
a very odd thing.
 
> Stick with distribution OR 2.2.x (2.2.19pre2 or higher) kernels.

People who are sticking with obsolete kernels aren't on this list in
general, I don't upgrade until there's a reason, but much better
performance visible to the user is definitely a reason.

I would love to see Alan do the stable releases and Linus do the
development, and a development branch at the time of the first release
candidates for a new stable branch.

If Linux is going to continue to gain credibility as an everyday, every
application o/s, which I think everyone on the list believes is desirable,
then a little effort to behave a bit more like traditional development is
a good thing. World domination take some "low animal cunning*" as well as
a better technical product.

*E. B. Griswald, MIT 1961

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

