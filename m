Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269698AbRHQFQi>; Fri, 17 Aug 2001 01:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269726AbRHQFQ1>; Fri, 17 Aug 2001 01:16:27 -0400
Received: from elektroni.ee.tut.fi ([130.230.131.11]:45828 "HELO
	elektroni.ee.tut.fi") by vger.kernel.org with SMTP
	id <S269712AbRHQFQQ>; Fri, 17 Aug 2001 01:16:16 -0400
Date: Fri, 17 Aug 2001 08:16:29 +0300
From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
To: Tim Moore <timothymoore@bigfoot.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.20pre series and booting problem
Message-ID: <20010817081629.A3540@elektroni.ee.tut.fi>
Mail-Followup-To: Tim Moore <timothymoore@bigfoot.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010815172631.A17156@elektroni.ee.tut.fi> <3B7C58BB.6D67DD7A@bigfoot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B7C58BB.6D67DD7A@bigfoot.com>; from timothymoore@bigfoot.com on Thu, Aug 16, 2001 at 04:35:23PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2001 at 04:35:23PM -0700, Tim Moore wrote:
> Petri Kaukasoina wrote:
> > 
> > 2.2.20pre3 boots ok but pre5-pre9 do not:
> > 
> > Uncompressing Linux...
> > 
> > Out of memory
> > 
> >   -- System halted
> > 
> > I tried with gcc-2.7.2.3 + binutils-2.9.1.0.25 and with egcs-1.1.2 +
> > binutils-2.11.90.0.19. On a 486 with 48 M RAM and lilo 21.7-5 and on a
> > Pentium MMX with 64 M RAM and lilo 19.

> make bzimage?

Yes, both zImage and bzImage gave the same error. (I should have mentioned
that, sorry.)
