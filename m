Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263375AbUERNrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbUERNrH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 09:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbUERNrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 09:47:07 -0400
Received: from svr44.ehostpros.com ([66.98.192.92]:59096 "EHLO
	svr44.ehostpros.com") by vger.kernel.org with ESMTP id S263380AbUERNrD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 09:47:03 -0400
From: "Amit S. Kale" <amitkale@linsyssoft.com>
Organization: LinSysSoft Technologies Pvt Ltd
To: Tom Rini <trini@kernel.crashing.org>, Robert Picco <Robert.Picco@hp.com>
Subject: Re: [Kgdb-bugreport] Re: 2.6.6-mm3
Date: Tue, 18 May 2004 19:15:34 +0530
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       kgdb-bugreport@lists.sourceforge.net
References: <20040516025514.3fe93f0c.akpm@osdl.org> <20040517163813.GH6763@smtp.west.cox.net> <20040517175642.GL6763@smtp.west.cox.net>
In-Reply-To: <20040517175642.GL6763@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405181915.34077.amitkale@linsyssoft.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - svr44.ehostpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linsyssoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 May 2004 11:26 pm, Tom Rini wrote:
> On Mon, May 17, 2004 at 09:38:13AM -0700, Tom Rini wrote:
> > On Mon, May 17, 2004 at 12:30:25PM -0400, Robert Picco wrote:
> > > Tom Rini wrote:
> > > >On Sun, May 16, 2004 at 02:55:14AM -0700, Andrew Morton wrote:
> > > >>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6/2
> > > >>.6.6-mm3/
> > > >>
> > > >>- A few VM changes, getting things synced up better with Andrea's
> > > >> work.
> > > >>
> > > >>- A new kgdb stub, for ia64 (what happened to the grand unified kgdb
> > > >> project?)
> > > >
> > > >No one asked the ia64 folks who did that work "Hey, have you looked at
> > > >the grand unified kgdb project on kgdb.sf.net ?" would be my guess.
> > > >
> > > >Having said that, if you're willing to go with a slightly late
> > > >initalizing (I saw part of the early_param work get dropped again I
> > > >think, so I'm gonna guess you don't wanna deal with that again yet)
> > > > KGDB for i386 and PPC32, I can whip something up vs 2.6.6 in a day or
> > > > so.
> > >
> > > I did the ia64 port and started with Andrew's 2.6.4-mm2 i386 sources.
> > > I'm assuming the long term strategy is to move to a unified kgdb being
> > > done on sourceforge?  If so, I'll take a look at this.
> >
> > My long term strategy is to get everyone using the version on
> > sourceforge that splits out the common portions of the stub from the
> > arch-specific portions.  If you could go ahead and get ia64 working on
> > this as well I'd appreciate it.
> >
> > Right now it's still vs 2.6.5, but I'm going to try and fix that today
> > or tomorrow to be vs 2.6.6.
>
> OK, I've updated things to 2.6.6.

That's great! Thanks.
-Amit

