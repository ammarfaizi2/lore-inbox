Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129137AbRBKRRH>; Sun, 11 Feb 2001 12:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129441AbRBKRQ6>; Sun, 11 Feb 2001 12:16:58 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:65292 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129137AbRBKRQs>; Sun, 11 Feb 2001 12:16:48 -0500
Subject: Re: Where are you going with 2.4.x?
To: akorud@polynet.lviv.ua
Date: Sun, 11 Feb 2001 17:17:26 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1394806431.20010211181744@polynet.lviv.ua> from "Andriy Korud" at Feb 11, 2001 06:17:44 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14S07t-0004Ty-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've installed 2.4.x there. Just immedualtely I've noticed performance
> improve, responce time improve.

That is good news

> BUT: All kernels prior to 2.1.4-ac8 hangs during first few hours of
> work on heavy disk (Mylex) activity.

Ok Im glad to know we have made some progress there

> 2.1.4-ac8 was the first kernel which was able to work nore then 24
> hours. But on 26'th our of work it crashed with:
> 
>        Kernel panic: Aiee:, killing interrupt handler!
>        In interrupt handler - not syncing

What is the oops data before the kernel panic. I need that to debug the
driver. Also did you build the DAC960 support with gcc 2.96-x x<74 ?
 
> Can I know your thoughts about target market of 2.4.x kernel? I assume
> that the goal is to make it feature-rich multimedia desktop system?

And a rock solid server and anything else people want it to be. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
