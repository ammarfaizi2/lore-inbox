Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263488AbRFNVUt>; Thu, 14 Jun 2001 17:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264008AbRFNVUk>; Thu, 14 Jun 2001 17:20:40 -0400
Received: from ns.snowman.net ([63.80.4.34]:37647 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id <S263488AbRFNVUU>;
	Thu, 14 Jun 2001 17:20:20 -0400
Date: Thu, 14 Jun 2001 17:18:58 -0400 (EDT)
From: <nick@snowman.net>
To: Martin Moerman <linuxham@4us.org>
cc: "Brent D. Norris" <brent@biglinux.tccw.wku.edu>,
        James Sutherland <jas88@cam.ac.uk>, Pavel Machek <pavel@suse.cz>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 3com Driver and the 3XP Processor
In-Reply-To: <Pine.LNX.4.21.0106142312240.23731-100000@root.4us.org>
Message-ID: <Pine.LNX.4.21.0106141718380.16013-100000@ns>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So what is the truth to the rumors 3com was throwing around about the
"linux driver with ipsec support"?
	Nick

On Thu, 14 Jun 2001, Martin Moerman wrote:

> 
> 
> On Thu, 14 Jun 2001, Brent D. Norris wrote:
> 
> > > Now, if the NIC were to integrate with OpenSSL and offload some of THAT
> > > donkey work... Just offloading DES isn't terribly useful, as Pavel says:
> > > apart from anything else, DES is a bit elderly now - SSH using 3DES or
> > > Blowfish etc... How dedicated is this card? Could it be used to offload
> > > other work?
> > 
> > Sorry my bad it is 3DES that they have on it, but I don't know how
> > in-grained it is in it.  Like I sad it just floated across my desk a few
> > days ago and it sounded like a cool bit of hardware.
> 
> 
> The card is offloading TCP/IP checksums, TCP/IP packet fragmentation, and
> does IPSEC through the ARM9 proc.
> 
> I like the card. but no real real linux drivers yet. only basic network
> card drivers for linux.
> 
> /Martin
> martin_moerman@eur.3com.com
> 
> 
> 
> > 
> > Brent Norris
> > 
> > Executive Advisor -- WKU-Linux
> > 
> > System Administrator -- WKU-Center for Biodiversity
> >                         Best Mechanical
> > 
> > W: 270-745-8864
> > H: 270-563-9226
> > 
> > "The problem with the Linux learning curve is that it is _so_ steep once
> >  at the top you can't see the people at the bottom"  --Doug Hagan
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

