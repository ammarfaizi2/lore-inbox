Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261607AbSJFN3w>; Sun, 6 Oct 2002 09:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261611AbSJFN3w>; Sun, 6 Oct 2002 09:29:52 -0400
Received: from mx1.elte.hu ([157.181.1.137]:16082 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S261607AbSJFN3v>;
	Sun, 6 Oct 2002 09:29:51 -0400
Date: Sun, 6 Oct 2002 15:46:29 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: "David S. Miller" <davem@redhat.com>
Cc: Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: New BK License Problem?
In-Reply-To: <20021005112552.A9032@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0210061528560.6780-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 Oct 2002, Larry McVoy wrote:

> The clause is specifically designed to target those companies which
> produce or sell commercial SCM systems. [...] The open source developers
> have nothing to worry about.

and:

On Sat, 5 Oct 2002, Larry McVoy wrote:

> > Larry, I develop for the Subversion project. Does that mean my license
> > to use bitkeeper is revoked?
> 
> Yes.  It has been since we shipped that license or when you started
> working on Subversion, whichever came last.


this kind of sudden change in Larry's written opinion within 24 hours is
that makes this whole issue dangerous. Fact is that Larry is free to
license his product under fair or unfair terms - it's his. While we
already gave BK/BM tons of feedback, free beta-testing and free publicity,
all we have is this volatile promise that the binary bits of BK are going
to remain licensed - and with every day it will be harder and harder to
move the repository.

what happens if Linux merges some sort of kernel based versioned
filesystem, eg. something similar to what ClearCase does today? Will the
license suddenly change to 'as long as you do not work on the versioned-FS
kernel subsystem'? Or isnt this already a violation of the current
license?

this is why i'd rather want to have an iron-clad legal way out first, and
not have to rely on nonbinding promises done on public lists. I'm sure
Larry understands this position, he has exactly the same position when
trying to protect his business against hordes of freebies.

	Ingo

