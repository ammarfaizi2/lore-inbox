Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264801AbTIDHwa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 03:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264795AbTIDHw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 03:52:29 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:36747 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264801AbTIDHw2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 03:52:28 -0400
X-AuthUser: davidel@xmailserver.org
Date: Thu, 4 Sep 2003 00:43:56 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Larry McVoy <lm@bitmover.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scaling noise
In-Reply-To: <20030904041600.GA16959@work.bitmover.com>
Message-ID: <Pine.LNX.4.56.0309032245590.916@bigblue.dev.mdolabs.com>
References: <BF1FE1855350A0479097B3A0D2A80EE009FCEF@hdsmsx402.hd.intel.com>
 <20030903173213.GC5769@work.bitmover.com> <89360000.1062613076@flay>
 <20030904003633.GA5227@work.bitmover.com> <6130000.1062642088@[10.10.2.4]>
 <20030904023446.GG5227@work.bitmover.com> <Pine.LNX.4.56.0309032015100.2146@bigblue.dev.mdolabs.com>
 <20030904041600.GA16959@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003, Larry McVoy wrote:

> On Wed, Sep 03, 2003 at 08:47:49PM -0700, Davide Libenzi wrote:
> > On Wed, 3 Sep 2003, Larry McVoy wrote:
> > > Maybe because history has shown over and over again that your pet theory
> > > doesn't work.  Mine might be wrong but it hasn't been proven wrong.  Yours
> > > has.  Multiple times.
> >
> > Why companies selling HW should go with this solution?
>
> Higher profits.

And in which way exactly ?  You not only didn't make a bare-bone
implementation (numbers talk, bullshits walk), but you didn't even make a
business case here. This is not cold-fusion stuff Larry, SSI concepts are
around by a long time. Ppl didn't buy it, sorry. Beowulf-like clusters have
had a moderate success because they're both cheap and scale very well for
certain share-zero applications. They didn't buy SSI because of the need
of applications remodelling (besides the cool idea of a SSI, share-a-lot
applications will still suck piles compared to SMP), that is not very
popular in businesses that are the target of these systems. They didn't
buy SSI because if they had scalability problems and their app was a
share-nada thingy so that they were willing to rewrite it, they'd be
already using Beowulf-style clusters. Successfull new hardware (in the
really general term) is the one that fits your current solutions/methods
by, at the same time, giving you an increased power/features.



- Davide

