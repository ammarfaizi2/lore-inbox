Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130692AbQKQRUC>; Fri, 17 Nov 2000 12:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130688AbQKQRTw>; Fri, 17 Nov 2000 12:19:52 -0500
Received: from cerebus-ext.cygnus.co.uk ([194.130.39.252]:14831 "EHLO
	passion.cygnus") by vger.kernel.org with ESMTP id <S130640AbQKQRTm>;
	Fri, 17 Nov 2000 12:19:42 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.10.10011170843050.2272-100000@penguin.transmeta.com> 
In-Reply-To: <Pine.LNX.4.10.10011170843050.2272-100000@penguin.transmeta.com> 
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Russell King <rmk@arm.linux.org.uk>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, David Hinds <dhinds@valinux.com>,
        tytso@valinux.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia event thread. (fwd) 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 17 Nov 2000 16:49:28 +0000
Message-ID: <6533.974479768@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


torvalds@transmeta.com said:
>  It should be possible to do the same thing with a nice simple
> concentrated PCI probe, instead of having stuff quite as spread out as
> it used to be.

That's the plan.

>  As to why it doesn't show any ISA interrupts, who knows... Some of
> the PCI PCMCIA bridges need to be initialized.

ISTR it worked fine in an x86 box. I'll play with it over the weekend.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
