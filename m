Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131368AbQKQJqz>; Fri, 17 Nov 2000 04:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131529AbQKQJqq>; Fri, 17 Nov 2000 04:46:46 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60687 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S131368AbQKQJqa>;
	Fri, 17 Nov 2000 04:46:30 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011170051.eAH0pvr18387@flint.arm.linux.org.uk>
Subject: Re: [PATCH] pcmcia event thread. (fwd)
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 17 Nov 2000 00:51:57 +0000 (GMT)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik),
        dwmw2@infradead.org (David Woodhouse),
        dhinds@valinux.com (David Hinds), torvalds@transmeta.com,
        tytso@valinux.com, linux-kernel@vger.kernel.org
In-Reply-To: <E13wRag-0007ym-00@the-village.bc.nu> from "Alan Cox" at Nov 16, 2000 04:08:43 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> >From a practical point of view that currently means 'delete Linus tree pcmcia
> regardless of what you are doing' since the modules from David Hinds and Linus
> pcmcia are not 100% binary compatible for all cases.

However, deleting that code would render a significant number of ARM platforms
without PCMCIA support, which would be real bad.
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
