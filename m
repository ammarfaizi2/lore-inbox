Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293285AbSCGFcy>; Thu, 7 Mar 2002 00:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293314AbSCGFcp>; Thu, 7 Mar 2002 00:32:45 -0500
Received: from bitmover.com ([192.132.92.2]:64130 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S293285AbSCGFck>;
	Thu, 7 Mar 2002 00:32:40 -0500
Date: Wed, 6 Mar 2002 21:32:38 -0800
From: Larry McVoy <lm@bitmover.com>
To: Troy Benjegerdes <hozer@drgw.net>
Cc: Tom Lord <lord@regexps.com>, linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: Why not an arch mirror for the kernel?
Message-ID: <20020306213238.D3240@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Troy Benjegerdes <hozer@drgw.net>, Tom Lord <lord@regexps.com>,
	linux-kernel@vger.kernel.org, davej@suse.de
In-Reply-To: <200203071425.GAA06679@morrowfield.home> <20020306190419.E31751@work.bitmover.com> <20020306225652.Q1682@altus.drgw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020306225652.Q1682@altus.drgw.net>; from hozer@drgw.net on Wed, Mar 06, 2002 at 10:56:52PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2002 at 10:56:52PM -0600, Troy Benjegerdes wrote:
> > > I am working on some tools that will help to implement automatic,
> > > incremental, bidirectional gateways between arch, Subversion, and Bk.
> > 
> > Gateways, yes, bidirectional, no.  Arch doesn't begin to maintain
> > the metadata which BK maintains, so it can't begin to solve the
> > same problems.  If you have a bidirectional gateway, you reduce BK
> > to the level of arch or subversion, in which case, why use BK at all?
> > If CVS/Arch/Subversion/whatever works for you, I'd say just use it and
> > leave BK out of it.
> 
> Okay Larry, reality check here... 

Go use arch and find out if you really want it.  Using arch at this
point is about as smart as using BK 3 years ago.  Cort did it 2 years ago
and that was painful enough.  To foist arch at this point on people is
actually the fastest way to kill it as a project.  These tools take time
to mature and if you want to help arch be prepared to do the same amount
of work that Cort did with BK.  It was a lot of work and time on his part.

And why Arch and not subversion?  Subversion has more people working on
it, Collab has put a pile of money into it, it has the Apache guy working
on it, and Arch has one guy with no money and a pile of shell scripts.
Come on.  There is nothing free in this life, if one guy and some hacking
could solve this problem, it would have been solved long ago.

I don't like gateways because they force everyone down to whatever
is the highest level of functionality that the weakest system can do.
It's exactly like a stereo system.  You don't spend $4000 on really nice
system and then try and drive it with $5 of speaker wire.  It will suck,
it's as good as the weakest part.  In spite of your claims to the contrary,
Troy, it is really not in our best interests to make a BK<->$OTHER_SCM
gateway if that means that BK now works only as well as those other
SCM systems.  That's just stupid.  If you want to do that, you do it,
but don't foist the work off on me by trying to pretend it's good for BK,
it's not.  Diluting BK down to the level of average SCM is completely
pointless and a waste of time.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
