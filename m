Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129467AbQKFRVE>; Mon, 6 Nov 2000 12:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129666AbQKFRUy>; Mon, 6 Nov 2000 12:20:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25940 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129467AbQKFRUi>; Mon, 6 Nov 2000 12:20:38 -0500
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Mon, 6 Nov 2000 17:19:29 +0000 (GMT)
Cc: dwmw2@infradead.org (David Woodhouse),
        jgarzik@mandrakesoft.com (Jeff Garzik), goemon@anime.net (Dan Hollis),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        oxymoron@waste.org (Oliver Xymoron), kaos@ocs.com.au (Keith Owens),
        linux-kernel@vger.kernel.org
In-Reply-To: <3A06CB18.570BB38A@evision-ventures.com> from "Martin Dalecki" at Nov 06, 2000 04:15:36 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13spve-0006Pt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Persistent storage is the best way to do it though. It doesn't have to be
> > persistent over reboots, just during the lifetime of the kernel.
> 
> No! The best way to do it are just *persistently loaded* modules.
> It's THAT simple!

So you want to split every sound driver into two or more modules ? 

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
