Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261930AbTCLU0y>; Wed, 12 Mar 2003 15:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261933AbTCLU0y>; Wed, 12 Mar 2003 15:26:54 -0500
Received: from modemcable166.48-200-24.mtl.mc.videotron.ca ([24.200.48.166]:19849
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S261930AbTCLU0w>; Wed, 12 Mar 2003 15:26:52 -0500
Date: Wed, 12 Mar 2003 15:37:28 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Ben Collins <bcollins@debian.org>
cc: Larry McVoy <lm@work.bitmover.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
In-Reply-To: <20030312195311.GK563@phunnypharm.org>
Message-ID: <Pine.LNX.4.44.0303121530090.14172-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Mar 2003, Ben Collins wrote:

> On Wed, Mar 12, 2003 at 02:32:57PM -0500, Nicolas Pitre wrote:
> > On Wed, 12 Mar 2003, Ben Collins wrote:
> > 
> > > > 	CVS: 110,076 deltas over all files
> > > > 	BK:  121,891 deltas over all files
> > > 
> > > (I can recalculate this if you tell me how many of the BK ones are empty
> > >  merge pointers)
> > > 
> > > 90.31%
> > > 
> > > I wasn't far off by saying 90%. And don't tell me I can get all the
> > > data, when in fact, I can't. 
> > 
> > What the hell don't you understand in the fact that the remaining 10% is
> > USELESS DATA WITH NO VALUE WHAT SO EVER ???
> > 
> > Oh of course you won't trust Larry and maybe he's trying to screw you with 
> > that 10% by carefully crafting essential details in there so you'll end up 
> > being forced into buying a BK license otherwise you won't be able to make 
> > any sense of what happened in the source tree, or even make it compile!  
> > Isn't it pure paranoia?
> > 
> 
> What part of the structure of the BK repo don't you understand? Didn'y
> you pay attention to what Larry said? The tree looks like branches that
> always return to the trunk. To put this into CVS, he had to choose a
> line of those branches that contained the _most_ changesets (which
> doesn't always equate to the most important, or largest deltas). There
> are some changesets on the side that are not included here. Are all of
> those changesets empty merges? No.

Did you at least care to inspect the resulting CVS repository before
complaining?  It looks you didn't, and still so quick to dismiss what Larry
and co have done.


Nicolas

