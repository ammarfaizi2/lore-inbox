Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264597AbRFPJM5>; Sat, 16 Jun 2001 05:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264598AbRFPJMh>; Sat, 16 Jun 2001 05:12:37 -0400
Received: from pd1aje.xs4all.nl ([213.84.90.153]:38152 "EHLO root.4us.org")
	by vger.kernel.org with ESMTP id <S264597AbRFPJM0>;
	Sat, 16 Jun 2001 05:12:26 -0400
Date: Sat, 16 Jun 2001 11:12:15 +0200 (MEST)
From: Martin Moerman <linuxham@4us.org>
To: Pekka Pietikainen <pp@evil.netppl.fi>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 3com Driver and the 3XP Processor
In-Reply-To: <20010615185235.A29313@netppl.fi>
Message-ID: <Pine.LNX.4.21.0106161110420.5331-100000@root.4us.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Jun 2001, Pekka Pietikainen wrote:

> On Fri, Jun 15, 2001 at 08:37:15AM -0700, David S. Miller wrote:
> > 
> > Pete Wyckoff writes:
> >  > We're currently working on using both processors
> >  > of the Tigon in parallel.
> > 
> > It is my understanding that on the Tigon2, the second processor is
> > only for working around hw bugs in the DMA controller of the board and
> > cannot be used for other tasks.
> > 
> > WRT. tigon3, it was mentioned on this list that it is a pair of arm9
> > cpus, one for rx and one for tx.
> > 
> Might be worth asking broadcom instead of 3com for the specs, 
> as they seem to be selling it as a chip (BCM5700/5701), whereas 3com sells a
> board (3c996).
> 

Guys,

To make it easier, Tell me exactly what you need in documentation and I
will try to get it for you. 

Martin Moerman
martin_moerman@eur.3com.com




> -- 
> Pekka Pietikainen
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

