Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285269AbRL2TUj>; Sat, 29 Dec 2001 14:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285329AbRL2TUc>; Sat, 29 Dec 2001 14:20:32 -0500
Received: from svr3.applink.net ([206.50.88.3]:38663 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S285288AbRL2TUY>;
	Sat, 29 Dec 2001 14:20:24 -0500
Message-Id: <200112291920.fBTJKESr009175@svr3.applink.net>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: Larry McVoy <lm@bitmover.com>
Subject: Re: RFC: Linux Bug Tracking & Feature Tracking DB
Date: Sat, 29 Dec 2001 13:16:25 -0600
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200112290657.fBT6vMSr008000@svr3.applink.net> <20011229105525.C19306@work.bitmover.com>
In-Reply-To: <20011229105525.C19306@work.bitmover.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 December 2001 12:55, Larry McVoy wrote:
> On Sat, Dec 29, 2001 at 12:53:39AM -0600, Timothy Covell wrote:
> > 1. The maintainer of this DB would need to receive patches
> > along with patch.lsm and feature.lsm like files from the code
> > maintainers.   That means  that Linus, Alan, Marcello, Dave
> > Jones, et al.,  might have to be involved.
> >
> > 2. DB would be a high volume site (at least that's the idea!)
> >
> > 3. Would would pay for and maintain it?  (I know, since I'm
> > the one putting forth the idea, it's mine to run with.  However,
> > a. I ain't rich.  b. following from a., I have no bandwidth 24kbps
> > dialup.)
>
> OK, we've got a prototype of something like this already, I don't claim
> it is ready for prime time, but you can go look at it here:
>
> 	http://bugs.bkbits.net/bugs.html
>
> You can run queries, etc.
>
> This is a fairly early version, so be gentle.  The data in it is the
> current BitKeeper bug list (feel free to fix some :-)
>
> There are other ways to access the data, both command line and email
> are supported.  Long term, I'd like to make the bug db be an NNTP server
> so you could do everything via a news reader, which would be bitchin'.
>
> If this is a first order approximation of what you want, we'll host
> it here if you like.  We have a T1 line with lots of spare bandwidth
> at the moment.  The machine that you are poking at is the same machine
> which hosts various BK repos, such as the Linux/PPC trees, Ted's linux24
> tree, Ted's e2fsprogs, NTP trees, GregKH's trees, Chris Wright's trees
> (he has a 25 tree based on Ted's 24 tree), Rik's VM tree, among others.
> We haven't talked about this very much because we don't have all the
> nifty sourceforge like indices and statistics, but long term this is
> headed towards something somewhat like a distributed sourceforge.
> We never liked the centralized model that sourceforge has, it becomes
> a single point of failure.
>
> One interesting, perhaps, point is that bugdb is a BitKeeper repository,
> which means you can clone it and take *all* of the data with you,
> unlike sourceforge.  So if you were to become dependent on this and
> we ran out of bandwidth or something, you can clone the bug db and set
> up your own bug server elsewhere.  In general, for both databases and
> source, that's the approach we want, i.e., we're happy to host it here
> to get you started but if you have needs that we can't meet, we'll make
> it easy for you to host elsewhere.

Thank you.  That's a kind offer.  I'm taking a look at it right now.  So
your solution might solve the bandwidth issue, but the bigger issue
is what the big guys think, at least as far as I imagined the system.

timothy.covell@ashavan.org.
