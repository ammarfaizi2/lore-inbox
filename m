Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbQKDUgQ>; Sat, 4 Nov 2000 15:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129093AbQKDUgH>; Sat, 4 Nov 2000 15:36:07 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22020 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129057AbQKDUgA>;
	Sat, 4 Nov 2000 15:36:00 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011042034.eA4KYdN01000@flint.arm.linux.org.uk>
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10)
To: kaos@ocs.com.au (Keith Owens)
Date: Sat, 4 Nov 2000 20:34:38 +0000 (GMT)
Cc: tytso@mit.edu, linux-kernel@vger.kernel.org
In-Reply-To: <6647.973334586@ocs3.ocs-net> from "Keith Owens" at Nov 04, 2000 09:43:06 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens writes:
> Move this to "in progress" and add MTD code breaks with
> CONFIG_MODVERSIONS, for the same reason.  I wrote a patch to replace
> get_module_symbol a week ago and sent it to the DRM/AGP/MTD people for
> testing - no response yet.

<aol>
I have a fix likewise for the MTD code, so it builds without CONFIG_MODULES
</aol>
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
