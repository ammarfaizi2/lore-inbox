Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265815AbTCDAGZ>; Mon, 3 Mar 2003 19:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266010AbTCDAGZ>; Mon, 3 Mar 2003 19:06:25 -0500
Received: from [195.223.140.107] ([195.223.140.107]:28301 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S265815AbTCDAGX>;
	Mon, 3 Mar 2003 19:06:23 -0500
Date: Tue, 4 Mar 2003 01:15:52 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: David Lang <david.lang@digitalinsight.com>,
       Larry McVoy <lm@work.bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arador <diegocg@teleline.es>, "Adam J. Richter" <adam@yggdrasil.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       pavel@janik.cz, pavel@ucw.cz
Subject: Re: BitBucket: GPL-ed *notrademarkhere* clone
Message-ID: <20030304001552.GU16918@dualathlon.random>
References: <Pine.LNX.4.44.0303031554230.29949-100000@dlang.diginsite.com> <3E63ED14.5090809@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E63ED14.5090809@pobox.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03, 2003 at 07:02:28PM -0500, Jeff Garzik wrote:
> David Lang wrote:
> >On Mon, 3 Mar 2003, Andrea Arcangeli wrote:
> >
> >
> >>Just curious, this also means that at least around the 80% of merges
> >>in Linus's tree is submitted via a bitkeeper pull, right?
> >>
> >>Andrea
> >
> >
> >remember how Linus works, all normal patches get copied into a single
> >large patch file as he reads his mail then he runs patch to apply them to
> >the tree. I think this would make the entire batch of messages look like
> >one cset.
> 
> 
> Not correct.  His commits properly separate the patches out into 
> individual csets.

and they're unusable as source to regenerate a tree. I had similar
issues with the web too. to make use of the single csets you need to
implement the internal bitkeeper branching knowledge too. Not to tell
apparently the cset numbers changes all the time.

Andrea
