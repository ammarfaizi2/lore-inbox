Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266234AbUA2RJz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 12:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266252AbUA2RJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 12:09:55 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:9859 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S266234AbUA2RJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 12:09:53 -0500
Date: Thu, 29 Jan 2004 17:18:42 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200401291718.i0THIgbb001691@81-2-122-30.bradfords.org.uk>
To: Timothy Miller <miller@techsource.com>
Cc: chakkerz@optusnet.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <40193A67.7080308@techsource.com>
References: <4017F2C0.4020001@techsource.com>
 <200401291211.05461.chakkerz@optusnet.com.au>
 <40193136.4070607@techsource.com>
 <200401291629.i0TGTN7S001406@81-2-122-30.bradfords.org.uk>
 <40193A67.7080308@techsource.com>
Subject: Re: [OT] Crazy idea:  Design open-source graphics chip
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Timothy Miller <miller@techsource.com>:
>
[snip]

> > Err, well there are always the server and embedded markets, if the
> > device was cheap enough.
> 
> Ah, but it won't be.  Low-volume ASICs are expensive.  The chip itself 
> would probably be around $150, not counting $100k NRE.  Then you have to 
> pay for the board, make up for the NRE, and make some profit to make it 
> worth while.  How much are YOU willing to pay?

Yes, for real world devices there is always the point to be considered
that you can buy a $15 card, and if your requirements are simple
enough, simply ignore the bits that you don't need, and drive it with
open source code.  The cost of developing a much simpler and slightly
cheaper solution outweighs the potential saving, so there is no real
incentive to develop it.

However, if the much simpler but cheaper project already existed, and
was as little as $1 cheaper to produce in volume, would embedded
manufacturers use it?  I suspect they would.

> The thing you have to keep in mind is that in order for this open arch 
> board to get developed, someone has to be willing to invest in 
> fabricating it, and that means it has to be somewhat competitive and a 
> significant performer.

Well, the cost of fabricating depends on the device.  I was basically
thinking of a 68000, an EPROM and a SIMM on a piece of stripboard,
some ribbon cable and a DB-25 connector.

Maybe our goals are somewhat different :-)

John.
