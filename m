Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRAJWaZ>; Wed, 10 Jan 2001 17:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132941AbRAJWaJ>; Wed, 10 Jan 2001 17:30:09 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:62982 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S132606AbRAJW34>;
	Wed, 10 Jan 2001 17:29:56 -0500
Date: Wed, 10 Jan 2001 23:29:46 +0100
From: Frank de Lange <frank@unternet.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware related?
Message-ID: <20010110232946.B20535@unternet.org>
In-Reply-To: <20010110223015.B18085@unternet.org> <3A5CE07D.BD36D71C@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5CE07D.BD36D71C@colorfullife.com>; from manfred@colorfullife.com on Wed, Jan 10, 2001 at 11:21:49PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2001 at 11:21:49PM +0100, Manfred Spraul wrote:
> Which driver do you use? The driver in 2.4.0 contains several bugfixes.
> If that driver still hangs then I'll double check the documentation.

The NE2K PCI one... I'll try to fiddle around with the driver, who knows...

> And the documentation begins with
> W89C840F
> 	PCI Bus Master Fast Ethernet LAN Controller.

That is the 'F' (Fast) version. My cards are just plain and simple 10base2/T,
humble and non-busmastering (AFAIK).

Cheers//Frank


-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
