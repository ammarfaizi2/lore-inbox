Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284308AbRLBUaD>; Sun, 2 Dec 2001 15:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282920AbRLBU3x>; Sun, 2 Dec 2001 15:29:53 -0500
Received: from bitmover.com ([192.132.92.2]:30924 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S284306AbRLBU3l>;
	Sun, 2 Dec 2001 15:29:41 -0500
Date: Sun, 2 Dec 2001 12:29:40 -0800
From: Larry McVoy <lm@bitmover.com>
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Cc: Larry McVoy <lm@bitmover.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
Message-ID: <20011202122940.B2622@work.bitmover.com>
Mail-Followup-To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
	Larry McVoy <lm@bitmover.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20011130181415.C19152@work.bitmover.com> <200112012305.fB1N5xf1020409@sleipnir.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200112012305.fB1N5xf1020409@sleipnir.valparaiso.cl>; from vonbrand@sleipnir.valparaiso.cl on Sat, Dec 01, 2001 at 08:05:59PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2001 at 08:05:59PM -0300, Horst von Brand wrote:
> Larry McVoy <lm@bitmover.com> said:
> 
> [...]
> 
> > Because, just like the prevailing wisdom in the Linux hackers, they thought
> > it would be relatively straightforward to get SMP to work.  They started at
> > 2, went to 4, etc., etc.  Noone ever asked them to go from 1 to 100 in one
> > shot.  It was always incremental.
> 
> Maybe that is because 128 CPU machines aren't exactly common... just as
> SPARC, m68k, S/390 development lags behind ia32 just because there are
> many, many more of the later around.
> 
> Just as Linus said, the development is shaped by its environment.

Really?  So then people should be designing for 128 CPU machines, right?
So why is it that 100% of the SMP patches are incremental?  Linux is 
following exactly the same path taken by every other OS, 1->2, then 2->4,
then 4->8, etc.  By your logic, someone should be sitting down and saying
here is how you get to 128.  Other than myself, noone is doing that and
I'm not really a Linux kernel hack, so I don't count.  

So why is it that the development is just doing what has been done before?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
