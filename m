Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261903AbTCMBsD>; Wed, 12 Mar 2003 20:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261911AbTCMBsD>; Wed, 12 Mar 2003 20:48:03 -0500
Received: from bitmover.com ([192.132.92.2]:59583 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S261903AbTCMBsC>;
	Wed, 12 Mar 2003 20:48:02 -0500
Date: Wed, 12 Mar 2003 17:58:46 -0800
From: Larry McVoy <lm@bitmover.com>
To: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030313015846.GK7275@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
References: <20030312174244.GC13792@work.bitmover.com> <Pine.LNX.4.44.0303121324510.14172-100000@xanadu.home> <20030312195120.GB7275@work.bitmover.com> <20030312201416.GA2433@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030312201416.GA2433@mars.ravnborg.org>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12, 2003 at 09:14:16PM +0100, Sam Ravnborg wrote:
> On Wed, Mar 12, 2003 at 11:51:20AM -0800, Larry McVoy wrote:
> > is what davej may have typed in as comments.  We capture that as well, it
> > looks like this:
> > 
> >     revision 1.342
> >     date: 2003/03/07 15:39:16;  author: torvalds;  state: Exp;  lines: +7 -1
> >     [PATCH] kbuild: Smart notation for non-verbose output
> 
> Ho humm, I did this not Linus.
> Checked the web which is correct.
> 
> Same goes for 1.340 for the Makefile. Kai did it, not Linus.

There is a "fixed" (I hope) linux-2.4 tree up.  We're still converting the
2.5 tree, ETA is about 6 hours (the fix substantially slowed down the 
coversion process, did I mention that this stuff is a pain?).  I'm going 
out for a while but I'll send out mail when the 2.5 tree is up.

If you have worked on files in 2.4 please go poke at them at 

cvs -d:pserver:anonymous@kernel.bkbits.net:/home/cvs rlog linux-2.4/<your file>

and see if you think that is accurate.  Let me know either way.  Thanks.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
