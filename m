Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129739AbQKQRAa>; Fri, 17 Nov 2000 12:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129877AbQKQRAM>; Fri, 17 Nov 2000 12:00:12 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38757 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129739AbQKQRAF>; Fri, 17 Nov 2000 12:00:05 -0500
Subject: Re: [PATCH] pcmcia event thread. (fwd)
To: torvalds@transmeta.com (Linus Torvalds)
Date: Fri, 17 Nov 2000 16:29:27 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), rmk@arm.linux.org.uk (Russell King),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        dwmw2@infradead.org (David Woodhouse),
        dhinds@valinux.com (David Hinds), tytso@valinux.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10011170819250.2272-100000@penguin.transmeta.com> from "Linus Torvalds" at Nov 17, 2000 08:21:31 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13woOG-0000qS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan, Russell is talking about CardBus controllers (it's also PCMCIA, in
> fact, these days it's the _only_ pcmcia in any machine made less than five
> years ago).

I have at least two machines here that are < 2 years old but disagree
with you. Once is only months old. 

> The patches to get i82365 and TCIC up and running again are interesting
> mainly for laptops with i486 CPUs and for desktops with pcmcia add-in
> cards (which are basically always ISA i82365-clones). They aren't
> interesting to ARM, I suspect.

Much ARM stuff has embedded PCMCIA controllers not cardbus, ditto most MIPS
WinCE hardware

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
