Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262872AbSJEXrm>; Sat, 5 Oct 2002 19:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262879AbSJEXrm>; Sat, 5 Oct 2002 19:47:42 -0400
Received: from bitmover.com ([192.132.92.2]:62853 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S262872AbSJEXrl>;
	Sat, 5 Oct 2002 19:47:41 -0400
Date: Sat, 5 Oct 2002 16:53:16 -0700
From: Larry McVoy <lm@bitmover.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Larry McVoy <lm@bitmover.com>, Ulrich Drepper <drepper@redhat.com>,
       Ben Collins <bcollins@debian.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New BK License Problem?
Message-ID: <20021005165316.E12580@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
	Ulrich Drepper <drepper@redhat.com>,
	Ben Collins <bcollins@debian.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021004140802.E24148@work.bitmover.com> <20021005175437.GK585@phunnypharm.org> <20021005112552.A9032@work.bitmover.com> <20021005184153.GJ17492@marowsky-bree.de> <20021005190638.GN585@phunnypharm.org> <3D9F3C5C.1050708@redhat.com> <20021005124321.D11375@work.bitmover.com> <3D9F49D9.304@redhat.com> <20021005162852.I11375@work.bitmover.com> <1033861827.4441.31.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1033861827.4441.31.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Sun, Oct 06, 2002 at 12:50:27AM +0100
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2002 at 12:50:27AM +0100, Alan Cox wrote:
> On Sun, 2002-10-06 at 00:28, Larry McVoy wrote:
> > Because Linus is using BK it is easier for him to make his work in 
> > progress available, so he does.  Before he was using BK, you got a 
> > snapshot when he put up for ftp.  It is an absolute fact that Linus
> > tree is far more quickly available, via regular patches or BK, than
> > it was before he used BK.
> 
> Linus used to do about a patch every 2 days. Nowdays its a lot slower. I
> put that down to buttkeeper

He may put up a patch for ftp less frequently, I haven't watched that.
He is publishing an average of 39 changesets/day, 7 days a week,
365 days/year based on the number of changesets in the tree as of a
minute ago.  Some percentage of those are merge changesets which you
would probably not count, I checked and it looks like about 15%, round
it up to 20%, that's still 31/day.  If you assume he's working 5 days
a week, it's more like 44/day.  That's a patch accepted every 11 minutes.
Let's say I've screwed up my math somewhere, I'll give you a factor of 3,
that's still a couple of patches an hour.  40 hours a week.

Anyway, we have the BK data, if you have data that says the rate of change
has gone down since he started using BK, let's see it.  If all you are 
saying is that he isn't publishing ftp-able snapshots every hour, that's
a problem that HPA or whoever could easily fix with a shell script.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
