Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131391AbRAWAQd>; Mon, 22 Jan 2001 19:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132826AbRAWAQY>; Mon, 22 Jan 2001 19:16:24 -0500
Received: from hibernia.clubi.ie ([212.17.32.129]:31104 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP
	id <S131391AbRAWAQO>; Mon, 22 Jan 2001 19:16:14 -0500
Date: Tue, 23 Jan 2001 00:15:26 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: <paul@fogarty.jakma.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, Rainer Mager <rmager@vgkk.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Is this kernel related (signal 11)?
In-Reply-To: <200101222147.f0MLlxe01758@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.31.0101230013520.15972-100000@fogarty.jakma.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jan 2001, Russell King wrote:

> Evidence: I recently had a bad 128MB SDRAM which *always* failed at byte
> address 0x220068,

and X is likely to be the biggest process by far on a box, so
statistically will be the process that hits this bad byte the most.
no?

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org
PGP5 key: http://www.clubi.ie/jakma/publickey.txt
-------------------------------------------
Fortune:
The bomb will never go off.  I speak as an expert in explosives.
		-- Admiral William Leahy, U.S. Atomic Bomb Project

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
