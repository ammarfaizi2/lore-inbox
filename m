Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266761AbTADJiF>; Sat, 4 Jan 2003 04:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266765AbTADJiF>; Sat, 4 Jan 2003 04:38:05 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:23304
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S266761AbTADJiE>; Sat, 4 Jan 2003 04:38:04 -0500
Date: Sat, 4 Jan 2003 01:45:44 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Andrew McGregor <andrew@indranet.co.nz>
cc: Ryan Anderson <ryan@michonline.com>, linux-kernel@vger.kernel.org
Subject: Re: Gauntlet Set NOW!
In-Reply-To: <122810000.1041671690@localhost.localdomain>
Message-ID: <Pine.LNX.4.10.10301040135420.421-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is a solution out there and as soon as I can verify it works,
gameover for anyone thinking they will get access to soft IP again by
banging a dead drum.

CAM, Content Addressable Memory on a card.

Usage will be to stuff any binary soft code now reclassified as "firmware"
into a piece of hardware.  Set the addressable memory hooks for what is
now called the open source wrapper for binary objects, and game is over.

There is hardware with a software core which is totally embedded for all
practical purposes.  Use your existing GPL wrapper and call it you new
driver!  Funny how people come up with ways to thwart the sticky fingers
to rip off IP and hard work.  Lets see how GPL goes to get soft IP locked
into hardware.

Force rules and license into places they do not belong, and evolution
happens to push back and impose the boundaries of IP.

Surprised ?  Not me.

Cheers,

Andre Hedrick
LAD Storage Consulting Group


On Sat, 4 Jan 2003, Andrew McGregor wrote:

> I am aware that there was little confirmation from other developers (so far 
> as I remember, there was some, plus a few dissenting views).
> 
> I was *only* talking about Linus' position, which I admit was being 
> selective in that context.
> 
> My real point was this:  It appears to me that NVIDIA have gone as far as 
> they can in releasing the code to their driver.  It has certainly been my 
> own policy to do so with various code, and the result was not GPL because 
> of legal constraints.
> 
> Punishing a company who have, with goodwill, opened up their code as far as 
> they were allowed by preexisting agreements for license issues is not a 
> smart move, and will only hurt the free software community in the long run.
> 
> And to those who say 'well, just release the specs':  Quite likely NVIDIA 
> did not design all the subsystems of their chips, but instead bought 'IP 
> block' licenses from someone else.  The license NVIDIA have access to those 
> under probably will not allow that release, whether NVIDIA would like to 
> release that information or not.
> 
> Effectively, the binary part of the driver can be viewed as part of the 
> hardware, just as much as it can be viewed as part of the kernel.  It is 
> constrained in hardware-like ways, not much like software at all.
> 
> My view, for what it's worth, is that if binary modules are not allowed by 
> the kernel being GPL, then it is worth going to some trouble to allow 
> binary hardware drivers by some other mechanism than a module, since it is 
> effectively impossible to change the license on the kernel now, as you 
> correctly point out.  Even if they want to, many hardware vendors will not 
> be able to release full specifications or GPL code for quite some time, and 
> it is better to allow those that are motivated to to open up as much as 
> they can, than to require only that hardware for which full information or 
> GPL-able code is available to be used with Linux.  And saying that the 
> vendor then has to assume all the maintenance trouble keeps the pressure on 
> them to evolve toward openness.
> 
> Andrew
> 
> --On Saturday, January 04, 2003 02:12:09 -0500 Ryan Anderson 
> <ryan@michonline.com> wrote:
> 
> > On Sat, Jan 04, 2003 at 12:56:53PM +1300, Andrew McGregor wrote:
> >
> > [snip]
> >
> >> Linus has made it quite clear in the past that his position on binary
> >> modules is that they are explicitly allowed, but that the maintainers of
> >> such a thing 'get everything they deserve' in terms of maintenance
> >> hassle.
> >
> > I *really* think you need to do some searches on this list to verify
> > this statement.
> >
> > Let me summarize what I remember from past discussions of this nature.
> >
> > Linus put his code under the GPL.  Contributions came in, under the same
> > license.  At some point, the first binary only module showed up.  When
> > asked about the legality, Linus said something to the effect of, "I
> > think they're ok."
> >
> > Note the lack of clarification from the other (miriad) copyright
> > holders?
> >
> > In summary - If you want to write binary only modules, you need to talk
> > to a lawyer that understands the issues involved.  "Linus said they were
> > ok" doesn't even begin to encompass the number of copyright holders
> > involved.
> >
> >
> > --
> >
> > Ryan Anderson
> >   sometimes Pug Majere
> >
> >
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

