Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271473AbRHTR2l>; Mon, 20 Aug 2001 13:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271478AbRHTR2b>; Mon, 20 Aug 2001 13:28:31 -0400
Received: from cp26357-a.gelen1.lb.nl.home.com ([213.51.0.86]:2692 "HELO
	lunchbox.oisec.net") by vger.kernel.org with SMTP
	id <S271473AbRHTR2U>; Mon, 20 Aug 2001 13:28:20 -0400
Date: Mon, 20 Aug 2001 19:28:27 +0200
From: Cliff Albert <cliff@oisec.net>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: aic7xxx errors with 2.4.8-ac7 on 440gx mobo
Message-ID: <20010820192827.A26693@oisec.net>
In-Reply-To: <20010820182138.C26054@oisec.net> <200108201723.TAA01855@nbd.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200108201723.TAA01855@nbd.it.uc3m.es>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2001 at 07:23:31PM +0200, Peter T. Breuer wrote:

> "Cliff Albert wrote:"
> > On Mon, Aug 20, 2001 at 11:37:33AM +0100, Alan Cox wrote:
> > > There is a known BIOS irq routing table problem with a large number of Intel
> > > BIOS boards with onboard adaptec controllers. The fact that making it use
> > > the io-apic works suggest this is the same thing.
> > 
> > It's an ASUS P2B-S board with a Award Bios, flashed to the latest revision that
> > is available from ASUS
> 
> I have exactly the same machine somewhere (will search, later) with onboard scsi.
> I believe it's currently running 2.4.3 with apic enabled with only occasional
> (weekly) troubles.
> 
> I'll see if I can dig it out and test it.

Troubles are infrequent also here, usually i get the errors at boot, now with the
aic7xxx driver in 2.4.8-ac7 with aic7xxx=verbose i still haven't got them but i
also get the errors sometimes after a hour of 8 / 9 of uptime, as the box is 
around this uptime at the moment, i'll probably be expecting some errors very soon

-- 
Cliff Albert		| RIPE:	     CA3348-RIPE | www.oisec.net
cliff@oisec.net		| 6BONE:     CA2-6BONE	 | icq 18461740
