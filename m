Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129187AbQKQVCO>; Fri, 17 Nov 2000 16:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129458AbQKQVCF>; Fri, 17 Nov 2000 16:02:05 -0500
Received: from cx518206-b.irvn1.occa.home.com ([24.21.107.123]:31492 "EHLO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with ESMTP
	id <S129187AbQKQVB4>; Fri, 17 Nov 2000 16:01:56 -0500
From: "Barry K. Nathan" <barryn@cx518206-b.irvn1.occa.home.com>
Message-Id: <200011172030.MAA01854@cx518206-b.irvn1.occa.home.com>
Subject: 2.4's internal PCMCIA works for me (was Re: [PATCH] pcmcia event thread)
To: torvalds@transmeta.com (Linus Torvalds)
Date: Fri, 17 Nov 2000 12:30:38 -0800 (PST)
Cc: rmk@arm.linux.org.uk (Russell King), alan@lxorguk.ukuu.org.uk (Alan Cox),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        dwmw2@infradead.org (David Woodhouse),
        dhinds@valinux.com (David Hinds), tytso@valinux.com,
        linux-kernel@vger.kernel.org
Reply-To: barryn@pobox.com
In-Reply-To: <Pine.LNX.4.10.10011170814440.2272-100000@penguin.transmeta.com> from "Linus Torvalds" at Nov 17, 2000 08:17:14 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> Right now, I suspect that the in-kernel pcmcia code is actually at the
> point where it _is_ possible to use it. David Hinds has been keeping the
> cs layer in synch with the external versions, and tons of people have
> helped make the low-level drivers stable again.
> 
> If somebody still has a problem with the in-kernel stuff, speak up. 

I'm going to speak up as someone who uses the in-kernel code without
problems (on my Dell Inspiron 5000e and Dell/3Com CardBus 10/100 NIC).
The in-kernel support always seems to get a bad rap, so I want to mention
that, for some people anyway, the in-kernel code works just as well as
the external code.

I do understand that the in-kernel support isn't as mature as the external
support yet. However, it isn't universally broken and useless either.

-Barry K. Nathan <barryn@pobox.com>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
