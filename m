Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbQL3XcR>; Sat, 30 Dec 2000 18:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130643AbQL3Xb6>; Sat, 30 Dec 2000 18:31:58 -0500
Received: from cx518206-a.irvn1.occa.home.com ([24.21.107.122]:62461 "EHLO
	pobox.com") by vger.kernel.org with ESMTP id <S129431AbQL3Xbs>;
	Sat, 30 Dec 2000 18:31:48 -0500
From: "Barry K. Nathan" <barryn@pobox.com>
Message-Id: <200012302301.eBUN1IF01354@pobox.com>
Subject: NIC recommendations (was Re: Repeatable 2.4.0-test13-pre4...)
To: andrewm@uow.edu.au (Andrew Morton)
Date: Sat, 30 Dec 2000 15:01:18 -0800 (PST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A4DBC02.92C0FD9A@uow.edu.au> from "Andrew Morton" at Dec 30, 2000 09:42:10 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> The 3c905C is a well manufactured and very feature-rich NIC which at
> present appears to have fewer problem reports than eepro100, 8139 or tulip.

3c905c is a bit expensive, though. pcnet32 cards also work very well for
me, and are less expensive. The 905c could be a better card (I don't
really know), but pcnet32's might be more cost-effective, depending
on your needs. (I've seen pcnet32-based cards selling for $15-20, and
I bought a new 10-pack (of HP NightDirector 10/100's) for about $36,
including shipping, on eBay.)
 
In any case, tulips have been more problematic for me than 8139, pcnet32,
or 3c905c (whose reliability are all comparable IME). I've never tried
eepro100, though. (Also, I'm speaking in terms of my experiences across
all OS's which I've used the cards under, not just under Linux, although
my Linux experiences are similar to the experiences I've had overall.)

Anyway, those are my experiences and recommendations. YMMV. :)

-Barry K. Nathan <barryn@pobox.com>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
