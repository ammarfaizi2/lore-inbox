Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290156AbSBFQWT>; Wed, 6 Feb 2002 11:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289363AbSBFQWJ>; Wed, 6 Feb 2002 11:22:09 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:63236 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S289240AbSBFQV7>; Wed, 6 Feb 2002 11:21:59 -0500
Date: Wed, 6 Feb 2002 11:20:50 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Cliff Albert <cliff@oisec.net>
cc: Wojtek Pilorz <wpilorz@bdk.pl>, linux-kernel@vger.kernel.org
Subject: Re: 512 Mb DIMM not detected by the BIOS!
In-Reply-To: <20020205065942.GA2141@oisec.net>
Message-ID: <Pine.LNX.3.96.1020206111649.7298C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Feb 2002, Cliff Albert wrote:

> On Mon, Feb 04, 2002 at 12:17:10PM +0100, Wojtek Pilorz wrote:

> > > Since it's a chipset (ie hardware) issue, it's not possible to work
> > > around this problem - you need a newer chipset. Sorry.
> > Or maybe another DIMM type - at least I was able to successfully use 256MB
> > DIMMs of appropriate type.
> 
> Double Sided 256MB Dimms are required, single sided dimms rarely work on
> BX-based boards.

  I have to agree that requiring the correct part for memory is not
usually considered a "hardware issue" as most people see it.

  I believe the VIA chipsets have similar features, the last m/b I
installed said it supported 4 DIMMs, up to 3GB. So a 1GB part will work,
but if you put in four only three operate (I didn't have four to try).

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

