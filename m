Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261783AbREaGTk>; Thu, 31 May 2001 02:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262873AbREaGTa>; Thu, 31 May 2001 02:19:30 -0400
Received: from www.wen-online.de ([212.223.88.39]:56331 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S261783AbREaGTP>;
	Thu, 31 May 2001 02:19:15 -0400
Date: Thu, 31 May 2001 08:18:36 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Vincent Stemen <linuxkernel@AdvancedResearch.org>
cc: <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Plain 2.4.5 VM... (and 2.4.5-ac3)
In-Reply-To: <01053022472901.02370@quark>
Message-ID: <Pine.LNX.4.33.0105310726110.516-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2001, Vincent Stemen wrote:

> On Wednesday 30 May 2001 15:17, Mike Galbraith wrote:
> > On Wed, 30 May 2001, Vincent Stemen wrote:
> > > On Wednesday 30 May 2001 01:02, Mike Galbraith wrote:
> > > > On Tue, 29 May 2001, Vincent Stemen wrote:
> > > > > On Tuesday 29 May 2001 15:16, Alan Cox wrote:
> > > > > > > a reasonably stable release until 2.2.12.  I do not understand
> > > > > > > why code with such serious reproducible problems is being
> > > > > > > introduced into the even numbered kernels.  What happened to
> > > > > > > the plan to use only the
> > > > > >
> > > > > > Who said it was introduced ?? It was more 'lurking' than
> > > > > > introduced. And unfortunately nobody really pinned it down in
> > > > > > 2.4test.
> > > > >
> > > > > I fail to see the distinction.  First of all, why was it ever
> > > > > released as 2.4-test?  That question should probably be directed at
> > > > > Linus.  If it is not fully tested, then it should be released it as
> > > > > an odd number.  If it already existed in the odd numbered
> > > > > development kernel and was known, then it should have never been
> > > > > released as a production kernel until it was resolved.  Otherwise,
> > > > > it completely defeats the purpose of having the even/odd numbering
> > > > > system.
> > > > >
> > > > > I do not expect bugs to never slip through to production kernels,
> > > > > but known bugs that are not trivial should not, and serious bugs
> > > > > like these VM problems especially should not.
> > > >
> > > > And you can help prevent them from slipping through by signing up as
> > > > a shake and bake tester.  Indeed, you can make your expectations
> > > > reality absolutely free of charge, <microfont> and or compensation
> > > > </microfont> what a bargain!
> > > >
> > > > X ___________________ ;-)
> > > >
> > > > 	-Mike
> > >
> > > The problem is, that's not true.  These problems are not slipping
> > > through because of lack of testers.  As Alan said, the VM problem has
> >
> > Sorry, that's a copout.  You (we) had many chances to notice.  Don't
> > push the problems back onto developers.. it's our problem.
> >
>
> How is that a copout?  The problem was noticed.  I am only suggesting
> that we not be in such a hurry to put code in the production kernels
> until we are pretty sure it works well enough, and that we release
> major production versions more often so that they do not contain 2 or
> 3 years worth of new code making it so hard to debug.  We probably
> should have had 2 or 3 code freezes and production releases since
> 2.2.x.  As I mentioned in a previous posting, this way we do not have
> to run a 2 or 3 year old kernel in order to have reasonable stability.

I don't think you or I can do a better job of release management than
Linus and friends, so there's no point in us discussing it.  If you
want to tell Linus, Alan et al how to do it 'right', you go do that.

	-Mike

