Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <971543-26836>; Sat, 11 Jul 1998 20:21:31 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1252 "EHLO chaos.analogic.com" ident: "SOCKWRITE-65") by vger.rutgers.edu with ESMTP id <971540-26836>; Sat, 11 Jul 1998 20:21:10 -0400
Date: Sat, 11 Jul 1998 21:29:40 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: linux-kernel@vger.rutgers.edu
Subject: Re: Future time
In-Reply-To: <6o6htg$huh$1@palladium.transmeta.com>
Message-ID: <Pine.LNX.3.95.980711212747.1544A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

On 11 Jul 1998, H. Peter Anvin wrote:

> Followup to:  <Pine.GSO.3.96.980711034638.18184A-100000@delta.ds2.pg.gda.pl>
> By author:    "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
> In newsgroup: linux.dev.kernel
> > 
> > > Then, the SMP machines don't use these controllers at all unless the APIC
> > > is broken.
> > 
> >  But not all ia32 machines are SMP and these which are not have usually
> > the onchip APIC either absent or disabled.  Unfortunately...
> > 
> 
> Actually, the thing to use is the cycle counter if the CPU clock is
> anywhere near stable.
> 
> 	-hpa
But that's the point! In the near future, CPU clocks will only be stable
to about 2 percent because the next cost-cutting 'comsumerish' thingy
will be to replace quartz crystals with ceramic resonators.


Cheers,
Dick Johnson
                  ***** FILE SYSTEM MODIFIED *****
Penguin : Linux version 2.1.108 on an i586 machine (66.15 BogoMips).
Warning : It's hard to remain at the trailing edge of technology.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.altern.org/andrebalsa/doc/lkml-faq.html
