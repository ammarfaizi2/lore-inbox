Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbRAEXz5>; Fri, 5 Jan 2001 18:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129777AbRAEXzr>; Fri, 5 Jan 2001 18:55:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8719 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129387AbRAEXzj>;
	Fri, 5 Jan 2001 18:55:39 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200101052356.f05NumX17925@flint.arm.linux.org.uk>
Subject: Re: port of linux to Intel IXP1200
To: fryman@cc.gatech.edu (Josh Fryman)
Date: Fri, 5 Jan 2001 23:56:47 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A565BA5.E04635EE@cc.gatech.edu> from "Josh Fryman" at Jan 05, 2001 06:41:25 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Fryman writes:
> does anyone out there know if linux has been successfully ported to the Intel
> IXP1200 programmable network processor?  it's got an SA-1 core with lots of
> frills, and there have been rumors of a linux port, but i can't find anything
> through normal channels.

Yes there is.  Look at:

http://www.netwinder.org/~urnaik/ixp1200_howto.html

for more information on getting Linux running.
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
