Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270672AbTGNPVw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 11:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270683AbTGNPVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 11:21:52 -0400
Received: from 224.Red-217-125-129.pooles.rima-tde.net ([217.125.129.224]:54514
	"HELO cocodriloo.com") by vger.kernel.org with SMTP id S270672AbTGNPVr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 11:21:47 -0400
Date: Mon, 14 Jul 2003 17:07:40 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test, how to test it? [Was: Linux v2.6.0-test1]
Message-ID: <20030714150740.GB2684@wind.cocodriloo.com>
References: <Pine.LNX.4.44.0307132055080.2096-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307132055080.2096-100000@home.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 13, 2003 at 08:59:07PM -0700, Linus Torvalds wrote:
> 
> Ok,
>  the naming should be familiar - it's the same deal as with 2.4.0.
> 
> One difference is that while 2.4.0 took about 7 months from the pre1 to 
> the final release, I hope (and believe) that we have fewer issues facing 
> us in the current 2.6.0. But very obviously there are going to be a
> few test-releases before the real thing.
> 
> The point of the test versions is to make more people realize that they
> need testing and get some straggling developers realizing that it's too
> late to worry about the next big feature. I'm hoping that Linux vendors
> will start offering the test kernels as installation alternatives, and
> do things like make upgrade internal machines, so that when the real
> 2.6.0 does happen, we're all set.

In the meantime, what about a "running 2.6.0-test HOWTO"?

ie:

1. base distro you using right now for testing

2. which updates are needed for said distro (I assume modutils, any others?)

3. compiler to use

4. parts which should be abused without fears for data loss

5. parts which could eat disks, for those with separate desktop/test machines

6. whatever else you can think about


on a related note, from reading lkml I can see that in-tree ext3
is in good shape, what about reiser3 or reiser4?


>
> 		Linus
> 
> [ BIIIIIIG SNIP ]
>

Greets, Antonio.

-- 

In fact, this is all you need to know to be
a Caveman Database Programmer:

A relational database is a big spreadsheet
that several people can update simultaneously. 

