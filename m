Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283720AbRK3RbB>; Fri, 30 Nov 2001 12:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283718AbRK3Rav>; Fri, 30 Nov 2001 12:30:51 -0500
Received: from [195.63.194.11] ([195.63.194.11]:35333 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S283735AbRK3Raj>; Fri, 30 Nov 2001 12:30:39 -0500
Message-ID: <3C07BFE8.5B32C49C@evision-ventures.com>
Date: Fri, 30 Nov 2001 18:20:40 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Henning Schmiedehausen <hps@intermeta.de>, Larry McVoy <lm@bitmover.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Coding style - a non-issue
In-Reply-To: <OF8451D8AC.A8591425-ON4A256B12.00806245@au.ibm.com>
			<Pine.GSO.4.21.0111281901110.8609-100000@weyl.math.psu.edu>
			<20011128162317.B23210@work.bitmover.com> <9u7lb0$8t9$1@forge.intermeta.de>
			 <20011130072634.E14710@work.bitmover.com> <1007138360.6656.27.camel@forge> <3C07B820.4108246F@mandrakesoft.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> The security community has shown us time and again that public shaming
> is often the only way to motivate vendors into fixing security
> problems.  Yes, even BSD security guys do this :)
> 
> A "Top 10 ugliest Linux kernel drivers" list would probably provide
> similar motivation.

Yehh.... However some of the uglinesses results from ignorance
on behalf of the overall kernel maintainers, who don't care
to apply "cosmetic" changes to drivers, just to don't
irritate the oftes so called "maintainer". Two expierences:
ftape and mcd I'm through.... 

BTW.> ftape (for the pascal emulation) and DAC960 
(for the silly ICantReadThisCasing) 
are my personal "top ranks" in regard
of the contest for the most ugly code in the kernel...
serial.c is another one for the whole multiport support which
may be used by maybe 0.1% of the Linux users thrown on them all
and some "magic" number silliness as well...
