Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283734AbRK3RwV>; Fri, 30 Nov 2001 12:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283735AbRK3RwM>; Fri, 30 Nov 2001 12:52:12 -0500
Received: from [212.18.232.186] ([212.18.232.186]:23045 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S283734AbRK3Rv5>; Fri, 30 Nov 2001 12:51:57 -0500
Date: Fri, 30 Nov 2001 17:50:58 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: dalecki@evision.ag
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Henning Schmiedehausen <hps@intermeta.de>,
        Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Coding style - a non-issue
Message-ID: <20011130175058.B19193@flint.arm.linux.org.uk>
In-Reply-To: <OF8451D8AC.A8591425-ON4A256B12.00806245@au.ibm.com> <Pine.GSO.4.21.0111281901110.8609-100000@weyl.math.psu.edu> <20011128162317.B23210@work.bitmover.com> <9u7lb0$8t9$1@forge.intermeta.de> <20011130072634.E14710@work.bitmover.com> <1007138360.6656.27.camel@forge> <3C07B820.4108246F@mandrakesoft.com> <3C07BFE8.5B32C49C@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C07BFE8.5B32C49C@evision-ventures.com>; from dalecki@evision-ventures.com on Fri, Nov 30, 2001 at 06:20:40PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2001 at 06:20:40PM +0100, Martin Dalecki wrote:
> serial.c is another one for the whole multiport support which
> may be used by maybe 0.1% of the Linux users thrown on them all
> and some "magic" number silliness as well...

Magic number silliness is something that's gone with my replacement
serial drivers.  If multiport is such a problem, it can easily be
cleaned up.  I'll add that to my to do list for serial stuff.

Thanks.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

