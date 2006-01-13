Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964958AbWAMVM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbWAMVM0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 16:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbWAMVM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 16:12:26 -0500
Received: from xenotime.net ([66.160.160.81]:25312 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964958AbWAMVM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 16:12:26 -0500
Date: Fri, 13 Jan 2006 13:12:24 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Adrian Bunk <bunk@stusta.de>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Paul Jackson <pj@sgi.com>,
       akpm@osdl.org, adobriyan@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm2: alpha broken
In-Reply-To: <20060113210848.GS29663@stusta.de>
Message-ID: <Pine.LNX.4.58.0601131310060.5563@shark.he.net>
References: <20060107052221.61d0b600.akpm@osdl.org> <20060107210646.GA26124@mipter.zuzino.mipt.ru>
 <20060107154842.5832af75.akpm@osdl.org> <20060110182422.d26c5d8b.pj@sgi.com>
 <20060113141154.GL29663@stusta.de> <20060113101054.d62acb0d.pj@sgi.com>
 <Pine.LNX.4.58.0601131014160.5563@shark.he.net> <20060113210848.GS29663@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jan 2006, Adrian Bunk wrote:

> On Fri, Jan 13, 2006 at 10:19:30AM -0800, Randy.Dunlap wrote:
> > On Fri, 13 Jan 2006, Paul Jackson wrote:
> >
> > > Adrian wrote:
> > > > This is the amout of testing I can afford.
> > >
> > > It sounds to me like you are saying that a minute of your time is
> > > more valuable than a minute of each of several other peoples time.
> > >
> > > The only two people I gladly accept that argument from are Linus
> > > and Andrew.
> > >
> > > For the rest of us, it is important to minimize the total workload
> > > of all us combined, not to optimize our individual output.
> > >
> > > What you don't test, several others of us get to test.  Only its often
> > > more work, for -each- of us, as we each have to figure out which of
> > > 1000 patches caused the breakage.
> >
> > I don't find building cross-toolchains quite as easy as Al does,
> > so I download and build with these (on i386):
> >   http://developer.osdl.org/dev/plm/cross_compile/
> > as Andrew has also mentioned in the past.
> >
> > Or one can submit kernel patches for builds to an OSDL
> > build machine which does 8 or 9 $ARCH builds.
>
> This leaves 15 or 16 other architectures for my puny 1,8 GHz CPU.
>
> And does OSDL fix other people's compile breakages in the latest -mm
> before I submit my patches, or am I required to play QA for every
> single architecture before I can submit one single patch touching
> architecture-independend files?

-ETOOMUCHSARCASM
(from someone who also uses sarcasm often)

But seriously, I don't think anyone suggested anything quite
as extreme as your question implies.

-- 
~Randy
