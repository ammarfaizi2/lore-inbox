Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132002AbQKQLZp>; Fri, 17 Nov 2000 06:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132017AbQKQLZg>; Fri, 17 Nov 2000 06:25:36 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19034 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132002AbQKQLZZ>; Fri, 17 Nov 2000 06:25:25 -0500
Subject: Re: [PATCH] pcmcia event thread. (fwd)
To: rmk@arm.linux.org.uk (Russell King)
Date: Fri, 17 Nov 2000 10:54:38 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        dwmw2@infradead.org (David Woodhouse),
        dhinds@valinux.com (David Hinds), torvalds@transmeta.com,
        tytso@valinux.com, linux-kernel@vger.kernel.org
In-Reply-To: <200011170051.eAH0pvr18387@flint.arm.linux.org.uk> from "Russell King" at Nov 17, 2000 12:51:57 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13wjAF-0000Ur-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > regardless of what you are doing' since the modules from David Hinds and Linus
> > pcmcia are not 100% binary compatible for all cases.
> 
> However, deleting that code would render a significant number of ARM platforms
> without PCMCIA support, which would be real bad.

It would actually have made no difference as said code didnt actually work
anyway. Dwmw2 seems to have solved that

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
