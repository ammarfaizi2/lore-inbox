Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262855AbRE3WXb>; Wed, 30 May 2001 18:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262859AbRE3WXU>; Wed, 30 May 2001 18:23:20 -0400
Received: from intranet.resilience.com ([209.245.157.33]:5558 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S262855AbRE3WXJ>; Wed, 30 May 2001 18:23:09 -0400
Message-ID: <3B15735E.5781700F@resilience.com>
Date: Wed, 30 May 2001 15:25:34 -0700
From: Jeff Golds <jgolds@resilience.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Michael H. Warfield" <mhw@wittsend.com>
CC: Harald Welte <laforge@gnumonks.org>, Fabbione <fabbione@fabbione.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OFF-TOPIC] 4 ports ETH cards
In-Reply-To: <3B135549.19CF8965@fabbione.net> <20010530183416.P14293@corellia.laforge.distro.conectiva> <20010530180344.A5304@alcove.wittsend.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael H. Warfield" wrote:
> 
> On Wed, May 30, 2001 at 06:34:16PM -0300, Harald Welte wrote:
> > On Tue, May 29, 2001 at 09:52:41AM +0200, Fabbione wrote:
> > > Hi all,
> > >     sorry for the offtopic msg.
> > >
> > > Can someone point me to a 4 ports fast/eth card solution for linux?
> 
> > D-Link DFE-570 has a reasonable pricing and is well supported by the
> > tulip driver
> 
>         Just got three of these suckers and I'm about to order a bunch
> more (happy camper)...
> 
> > > I found some cards based on the DEC 21*4* chips but when
> > > I asked for more details I got a strange answer from the reseller
> > > like that this card is able to work only half-duplex and the chip has
> > > only one mac-address for the 4 eth cards (really strange).
> 
> > nah. And even if so, you can always change the mac-address using ifconfig.
> 
>         Each D-Link card has four MAC addresses (sequential).  I doubt
> other manufactures are any different.
> 
> > What the guy most likely wanted to say, is that there is only one EEprom
> > containing all mac adresses for the four tulip chips, which I have seen
> > on multiple boards
> 
>         What the guy was doing was having a bad case of optical rectitus.
> That would be typical of a "reseller" (AKA Salesman).  Most would not
> even have a CLUE that the cards were based on the tulip chipset / driver.
> 
>         Because the D-Link cards were less than half of the nearest
> competitor [ < $180 vs > $360 for others and Compac was > $2400! ] I
> ordered only three not knowing for sure if they would work.  Turned on
> the tulip driver and them suckers fired right up.  Now I know they work,
> stock, right out of the box, and I can order a bunch more for the lab
> I'm working with.
> 

I've been working with these boards for a couple months and thought they
were great.  However, now it turns out that they won't fit into our
systems too well (a little too long).  Does anyone have knowledge of
another brand that has a (slightly) smaller form factor?  I did some
checking on Pricewatch but wasn't able to find anything that fit our
needs.

TIA,

-Jeff

-- 
Jeff Golds
jgolds@resilience.com
