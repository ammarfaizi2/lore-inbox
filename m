Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129130AbQKQUZS>; Fri, 17 Nov 2000 15:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129147AbQKQUZL>; Fri, 17 Nov 2000 15:25:11 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18191 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129130AbQKQUY4>;
	Fri, 17 Nov 2000 15:24:56 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011171953.TAA01877@raistlin.arm.linux.org.uk>
Subject: Re: VGA PCI IO port reservations
To: root@chaos.analogic.com
Date: Fri, 17 Nov 2000 19:52:59 +0000 (GMT)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik), linux-kernel@vger.kernel.org,
        mj@suse.cz
In-Reply-To: <Pine.LNX.3.95.1001117125211.20635A-100000@chaos.analogic.com> from "Richard B. Johnson" at Nov 17, 2000 01:06:30 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson writes:
> The code necessary to find the lowest unaliased address looks like
> this:

Any chance of providing something more readable?  I may be able to read
some x86 asm, but I don't have the time to try to decode that lot.
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
