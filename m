Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262842AbRE3WE3>; Wed, 30 May 2001 18:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262831AbRE3WET>; Wed, 30 May 2001 18:04:19 -0400
Received: from alcove.wittsend.com ([130.205.0.20]:48514 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S262828AbRE3WEE>; Wed, 30 May 2001 18:04:04 -0400
Date: Wed, 30 May 2001 18:03:44 -0400
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Harald Welte <laforge@gnumonks.org>
Cc: Fabbione <fabbione@fabbione.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OFF-TOPIC] 4 ports ETH cards
Message-ID: <20010530180344.A5304@alcove.wittsend.com>
Mail-Followup-To: Harald Welte <laforge@gnumonks.org>,
	Fabbione <fabbione@fabbione.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3B135549.19CF8965@fabbione.net> <20010530183416.P14293@corellia.laforge.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.2i
In-Reply-To: <20010530183416.P14293@corellia.laforge.distro.conectiva>; from laforge@gnumonks.org on Wed, May 30, 2001 at 06:34:16PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2001 at 06:34:16PM -0300, Harald Welte wrote:
> On Tue, May 29, 2001 at 09:52:41AM +0200, Fabbione wrote:
> > Hi all,
> > 	sorry for the offtopic msg.
> > 
> > Can someone point me to a 4 ports fast/eth card solution for linux?

> D-Link DFE-570 has a reasonable pricing and is well supported by the 
> tulip driver

	Just got three of these suckers and I'm about to order a bunch
more (happy camper)...

> > I found some cards based on the DEC 21*4* chips but when
> > I asked for more details I got a strange answer from the reseller
> > like that this card is able to work only half-duplex and the chip has
> > only one mac-address for the 4 eth cards (really strange).

> nah. And even if so, you can always change the mac-address using ifconfig.

	Each D-Link card has four MAC addresses (sequential).  I doubt
other manufactures are any different.

> What the guy most likely wanted to say, is that there is only one EEprom
> containing all mac adresses for the four tulip chips, which I have seen
> on multiple boards

	What the guy was doing was having a bad case of optical rectitus.
That would be typical of a "reseller" (AKA Salesman).  Most would not
even have a CLUE that the cards were based on the tulip chipset / driver.

	Because the D-Link cards were less than half of the nearest
competitor [ < $180 vs > $360 for others and Compac was > $2400! ] I
ordered only three not knowing for sure if they would work.  Turned on
the tulip driver and them suckers fired right up.  Now I know they work,
stock, right out of the box, and I can order a bunch more for the lab
I'm working with.

> > Thanks a lot
> > Fabbione
> 
> -- 
> Live long and prosper
> - Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

