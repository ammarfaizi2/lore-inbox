Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129609AbQKINa0>; Thu, 9 Nov 2000 08:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129914AbQKINaQ>; Thu, 9 Nov 2000 08:30:16 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:45979 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129609AbQKINaD>;
	Thu, 9 Nov 2000 08:30:03 -0500
Date: Thu, 9 Nov 2000 08:30:02 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
cc: Christoph Rohland <cr@sap.com>, Larry McVoy <lm@bitmover.com>,
        richardj_moore@uk.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
In-Reply-To: <3A0AA063.DD5AB6D0@holly-springs.nc.us>
Message-ID: <Pine.GSO.4.21.0011090812500.11045-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 Nov 2000, Michael Rothwell wrote:

> Alexander Viro wrote:
> > 
> > On Thu, 9 Nov 2000, Michael Rothwell wrote:
> > 
> > > Same as before -- freedom and low cost. The primary advantae of Linux
> > > over other OSes is the GPL.
> > 
> > Now, that's more than slightly insulting...
> 
> Well, it wasn't meant to be. I imagine RMS would make the same type of
> statement -- Linux is libre, therefore superior. There's a number of

<shrug> RMS had repeatedly demonstrated what he's worth as a designer
and programmer. Way below zero. You may like or dislike his ideology,
but when it comes to technical stuff... Not funny.

> OSes that have advantages of Linux in some area; Solaris can use more
> processors; QNX is real-time, smaller and still posix; Windows has
> better application support (i.e., more of them); MacOS has better color
> and font management. But, Linux is free. Let's say for a moment that
> Linux was exactly the same as Solaris, technically. Linux would be

You mean, bloated tasteless parody on UNIX? Thanks, but no thanks.

> superior because it is licensed under the GPL, and is free; whereas
> Solaris would not be.

Small solace it would be.

> > The problem with the hooks et.al. is very simple - they promote every
> > bloody implementation detail to exposed API. Sorry, but... See Figure 1.
> > It won't fly.
> 
> Figure 1?

Use search engine. On google "See Figure 1" brings the thing in the first
5 hits.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
