Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbRBORa1>; Thu, 15 Feb 2001 12:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129078AbRBORaS>; Thu, 15 Feb 2001 12:30:18 -0500
Received: from [64.242.80.3] ([64.242.80.3]:65287 "EHLO TTGCS.teamtoolz.net")
	by vger.kernel.org with ESMTP id <S129066AbRBORaL>;
	Thu, 15 Feb 2001 12:30:11 -0500
Message-ID: <85F1402515F13F498EE9FBBC5E07594220AD84@TTGCS.teamtoolz.net>
From: Matt Liotta <mliotta@teamtoolz.com>
To: linux-kernel@vger.kernel.org
Subject: RE: aic7xxx (and sym53c8xx) plans
Date: Thu, 15 Feb 2001 09:30:04 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am still stuck on 2.2 because of this issue. I would really like to see
this driver in 2.4.2.

-Matt

> -----Original Message-----
> From: Nathan Black [mailto:NBlack@md.aacisd.com]
> Sent: Thursday, February 15, 2001 9:20 AM
> To: linux-kernel@vger.kernel.org
> Subject: RE: aic7xxx (and sym53c8xx) plans
> 
> 
> 
> I must say, after I saw this post, I tried out the latest 
> driver for my own
> purposes. 
> 
> This really improved the performance of my dual PIII-866 
> w/512MB Ram and
> AIC7899 scsi.
> I have a couple of cheetah drives that I am writing data that 
> I get off of
> an ATM card.(about 12-14 MB/sec rate).
> 
> This has significantly lowered the number of dropped packets 
> on the ATM
> read. 
> 
> I would suggest, if at all possible, putting this in the 2.4.2 kernel.
> 
> Nathan
> 
> -----Original Message-----
> From: Chip Salzenberg [mailto:chip@valinux.com]
> Sent: Wednesday, February 14, 2001 9:20 PM
> To: Matthew Jacob
> Cc: Wakko Warner; Alan Cox; J . A . Magallon; linux-kernel
> Subject: Re: aic7xxx (and sym53c8xx) plans
> 
> 
> According to Matthew Jacob:
> > See http://www.freebsd.org/~gibbs/linux.
> 
> Here at VA we're already using Jason's driver -- it works on the Intel
> STL2 motherboard, while Doug's driver doesn't (or didn't, a 
> month ago).
> 
> While we're discussing SCSI drivers, I'd also like to put in a good
> word for the Sym-2 Symbios/NCR drivers from Gerard Roudier:
> 
>     ftp://ftp.tux.org/roudier/drivers/portable/sym-2.1.x/
> 
> Joe-Bob says: "Check it out."
> -- 
> Chip Salzenberg            - a.k.a. -            <chip@valinux.com>
>    "Give me immortality, or give me death!"  // Firesign Theatre
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
