Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbTJJRF2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 13:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262968AbTJJRF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 13:05:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:22198 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262963AbTJJRFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 13:05:22 -0400
Date: Fri, 10 Oct 2003 10:04:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: Joel Becker <Joel.Becker@oracle.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
In-Reply-To: <3F86DF4B.6020509@nortelnetworks.com>
Message-ID: <Pine.LNX.4.44.0310100958030.20420-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Oct 2003, Chris Friesen wrote:
> 
> How does this play with massive (ie hundreds or thousands of gigabytes) 
> databases?  Surely you can't expect to put it all in memory?

Hey, I'm a big believer in mass market.

Which means that I think odd-ball users will have to use odd-ball
databases, and pay through the nose for them. That's fine. But those db's
are doing to be very rare.

Your arguments are all the same stuff that made PC's "irrelevant" 15 years 
ago. 

I'm not sayign in-memory is here tomorrow. I'm just saying that anybody 
who isn't looking at it for the mass market _will_ be steamrolled over 
when they arrive. 

If you were a company, which market would you prefer: the high-end 0.1% or
the rest? Yes, you can charge a _lot_ more for the high-end side, but you 
will eternally live in the knowledge that your customers are slowly moving 
to the "low end" - simply because it gets more capable.

And the thing is, the economics of the 99% means that that is the one that 
sees all the real improvements. That's the one that will have the nice 
admin tools, and the cottage industry that builds up around it. 

			Linus

