Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261685AbSJFQTK>; Sun, 6 Oct 2002 12:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261695AbSJFQRx>; Sun, 6 Oct 2002 12:17:53 -0400
Received: from bitmover.com ([192.132.92.2]:45965 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S261685AbSJFQRW>;
	Sun, 6 Oct 2002 12:17:22 -0400
Date: Sun, 6 Oct 2002 09:22:56 -0700
From: Larry McVoy <lm@bitmover.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>, Manfred Spraul <manfred@colorfullife.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>, "David S. Miller" <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: BK MetaData License Problem?
Message-ID: <20021006092256.H29486@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
	Manfred Spraul <manfred@colorfullife.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Larry McVoy <lm@bitmover.com>, "David S. Miller" <davem@redhat.com>,
	Linus Torvalds <torvalds@transmeta.com>
References: <Pine.LNX.4.44.0210061452400.6237-100000@localhost.localdomain> <1033921747.21257.6.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1033921747.21257.6.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Sun, Oct 06, 2002 at 05:29:07PM +0100
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2002 at 05:29:07PM +0100, Alan Cox wrote:
> On Sun, 2002-10-06 at 14:13, Ingo Molnar wrote:
> > yes, but what i say is that BK *creates* a problem, (just like CVS would
> > create similar problems) and the license clearly shows that BM is aware of
> > and tries to handle part of this legal problem. (And given that the BK
> > metadata is richer than eg. CVS, i suspect it will be a magnified problem
> > later on.)
> 
> The onyl real problem BK creates here IMHO is its not possible to use BK
> to maintain the true master tree of a piece of software, because like
> everyone else Linux people get security reports/fixes which are set to
> go out on specific dates by people like CERT. The BK rules prevent
> anyone from checking a change into their BK tree until the embargo date,
> which can be a pain in the butt.

We could easily fix this at our end.  We already have mechanisms to not
publish openlogging trees, that's how we handle the research/edu waivers,
we could figure out some way to do the same for individual changesets.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
