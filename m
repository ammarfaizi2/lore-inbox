Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129532AbRABXO4>; Tue, 2 Jan 2001 18:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129557AbRABXOg>; Tue, 2 Jan 2001 18:14:36 -0500
Received: from anime.net ([63.172.78.150]:4365 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S129532AbRABXOa>;
	Tue, 2 Jan 2001 18:14:30 -0500
Date: Tue, 2 Jan 2001 14:42:39 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: David Woodhouse <dwmw2@infradead.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Hakan Lennestal <hakanl@cdt.luth.se>,
        Andre Hedrick <andre@linux-ide.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Chipsets, DVD-RAM, and timeouts.... 
In-Reply-To: <Pine.LNX.4.30.0101022222320.612-100000@imladris.demon.co.uk>
Message-ID: <Pine.LNX.4.30.0101021441290.15631-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jan 2001, David Woodhouse wrote:
> It's a combination of chipset and drive that causes the problems. I've
> been using ata66 with the same controller on a different drive
> (FUJITSU MPE3136AT) for some time now, and it's been rock solid. It's only
> the IBM DTLA drive that's been a problem on this controller.

Maxtor has problems with hpt366 also.

> Highpoint made changes in their 1.26¹ BIOS to correctly support the IBM
> DTLA drives. If we can get access to information about what they had to
> change, we ought to be able to get it to work on those drives reliably.

Too bad Maxtor is still broken with hpt366...

Also, using CDROM on hpt366 is recipe for disaster...

-Dan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
