Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129736AbQKQRGW>; Fri, 17 Nov 2000 12:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129412AbQKQRGF>; Fri, 17 Nov 2000 12:06:05 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:48393 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129736AbQKQRFq>; Fri, 17 Nov 2000 12:05:46 -0500
Date: Fri, 17 Nov 2000 08:35:29 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Russell King <rmk@arm.linux.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        David Woodhouse <dwmw2@infradead.org>,
        David Hinds <dhinds@valinux.com>, tytso@valinux.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia event thread. (fwd)
In-Reply-To: <E13woOG-0000qS-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10011170832510.2272-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 17 Nov 2000, Alan Cox wrote:

> > Alan, Russell is talking about CardBus controllers (it's also PCMCIA, in
> > fact, these days it's the _only_ pcmcia in any machine made less than five
> > years ago).
> 
> I have at least two machines here that are < 2 years old but disagree
> with you. Once is only months old. 

Who makes those pieces of crap? And who _buys_ them? I can understand it
in embedded stuff simply because the chips are simpler and smaller, but in
a laptop you should definitely try to avoid it.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
