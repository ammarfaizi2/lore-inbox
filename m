Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130704AbQLIXbd>; Sat, 9 Dec 2000 18:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132241AbQLIXbX>; Sat, 9 Dec 2000 18:31:23 -0500
Received: from gw.lowendale.com.au ([203.26.242.120]:26410 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S130704AbQLIXbP>; Sat, 9 Dec 2000 18:31:15 -0500
Date: Sun, 10 Dec 2000 10:26:07 +1100 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Stephen Rothwell <sfr@linuxcare.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18pre21 oops reading /proc/apm
In-Reply-To: <E144O1a-0003vF-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.05.10012101021450.16389-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2000, Alan Cox wrote:

[...]
> Please boot 2.2.18pre24 (not pre25) on the machine and send me its DMI strings
> printed at boot time. I'll add it to the 'stupid morons who cant program and
> wouldnt know QA if it hit them on the head with a mallet' list

OK, I did this (at least I think I got it right: the patch was happy) but
I can't see anything resembling DMI strings (even after I removed
frame-buffer so as not to nuke the first few messages).  What keywords etc
should I be seeing, at what point?

the only vaguely relevant message I see is:

	apm: BIOS version 1.1 Flags 0x03 (Driver version 1.13)

Thanks,
Neale.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
