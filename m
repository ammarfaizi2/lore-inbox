Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310393AbSCGQSQ>; Thu, 7 Mar 2002 11:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310392AbSCGQR4>; Thu, 7 Mar 2002 11:17:56 -0500
Received: from altus.drgw.net ([209.234.73.40]:26123 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S310398AbSCGQRu>;
	Thu, 7 Mar 2002 11:17:50 -0500
Date: Thu, 7 Mar 2002 10:17:01 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: Larry McVoy <lm@work.bitmover.com>, Kent Borg <kentborg@borg.org>,
        The Open Source Club at The Ohio State University 
	<opensource-admin@cis.ohio-state.edu>,
        linux-kernel@vger.kernel.org, opensource@cis.ohio-state.edu
Subject: Re: Petition Against Official Endorsement of BitKeeper by Linux Maintainers
Message-ID: <20020307101701.S1682@altus.drgw.net>
In-Reply-To: <20020305165233.A28212@fireball.zosima.org> <20020305163809.D1682@altus.drgw.net> <20020305165123.V12235@work.bitmover.com> <20020306095434.B6599@borg.org> <20020306085646.F15303@work.bitmover.com> <20020306221305.GA370@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020306221305.GA370@elf.ucw.cz>; from pavel@ucw.cz on Wed, Mar 06, 2002 at 11:13:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2002 at 11:13:05PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > I also dislike the irony of BK being proprietary.  Sure, they might
> > > have an enlightened and generous attitude not, but PGP used to be
> > > free, then it became kinda free and then it became orphaned.  Luckily
> > > GPG came along, luckily PGP didn't have a monoploy on our history.
> > 
> > PGP didn't have a business model, we do, and part of our business model
> > is to give it away to some of the world.  It's a good business model,
> > BK is dramatically better because the PPC team used it and Cort went
> > through all sorts of stuff as BK improved.  BK would easily be a
> > year
> 
> So you basically give bk for free because it is good for you. What if
> it will stop being good for you ten years from now?

Then we move on to another system. This is why I think we need some kind
of gateway to another SCM. If BK goes away, we could export everything to
tarballs and patches or whatever, but it would be a large PITA, and stop
lots of people's development for awhile. (I've done bk->cvs this way once
before, it was really ugly, and I never want to do it again given the
choice).

I'd really like everyone that's bitching about BK to shut the hell up and
go work on some scripts to allow a maintainer to easily manage a
BK<->$OTHER_SCM gateway. Either give me a working alternative to BK or go
run for political office. Until I see an alternative, I'm going to
continue advocating for real developers to use BK, and complainers to show
me an alternative.

-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Schulz
