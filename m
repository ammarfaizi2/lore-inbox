Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129208AbQKQUaJ>; Fri, 17 Nov 2000 15:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129147AbQKQU37>; Fri, 17 Nov 2000 15:29:59 -0500
Received: from chaos.analogic.com ([204.178.40.224]:6273 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129208AbQKQU3o>; Fri, 17 Nov 2000 15:29:44 -0500
Date: Fri, 17 Nov 2000 14:59:04 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Russell King <rmk@arm.linux.org.uk>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        mj@suse.cz
Subject: Re: VGA PCI IO port reservations
In-Reply-To: <200011171953.TAA01877@raistlin.arm.linux.org.uk>
Message-ID: <Pine.LNX.3.95.1001117145621.23447A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2000, Russell King wrote:

> Richard B. Johnson writes:
> > The code necessary to find the lowest unaliased address looks like
> > this:
> 
> Any chance of providing something more readable?  I may be able to read
> some x86 asm, but I don't have the time to try to decode that lot.

It's Intel assembly on Intel machines. It's a hell of a lot more
readable than AT&T assembly. This stuff has to be set up before you
have any resources necessary to execute the output of a 'C' compiler,
so, if you are looking for 'C' syntax, you are out of luck.


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
