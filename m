Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932229AbWFRNtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbWFRNtk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 09:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWFRNtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 09:49:40 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:41490 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932229AbWFRNtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 09:49:39 -0400
Date: Sun, 18 Jun 2006 15:49:37 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.17
Message-ID: <20060618134937.GA21463@stusta.de>
References: <Pine.LNX.4.64.0606171856190.5498@g5.osdl.org> <Pine.LNX.4.64.0606171902040.5498@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606171902040.5498@g5.osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2006 at 07:06:17PM -0700, Linus Torvalds wrote:
> 
> 
> On Sat, 17 Jun 2006, Linus Torvalds wrote:
> > 
> > Not a lot of changes since the last -rc, the bulk is actually some 
> > last-minute MIPS updates and s390 futex changes, the rest tend to be 
> > various very small fixes that trickled in over the last week.
> 
> Btw, one thing that I was planning to ask people - does anybody find the 
> full-format ChangeLog's that I produce at all useful?
> 
> You can get the exact same information directly from git, and the full 
> changelog (as opposed to the shortlog) tends to be pretty rough to read, 
> so I suspect that most people who do want to delve into the details are 
> actually much more likely to look it up using git instead (at which point 
> you can obviously get much better information - graphical history, diffs, 
> etc)
> 
> I'm not going to stop doing the incremental shortlogs, since those are 
> easy to read and I usually post them with the release announcement unless 
> they end up being too large (usually -rc1 has a _lot_ of changes as a 
> result of the merge window), but I'm just wondering if anybody finds the 
> full logs useful at all?
> 
> They're easy for me to generate, but if nobody uses them, I don't see much 
> of a point..

I like to read the shortlog for getting an overview of the changes 
containing a bit more detail than your verbal summary at the top.

I need git for getting more detail and I could generate them myself. But 
if it wasn't there, I might not generate it myself, and might therefore 
not ask "Why did this patch get into -rc6?" or become curious enough for 
using git to check the contents of a commit.

> 			Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

