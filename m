Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262710AbSJGUdE>; Mon, 7 Oct 2002 16:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263129AbSJGUdE>; Mon, 7 Oct 2002 16:33:04 -0400
Received: from modemcable166.48-200-24.mtl.mc.videotron.ca ([24.200.48.166]:48516
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S262710AbSJGUc3>; Mon, 7 Oct 2002 16:32:29 -0400
Date: Mon, 7 Oct 2002 16:37:56 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Larry McVoy <lm@work.bitmover.com>, Craig Dickson <crdic@pacbell.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: New BK License Problem?
In-Reply-To: <20021007213011.C833@ucw.cz>
Message-ID: <Pine.LNX.4.44.0210071627200.913-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2002, Vojtech Pavlik wrote:

> On Mon, Oct 07, 2002 at 10:35:22AM -0700, Larry McVoy wrote:
> > > Could you clarify exactly why it is a problem that someone both uses
> > > BitKeeper and works on potentially-competing SCM systems, if the two
> > > activities are unrelated? 
> > ...
> > > Is it that you think that direct
> > > experience with BK will give someone insight into its pluses and minuses
> > > beyond what they could get from just reading about it, thereby
> > > indirectly making their competing product better?
> > 
> > That's it.  BK is fairly subtle, it takes a while to wrap your brain around
> > it.  The way it works is hard to see from the outside and it is hard to see
> > the value.  So blind copying is more likely to copy the wrong parts.  On
> > the other hand, if I'm using BK every day and then working on a clone, it's
> > very easy to "do some unrelated work" to see how BK works.
> 
> Q: Does the paid license also prohibit usage by people whose companies
> work on other source-management systems? In that case, well, if they
> need to get used with BK to evaluate it's strong points, then they will.

Well they'll even use the free version, use it for a dummy project with some
anonymous email address for the open logging requirement, and won't tell
anyone about it.  We need to be realistic here this is common practice in 
the industry even if no one will admit it.

Maybe we should add an additional restriction to the Linux kernel license 
saying that Microsoft has no right to use Linux since they're making a 
competitor product.  Let's see if that changes anything.


Nicolas

