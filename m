Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265683AbSKODgh>; Thu, 14 Nov 2002 22:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265689AbSKODgh>; Thu, 14 Nov 2002 22:36:37 -0500
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:35714 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S265683AbSKODgf>;
	Thu, 14 Nov 2002 22:36:35 -0500
Date: Thu, 14 Nov 2002 21:43:07 -0600 (CST)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Andrew Morton <akpm@digeo.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Bugzilla bug tracking database for 2.5 now available.
In-Reply-To: <3DD4614B.A57EE8C5@digeo.com>
Message-ID: <Pine.LNX.4.44.0211142132500.2229-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2002, Andrew Morton wrote:

> "Martin J. Bligh" wrote:
> > 
> > > While I have this on my mind I want to express this now since the
> > > very first bug that hit my mailbox had this issue.
> > >
> > > I want to suggest that all reported bug in the database must be
> > > reporducable with some release done by Linus or his BK sources.
> > > And also that we can automatically close any BUG submissions that
> > > have other patches applied.
> > 
> > Hmmm ... I'm not sure that being that restrictive is going to help.
> > Whilst bugs against any randomly patched version of the kernel
> > probably aren't that interesting, things in major trees like -mm,
> > -ac, -dj etc are likely going to end up in mainline sooner or later
> > anyway ... wouldn't you rather know of the breakage sooner rather
> > than later?
> 
> So people will need to use their judgement as to whether the
> problem is in 2.5.47, or in the -bk snapshot which was taken from
> Linus, or in the -mm addons.
> 
> If in doubt, people should go for the mailing list first.   Because
> 
> a) the response time will be better
> b) more people will see it
> c) the owners of the add-on patches can screen it quickly.

Has my 2.5 Problem Report Status postings been useful?  If so, when I 
discussed this with Martin one of the roles we agreed I would play was 
taking bug reports from the list and adding them to bugzilla.  I'll also 
be a "filter" for some of the issues discussed in this thread, sort of a 
janitor if you will.  

My question is how should compile failures figure into the bug database?  
Most of the compile failures are typos or thinkos that get quickly fixed.  
Should they get tracked, or dismissed quickly unless they linger on.  I 
didn't track simple compile failures in my list.

