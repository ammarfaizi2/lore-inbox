Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283728AbRK3R7l>; Fri, 30 Nov 2001 12:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283736AbRK3R7b>; Fri, 30 Nov 2001 12:59:31 -0500
Received: from [195.63.194.11] ([195.63.194.11]:6406 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S283728AbRK3R7V>;
	Fri, 30 Nov 2001 12:59:21 -0500
Message-ID: <3C07C68D.67D60384@evision-ventures.com>
Date: Fri, 30 Nov 2001 18:49:01 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: dalecki@evision.ag, Jeff Garzik <jgarzik@mandrakesoft.com>,
        Henning Schmiedehausen <hps@intermeta.de>,
        Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Coding style - a non-issue
In-Reply-To: <OF8451D8AC.A8591425-ON4A256B12.00806245@au.ibm.com> <Pine.GSO.4.21.0111281901110.8609-100000@weyl.math.psu.edu> <20011128162317.B23210@work.bitmover.com> <9u7lb0$8t9$1@forge.intermeta.de> <20011130072634.E14710@work.bitmover.com> <1007138360.6656.27.camel@forge> <3C07B820.4108246F@mandrakesoft.com> <3C07BFE8.5B32C49C@evision-ventures.com> <20011130175058.B19193@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> On Fri, Nov 30, 2001 at 06:20:40PM +0100, Martin Dalecki wrote:
> > serial.c is another one for the whole multiport support which
> > may be used by maybe 0.1% of the Linux users thrown on them all
> > and some "magic" number silliness as well...
> 
> Magic number silliness is something that's gone with my replacement
> serial drivers.  If multiport is such a problem, it can easily be
> cleaned up.  I'll add that to my to do list for serial stuff.

Well sombeody really cares apparently! Thank's. Any pointers
where to ahve a look at it? BTW> Did you consider ther misc device
idea? (Hooking serial at to the misc device stuff).
