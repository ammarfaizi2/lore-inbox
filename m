Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262904AbUDANjS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 08:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbUDANjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 08:39:18 -0500
Received: from mail.shareable.org ([81.29.64.88]:4757 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S262904AbUDANjQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 08:39:16 -0500
Date: Thu, 1 Apr 2004 14:39:12 +0100
From: Jamie Lokier <jamie@shareable.org>
To: bert hubert <ahu@ds9a.nl>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: who is merlin.fit.vutbr.cz?
Message-ID: <20040401133912.GA25163@mail.shareable.org>
References: <200403290108.i2T18T8d024595@work.bitmover.com> <20040331182039.GA29397@outpost.ds9a.nl> <20040331213143.GC20693@mail.shareable.org> <20040331214517.GB1599@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040331214517.GB1599@outpost.ds9a.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert wrote:
> On Wed, Mar 31, 2004 at 10:31:43PM +0100, Jamie Lokier wrote:
> > > RCU for BitKeeper trees? :-)
> > 
> > Last I heard, RCU is patented by IBM, with permission to use it in GPL
> > programs (maybe limited to version 2 of the GPL?), so that Linux can use it.
> 
> This is really astonishing. It is not possible to say one thing about
> bitkeeper without descending into a discussion on patents and licenses!

No.  It's an unfortunate coincidence that you mentioned RCU on a
BitKeeper(tm) thread.  A suggestion to use RCU in, say, Mozilla or
FreeBSD would have elicited a similar response.

RCU patents were mentioned numerous times in the news when RCU was
added to the kernel.  One presumes, then, that IBM was keen for it to
be known the technique is patented, and one would be wise to tread
carefully if intending to copy the technique as it is used in Linux,
as you jokingly suggested.

In case you misunderstood, the grandparent post was not an attack on
BitMover.  Fwiw, I'm on BitMover's side if the RCU patent is relevant,
which it probably is not.  I doubt if the patent extends beyond task
scheduling done in a certain way, although as I said I have not read it.

-- Jamie
