Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263394AbTFTRN2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 13:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbTFTRNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 13:13:16 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:43256 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S263394AbTFTRHm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 13:07:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Larry McVoy <lm@bitmover.com>
Subject: Re: [OT] Re: Troll Tech [was Re: Sco vs. IBM]
Date: Fri, 20 Jun 2003 12:21:22 -0500
X-Mailer: KMail [version 1.2]
Cc: Larry McVoy <lm@bitmover.com>, Nick LeRoy <nleroy@cs.wisc.edu>,
       Stephan von Krawczynski <skraw@ithnet.com>,
       Werner Almesberger <wa@almesberger.net>, miquels@cistron-office.nl,
       linux-kernel@vger.kernel.org
References: <063301c32c47$ddc792d0$3f00a8c0@witbe> <03062011583901.27684@tabby> <20030620170120.GI17563@work.bitmover.com>
In-Reply-To: <20030620170120.GI17563@work.bitmover.com>
MIME-Version: 1.0
Message-Id: <03062012212203.27684@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 June 2003 12:01, Larry McVoy wrote:
> On Fri, Jun 20, 2003 at 11:58:39AM -0500, Jesse Pollard wrote:
> > > One thing that is "new" is a passion for keeping the kernel fast with a
> > > lean system call layer.  I _love_ that part of Linux, it may seem
> > > subtle, but Linux is really the only operating system where you can use
> > > the OS level services as if they were library calls and not really
> > > notice that you are going into to the kernel.  That's very cool and you
> > > could say it is new in terms of cleanliness and discipline.
> >
> > Uhhh that is 20 years old... the original MULTICs had that.
>
> You've missed the key term "fast".  Unix exists because MULTICS was slow.
> What part of "keeping the kernel fast" was unclear?

Absolutely none. The key part is:

	...really the only operating system where you can use the OS level
	services as if they were library calls...

It was accomplished by COPYING the capability from MULTICS, then making
it fast by eliminating what wasn't copied - and that was done in the original
Unix, to run something "multics like" but for a very small system.

Even mmap existed in MULTICS before Sun "copied" it for use in their version
of Unix.
