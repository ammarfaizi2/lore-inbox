Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbUJXOpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbUJXOpB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 10:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbUJXOpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 10:45:01 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:34243 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261504AbUJXOo6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 10:44:58 -0400
Date: Sun, 24 Oct 2004 07:44:48 -0700
From: Larry McVoy <lm@bitmover.com>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>, akpm@osdl.org
Subject: Re: BK kernel workflow
Message-ID: <20041024144448.GA575@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Larry McVoy <lm@bitmover.com>, akpm@osdl.org
References: <41752E53.8060103@pobox.com> <20041019153126.GG18939@work.bitmover.com> <41753B99.5090003@pobox.com> <4d8e3fd304101914332979f86a@mail.gmail.com> <20041019213803.GA6994@havoc.gtf.org> <4d8e3fd3041019145469f03527@mail.gmail.com> <Pine.LNX.4.58.0410191510210.2317@ppc970.osdl.org> <20041023161253.GA17537@work.bitmover.com> <4d8e3fd304102403241e5a69a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d8e3fd304102403241e5a69a5@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2004 at 12:24:42PM +0200, Paolo Ciarrocchi wrote:
> On Sat, 23 Oct 2004 09:12:53 -0700, Larry McVoy <lm@bitmover.com> wrote:
> > On Tue, Oct 19, 2004 at 03:11:55PM -0700, Linus Torvalds wrote:
> > > On Tue, 19 Oct 2004, Paolo Ciarrocchi wrote:
> > > > I know I'm pedantic but can we all see the list of bk trees ("patches
> > > > ready for mainstream" and "patches eventually ready for mainstream")
> > > > that we'll be used by Linus ?
> > >
> > > Even _I_ don't have that kind of list.
> > 
> > I don't know how you could have that sort of list.  We have some idea
> > of the potential size of that list and it's huge.  Based on the lease
> > requests back to us (BK is lease based, it connects back to us once a
> > month), we estimate that there well over 10,000 clones of the Linux kernel
> > in BK.  If even 1/10th of those are going to have a patch for Linus that's
> > 1,000 potential patches.  Pretty hard to keep that all in your head.
> 
> Well, I'm not interested in having the list of all the bk trees used
> during the develpoment of a release.
> I was looking to the trees used by mantainers.

And how do you define a maintainer?  That's a moving target.  Part of the
beauty of the Linux development model is that mini forks are not only
allowed, they are encouraged.  So people can go off on their own and do
something interesting.  Who knows?  One of those people could be the next
Alan.  

> That number should me really different from "1,000".

Sure.  But even so it's a moving target and labeling a set of people as 
maintainers implies that other people aren't.  I suspect Linus isn't 
that interested in the labels, he'll take good code from anyone.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
