Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283726AbRK3RpV>; Fri, 30 Nov 2001 12:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283724AbRK3RpL>; Fri, 30 Nov 2001 12:45:11 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21266 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S283726AbRK3Ro6>; Fri, 30 Nov 2001 12:44:58 -0500
Subject: Re: Coding style - a non-issue
To: dalecki@evision.ag
Date: Fri, 30 Nov 2001 17:53:13 +0000 (GMT)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik),
        hps@intermeta.de (Henning Schmiedehausen),
        lm@bitmover.com (Larry McVoy), linux-kernel@vger.kernel.org
In-Reply-To: <3C07BFE8.5B32C49C@evision-ventures.com> from "Martin Dalecki" at Nov 30, 2001 06:20:40 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E169rqb-0004G7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> irritate the oftes so called "maintainer". Two expierences:
> ftape and mcd I'm through.... 

I timed the mcd maintainer out and tidied it anyway. I figured since it
wasnt being maintained nobody would scream too loudly - nobody has

> BTW.> ftape (for the pascal emulation) and DAC960 

ftape is an awkward one. Really the newer ftape4 wants merging into the
kernel but that should have happened a long time ago

> serial.c is another one for the whole multiport support which
> may be used by maybe 0.1% of the Linux users thrown on them all
> and some "magic" number silliness as well...

serial.c is a good example of the "ugly" that actually matters more, as is
floppy.c. Clean well formatted code that is stil opaque. 
