Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286207AbSA2XRN>; Tue, 29 Jan 2002 18:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286647AbSA2XPu>; Tue, 29 Jan 2002 18:15:50 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:34577 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S286821AbSA2XOZ>; Tue, 29 Jan 2002 18:14:25 -0500
Date: Tue, 29 Jan 2002 18:12:55 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable 
In-Reply-To: <200201212218.g0LMI8BQ002150@tigger.cs.uni-dortmund.de>
Message-ID: <Pine.LNX.3.96.1020129180855.31511H-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2002, Horst von Brand wrote:

> Robert Love <rml@tech9.net> said:
> 
> [...]
> 
> > It doesn't have to run mostly in the kernel.  It just has to be in the
> > kernel when the I/O-bound tasks awakes.  Further, there are plenty of
> > what we consider CPU-bound tasks that are interactive and/or
> > graphics-oriented and this adds much to their time in the kernel.
	[ snip ]
> For the mostly positive (subjective) responses you see, there is something
> called "psycology", which would predict that for _exactly_ the same "feel"
> (whatever that may be) somebody who just made an effort downloading
> patches, applying them, reconfiguring ad building a kernel "to make it feel
> better" _will_ feel it better. I.e., nobody wants to have to say "Okay,
> lots of work down the drain". Besides, those who see no difference will
> shut up, those that delude themselves most will be vocal about it.

Ah, that's it, we're deluding ourselves. To the point that booting a
kernel without identification and having casual users watch the cursor
move while running a standard low will result in those users sharing our
delusion.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

