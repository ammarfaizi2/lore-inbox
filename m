Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129458AbQKQVCo>; Fri, 17 Nov 2000 16:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129439AbQKQVCh>; Fri, 17 Nov 2000 16:02:37 -0500
Received: from chaos.analogic.com ([204.178.40.224]:10369 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129458AbQKQVC0>; Fri, 17 Nov 2000 16:02:26 -0500
Date: Fri, 17 Nov 2000 15:31:44 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: VGA PCI IO port reservations
In-Reply-To: <8v43i1$sjs$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.3.95.1001117152937.23529B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Nov 2000, H. Peter Anvin wrote:

> Followup to:  <200011171953.TAA01877@raistlin.arm.linux.org.uk>
> By author:    Russell King <rmk@arm.linux.org.uk>
> In newsgroup: linux.dev.kernel
> >
> > Richard B. Johnson writes:
> > > The code necessary to find the lowest unaliased address looks like
> > > this:
> > 
> > Any chance of providing something more readable?  I may be able to read
> > some x86 asm, but I don't have the time to try to decode that lot.
> > 
> 
> Ignore this code.  It's bullshit -- you can't just go and poke random
> boards -- even with IN's -- indiscriminately.  As usual, Richard is
> writing long lectures on subjects he is seriously mistaken about (and
> probably will send me yet another email trying to browbeat me into not
> calling him on all his errors.)

It's not bullshit, and as usual, you will never learn.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
