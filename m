Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130263AbQKHIdL>; Wed, 8 Nov 2000 03:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130219AbQKHIdB>; Wed, 8 Nov 2000 03:33:01 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2567 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129512AbQKHIcq>;
	Wed, 8 Nov 2000 03:32:46 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011080812.eA88Ccl01753@flint.arm.linux.org.uk>
Subject: Re: [RANT] Linux-IrDA status
To: jt@hpl.hp.com
Date: Wed, 8 Nov 2000 08:12:38 +0000 (GMT)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik),
        linux-kernel@vger.kernel.org (Linux kernel mailing list),
        dagb@fast.no (Dag Brattli)
In-Reply-To: <20001107173809.A24129@bougret.hpl.hp.com> from "Jean Tourrilhes" at Nov 07, 2000 05:38:09 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes writes:
> 	If you can break up stuff that has accumulated over one year,
> please tell me so. Most of the original patches have been lost in the
> mist of time. We could send it file by file, but that would give some
> interesting results ;-)

<rant mode=on>
That doesn't work either ;(  Some of Dag's patches were from me, and I
have even tried sending Linus small self-contained obviously correct patches
for IrDA, but they just don't go in, and, dispite me asking several times
for an explaination why they are not, I've never received an answer.

Its almost although Linus is no longer interested in kernel support for IrDA.
I really don't know why Linus doesn't drop the whole IrDA stuff out of the
kernel if he's not willing to let people maintain it.

The latest changes to the initcall stuff in 2.4.0-test10 *did* affect IrDA,
but now every IrDA patch out there to get it working requires fixing up.

Linus, can we PLEASE have an explaination as to what is going on with IrDA?
<rant mode=off>
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
