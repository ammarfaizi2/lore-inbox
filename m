Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263433AbRFFP2z>; Wed, 6 Jun 2001 11:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263434AbRFFP2p>; Wed, 6 Jun 2001 11:28:45 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:48006 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S263433AbRFFP2d>; Wed, 6 Jun 2001 11:28:33 -0400
Date: Wed, 6 Jun 2001 09:28:20 -0600
Message-Id: <200106061528.f56FSKa14465@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Sean Hunter <sean@dev.sportingbet.com>,
        Xavier Bestel <xavier.bestel@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <0106061316300A.00553@starship>
In-Reply-To: <3B1D5ADE.7FA50CD0@illusionary.com>
	<991815578.30689.1.camel@nomade>
	<20010606095431.C15199@dev.sportingbet.com>
	<0106061316300A.00553@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips writes:
> On Wednesday 06 June 2001 10:54, Sean Hunter wrote:
> 
> > > Did you try to put twice as much swap as you have RAM ? (e.g. add a
> > > 512M swapfile to your box)
> > > This is what Linus recommended for 2.4 (swap = 2 * RAM), saying
> > > that anything less won't do any good: 2.4 overallocates swap even
> > > if it doesn't use it all. So in your case you just have enough swap
> > > to map your RAM, and nothing to really swap your apps.
> >
> > For large memory boxes, this is ridiculous.  Should I have 8GB of
> > swap?

Sure. It's cheap. If you don't mind slumming it, go and buy a 20 GB
IDE drive for US$65. I know RAM has gotten a lot cheaper lately (US$66
for a 512 MiB PC133 DIMM), but it's still far more expensive. If you
can afford 4 GiB of RAM, you can definately afford 8 GiB of swap.

> And laptops with big memories and small disks.

That's not that common, though. Usually you get far more disc than RAM
on a laptop, just as with a desktop.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
