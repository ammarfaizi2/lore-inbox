Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129868AbRAQHl6>; Wed, 17 Jan 2001 02:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131103AbRAQHlt>; Wed, 17 Jan 2001 02:41:49 -0500
Received: from zeus.kernel.org ([209.10.41.242]:34792 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129868AbRAQHli>;
	Wed, 17 Jan 2001 02:41:38 -0500
Date: Wed, 17 Jan 2001 00:33:09 +0100 (MET)
From: Matthias Schniedermeyer <ms@citd.de>
To: linux-kernel@vger.kernel.org
Subject: Mainboard with Serverworks HE Chipset
Message-ID: <Pine.LNX.4.20.0101170020001.811-100000@citd.owl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#include <hallo.h>



I got a "Tyan Thunder HE-SL"-Mainboard today, which has a "Severworks
ServerSet III HE"-Chipset. (2xPIII 933, 2x512MB PC133 ECC-Registered
SDRAM)

And i have one problem and one question.

First the question. I have an uptime of phenomenal 29minutes and "cat
/proc/interrupts" tells me this

NMI:     175819     175819
LOC:     175829     175828

Should i be worried? Or can i ignore it. With my former Mainboard NMI was
(AFAIR) always 0.

Now my problem.

The Graphic-Card is a Geforce 2, Xfree is 4.02 (compiled under 2.2.17).

When i start X, everything is fine. When i go back to text-console and
wait "some time" and then switch back to X the computer locks solid and i
have to press the Big-Red Button. (Switching back to X after a "short"
periode of time, at the text-console, works "normaly")

If anyone needs more information, i will happily provide them.




Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
