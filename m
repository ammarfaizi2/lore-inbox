Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129097AbQKWU5l>; Thu, 23 Nov 2000 15:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129210AbQKWU5W>; Thu, 23 Nov 2000 15:57:22 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57351 "EHLO
        www.linux.org.uk") by vger.kernel.org with ESMTP id <S129097AbQKWU5M>;
        Thu, 23 Nov 2000 15:57:12 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011231946.TAA00397@raistlin.arm.linux.org.uk>
Subject: Re: silly [< >] and other excess
To: acahalan@cs.uml.edu (Albert D. Cahalan)
Date: Thu, 23 Nov 2000 19:46:36 +0000 (GMT)
Cc: kaos@ocs.com.au (Keith Owens), acahalan@cs.uml.edu (Albert D. Cahalan),
        Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
In-Reply-To: <200011231239.eANCd1S199359@saturn.cs.uml.edu> from "Albert D. Cahalan" at Nov 23, 2000 07:39:00 AM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert D. Cahalan writes:
> Also, cross-arch debugging is done by people who don't need tools
> like ksymoops anyway. Most likely they have half the opcodes
> memorized already, and they have the CPU manual open on their desk.

I certainly don't have each of the 4 billion opcode combinations on
the ARM memorised, and I've been hacking ARM code for over 12 years
now.

> I threw together a semi-working prototype in a few hours.
> It is the worst code I ever wrote in my life, not even
> excluding stuff I wrote in Atari BASIC. It slurps down log
> files pretty well though, and proves "[<>]" is unneeded.

Oh, how have you proven it?  Have you proven it with that ARM oops
that appeared on this list?  How do you know that it has produced
the right output for the developers?
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
