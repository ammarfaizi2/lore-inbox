Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264333AbTLKBjX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 20:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264303AbTLKBjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 20:39:12 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:32653 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S264347AbTLKBh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 20:37:59 -0500
Date: Wed, 10 Dec 2003 20:24:58 -0500
To: linux-kernel@vger.kernel.org
Cc: Larry McVoy <lm@work.bitmover.com>, Linus Torvalds <torvalds@osdl.org>,
       Larry McVoy <lm@bitmover.com>, Andre Hedrick <andre@linux-ide.org>,
       Arjan van de Ven <arjanv@redhat.com>, Valdis.Kletnieks@vt.edu,
       Kendall Bennett <KendallB@scitechsoft.com>
Subject: Re: Linux GPL and binary module exception clause?
Message-ID: <20031211012458.GA27531@pimlott.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@osdl.org>, Larry McVoy <lm@bitmover.com>,
	Andre Hedrick <andre@linux-ide.org>,
	Arjan van de Ven <arjanv@redhat.com>, Valdis.Kletnieks@vt.edu,
	Kendall Bennett <KendallB@scitechsoft.com>
References: <Pine.LNX.4.10.10312100550500.3805-100000@master.linux-ide.org> <Pine.LNX.4.58.0312100714390.29676@home.osdl.org> <20031210153254.GC6896@work.bitmover.com> <Pine.LNX.4.58.0312100809150.29676@home.osdl.org> <20031210163425.GF6896@work.bitmover.com> <Pine.LNX.4.58.0312100852210.29676@home.osdl.org> <20031210175614.GH6896@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031210175614.GH6896@work.bitmover.com>
User-Agent: Mutt/1.3.28i
From: Andrew Pimlott <andrew@pimlott.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 09:56:14AM -0800, Larry McVoy wrote:
> On Wed, Dec 10, 2003 at 09:10:18AM -0800, Linus Torvalds wrote:
> > In short, your honour, this extra chapter without any meaning on its own
> > is a derived work of the book.
> 
> I see.  And your argument, had it prevailed 5 years ago, would have
> invalidated the following, would it not?  The following from one of the
> Microsoft lawsuits.
> 
> >From http://ecfp.cadc.uscourts.gov/MS-Docs/1636/0.pdf
> 
>     Substituting an alternative module for one supplied by Microsoft
>     may not violate copyright law, and certainly not because of any
>     "integrity of the work" argument. The United States recognizes "moral
>     rights" of attribution and integrity only for works of visual art
>     in limited editions of 200 or fewer copies. (See 17 U.S.C. 106A
>     and the definition of "work of visual art" in 17 U.S.C. 101.) A
>     bookstore can replace the last chapter of a mystery novel without
>     infringing its copyright, as long as they are not reprinting the
>     other chapters but are simply removing the last chapter and replacing
>     it with an alternative one, but must not pass the book off as the
>     original. Having a copyright in a work does not give that copyright
>     owner unlimited freedom in the terms he can impose.

You probably should have mentioned that this statement was made not
by a judge or a lawyer, but by a CS professor in an amicus curiae
brief.  And the implication that this argument had much to do with
the outcome of the Microsoft case--which was about antitrust and
bundling, not copyrights--is disingenuous.

> Start to see why I think what you are doing is dangerous and will backfire?

You are extrapolating way too far.  There are so many differences
between the Linux-module issue and the vague doomsday scenario you
are trying to conjure.  Linus explained one (coherence and stability
of the API/ABI), and I think it could be easily be cast as a test
that a court could apply.

Maybe you can describe a specific case in which Linus's argument
backfires?  I'm not saying you have no point at all, just that I
don't think this one thing is holding back the flood-waters.

Andrew
