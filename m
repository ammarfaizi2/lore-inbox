Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbTIGXrX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 19:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbTIGXrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 19:47:23 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:2403 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261720AbTIGXrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 19:47:22 -0400
To: Larry McVoy <lm@bitmover.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Brown, Len" <len.brown@intel.com>,
       Giuliano Pochini <pochini@shiny.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scaling noise
References: <20030903181550.GR4306@holomorphy.com>
	<1062613931.19982.26.camel@dhcp23.swansea.linux.org.uk>
	<20030903194658.GC1715@holomorphy.com> <105370000.1062622139@flay>
	<20030903212119.GX4306@holomorphy.com> <115070000.1062624541@flay>
	<20030903215135.GY4306@holomorphy.com> <116940000.1062625566@flay>
	<20030904010653.GD5227@work.bitmover.com>
	<m11xusnvqc.fsf@ebiederm.dsl.xmission.com>
	<20030907230729.GA19380@work.bitmover.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 07 Sep 2003 17:47:04 -0600
In-Reply-To: <20030907230729.GA19380@work.bitmover.com>
Message-ID: <m1wuckma9z.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy <lm@bitmover.com> writes:

> On Sun, Sep 07, 2003 at 03:18:19PM -0600, Eric W. Biederman wrote:
> > Larry McVoy <lm@bitmover.com> writes:
> > 
> > > Here's a thought.  Maybe the next kernel summit needs to have a CC cluster
> > > BOF or whatever.  I'd be happy to show up, describe what it is that I see
> > > and have you all try and poke holes in it.  If the net result was that you
> > > walked away with the same picture in your head that I have that would be
> > > cool.  Heck, I'll sponser it and buy beer and food if you like.
> > 
> > Larry CC clusters are an idiotic development target.
> 
> What a nice way to start a technical conversation.
> 
> *PLONK* on two counts: you're wrong and you're rude.  Next contestant please.

Ok. I will keep building clusters and the code that makes them work, and you can dream.

I backed up my assertion, and can do even better. 

I have already built a 2304 cpu machine and am working on a 2900+ cpu
machine.  

The software stack and that part of the idea are reasonable but your
target hardware is just plain rare, and expensive.  

If you don't get the commodity OS on commodity hardware thing, I'm sorry.

The thing is for all of your talk of Dell, Dell doesn't make the hardware you
need for a CC cluster.  And because the cc NUMA interface requires a
manufacturer to make chips, and boards, I have a hard time seeing 
cc NUMA hardware being a commodity any time soon.

Eric
