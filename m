Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129518AbQLUBNR>; Wed, 20 Dec 2000 20:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129601AbQLUBNH>; Wed, 20 Dec 2000 20:13:07 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:44299 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129518AbQLUBMx>; Wed, 20 Dec 2000 20:12:53 -0500
Subject: Re: iptables: "stateful inspection?"
To: rothwell@holly-springs.nc.us (Michael Rothwell)
Date: Thu, 21 Dec 2000 00:44:19 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        mhw@wittsend.com (Michael H. Warfield), linux-kernel@vger.kernel.org
In-Reply-To: <3A411BC2.1E302455@holly-springs.nc.us> from "Michael Rothwell" at Dec 20, 2000 03:51:14 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E148tqH-0002JQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan Cox wrote:
> > It does SYN checking. If you are running 'serious' security you wouldnt be
> > allowing outgoing connections anyway. One windows christmascard.exe virus that
> > connects back to an irc server to take input and you are hosed.
> 
> Thankfully, pine and mutt are, to date, immune to that kind of thing. :)

There have been at least five holes found in pile that _could_ have been
exploited, and even one in all xterms pre X11R6 where ascii+escape codes
was all you needed.
Mutt has had minor things fixed for security reasons too.

It's harder. But you ignore two things - once someone does it anyone can
repeat it - and more importantly almost all exploits rely on user error.
Linux users are not always brighter than windows ones and there isnt a lot
you can do to make them smarter

Think of computer security like powertools. The day you think you are totally
safe is the day you end up hurt.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
