Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263977AbTBETD0>; Wed, 5 Feb 2003 14:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263794AbTBETDY>; Wed, 5 Feb 2003 14:03:24 -0500
Received: from crack.them.org ([65.125.64.184]:48608 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S263491AbTBETDV>;
	Wed, 5 Feb 2003 14:03:21 -0500
Date: Wed, 5 Feb 2003 14:12:48 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Nilmoni Deb <ndeb@ece.cmu.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Monta Vista software license terms
Message-ID: <20030205191248.GA23234@nevyn.them.org>
Mail-Followup-To: Nilmoni Deb <ndeb@ece.cmu.edu>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1044472537.32062.33.camel@irongate.swansea.linux.org.uk> <Pine.LNX.3.96L.1030205135812.5144e-100000@frodo.ece.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96L.1030205135812.5144e-100000@frodo.ece.cmu.edu>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2003 at 02:02:38PM -0500, Nilmoni Deb wrote:
> 
> On 5 Feb 2003, Alan Cox wrote:
> 
> > On Wed, 2003-02-05 at 11:58, Nilmoni Deb wrote:
> > >  Note that your obligation is strictly to the recipients of binaries
> > > (i.e., your customers). You have no responsibility to the "community" at
> > > large."
> > 
> > This is correct. Its actually very important. A lot of GPL software is
> > created by a small company for another. It would be completely unfair
> > for that small company to be expected to ship stuff to everyone. Their
> > customer may choose to but then they must distribute sources and so in
> > turn.
> 
> While one issue stands resolved (that a vendor complying with clause 3a of
> GPL 2.0 does not have to comply with 3b), the GPL may have been
> misprepresented by MontaVista, as per the opinion of a FSF member (Dave
> Turner via RT <license-violation@fsf.org>):
> 
> -------- EXCERPT STARTS ---------
> 
> >  Note that your obligation is strictly to the recipients of binaries
> > (i.e., your customers). You have no responsibility to the "community" at
> > large."
> > 
> > 
> >       Its the last sentence that is of concern. Does this mean no 3rd
> > party (who is not a customer) can get the GPL source code part of their
> > products ?
> 
> Actually, they're wrong -- if they choose (3)(b), their offer must be
> open to all third parties.  And they're wrong about who their
> "obligation" is to -- legally speaking, their license comes from the
> copyright holder.
> 
> -------- EXCERPT ENDS ---------
> 
> > Montavista feed a fair bit of stuff back into the kernel, especially at
> > the mips end of the universe.

We don't deal with 3(b), actually.  All our binary distributions
include source, a la 3(a).

It's generally considered polite to discuss your concerns with whoever
you're concerned with, instead of attempting to report them and rouse
public reaction, you know.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
