Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129450AbQLFNhv>; Wed, 6 Dec 2000 08:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129532AbQLFNhm>; Wed, 6 Dec 2000 08:37:42 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:21764 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S129450AbQLFNh2>;
	Wed, 6 Dec 2000 08:37:28 -0500
Date: Wed, 6 Dec 2000 14:06:52 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test12-pre6
In-Reply-To: <Pine.LNX.4.10.10012052318270.5786-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0012061334500.5492-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2000, Linus Torvalds wrote:
> Concering the PCI irq routing fixes in particular, I'd ask people with
> laptops to start testing their kernels with PnP OS set to "yes" in the
> BIOS setup. We shoul dbe at a stage where it should basically work all the
> time, and it would be interesting to hear about cases that we don't handle
> right.

It works fine here on a Mitac laptop (the one that needed a Win98
warm-boot a few weeks ago), but it is quite noisy about IRQs that are also
used for other devices. (PCI: The same IRQ used for device 00:08.0)

The way I see it, 2.4.0-test12-pre6 is just a much longer name for 2.4.0.  
Keep going like this and we may end up calling you Linus "Santa" Torvalds!  
It has a nice ring to it, don't you think?  :-)  Or should that be *-<:-)

/Tobias

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
