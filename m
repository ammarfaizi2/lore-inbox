Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316167AbSE3CYC>; Wed, 29 May 2002 22:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316204AbSE3CYB>; Wed, 29 May 2002 22:24:01 -0400
Received: from modemcable084.137-200-24.mtl.mc.videotron.ca ([24.200.137.84]:10652
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S316167AbSE3CYA>; Wed, 29 May 2002 22:24:00 -0400
Date: Wed, 29 May 2002 22:23:45 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Thunder from the hill <thunder@ngforever.de>,
        Tomas Szepe <szepe@pinerecords.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Paul P Komkoff Jr <i@stingr.net>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.19 - What's up with the kernel build?
In-Reply-To: <E17DDvk-0006qp-00@starship>
Message-ID: <Pine.LNX.4.44.0205292139210.23147-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 May 2002, Daniel Phillips wrote:

> On Thursday 30 May 2002 02:17, Nicolas Pitre wrote:
> 
> > Linus himself once said: "Especially as I don't find the existign system so
> > broken." He's not alone according to the amount (or lack) of public
> > complains with regards to the current system.
> 
> I think a lot of us were not complaining because we thought it was a done
> deal.

Well it's obviously not.

> Now what's necessary, do we have to form cheerleading teams and start lobbying
> to get what we thought was coming anyway?  

Probably.  At least that often was necessary for most large features in the 
past... especially when those features weren't necessarily _interesting_ to 
Linus.

> It's really not a pleasant feeling to be put in that position.  Nobody
> relishes the role of outspoken advocate of this or that, at least I do
> not.  I'd *much* rather be hacking.

Sure.  But what if only Keith alone publicly praises the virtues of kb25?  
And if Linus on the other end doesn't care much?  And if nobody else is 
showing any interest?

> You've got it backwards.  The function of the maintainers you mentioned is
> to *resist* change, not promote it.  In this case, change comes from the top,
> and as long as Linus doesn't realize that there really is a lot of demand
> for this change, nothing is going to happen.

Well that's exactly what I'm saying is happening. Interest seem pretty low 
unfortunately.  Otherwise more people would stop hacking for a minute and 
advocate a little for the inclusion of kb25.

> > If people aren't interested enough and/or willing to comply with Linus'
> > requirements this will be a sad dead end, regardless the amount of effort
> > Keith put into this.
> 
> Now wait, it seems to me that only Keith is being asked to comply with
> requirements, and they're tough requirements.  The burden is just not
> being shared equally.

Well given the current lack of interest (or let's say enthusiasm to be more 
correct) for kb25, why would Linus be bothered?  Since most people are 
indifferent at this point the burden is likely to remain in Keith's hands.

If that's not the case then let's go people and speak up, advocate for
patches in secondary trees, send your appreciation to Linus and lkml, but
don't stay still.  The preemptive kernel patch just to name that example 
got much more visibility, adoption and promotion than what kb25 had up to 
now.

Otherwise we'll continue fixing the current build system and forget about
kbuild25.


Nicolas

