Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266230AbUA2QUx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 11:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266232AbUA2QUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 11:20:53 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:32898 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S266230AbUA2QUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 11:20:37 -0500
Date: Thu, 29 Jan 2004 16:29:23 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200401291629.i0TGTN7S001406@81-2-122-30.bradfords.org.uk>
To: Timothy Miller <miller@techsource.com>, chakkerz@optusnet.com.au
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <40193136.4070607@techsource.com>
References: <4017F2C0.4020001@techsource.com>
 <200401291211.05461.chakkerz@optusnet.com.au>
 <40193136.4070607@techsource.com>
Subject: Re: [OT] Crazy idea:  Design open-source graphics chip
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The real question we have to ask ourselves is, what would be the market 
> demand for a graphics card that is 3 generations behind the state of the 
> art and over-priced, the only advantage being that it's a 100% open 
> architecture?

Err, well there are always the server and embedded markets, if the
device was cheap enough.

> I don't have $100k to have it fabricated, so we have to goad some 
> company into doing it for us, and given the volumes, they'll have to 
> charge way more than it's worth if you compare its capabilities against 
> ATI et al.
> 
> I've got some great ideas for how to do this chip, but they're frankly 
> nothing revolutionary.  The obvious test bed is an FPGA.  That imposes 
> serious limitations on what kind of logic utilization and performance we 
> can get.  The ASIC version can be clocked faster, but we dare not put in 
> untested logic.  (And we can't afford the tools necessary to do the 
> proper simulation.)

WHAT!?  You are making the project out to be several orders of
magnitude more difficult and expensive than it is.

Did you know that you can generate a 625-line TV signal with little
more hardware than a Z80 CPU?  Some 8-bits actually did that.

> So, the big question:  How many units a year would be sold for an 
> underpowered, over-priced graphics card that just happens to be 100% 
> open and 100% supported?

Quite a few.  Think of the TV-connected embedded appliance market, for
example.  Displaying a static menu of choices isn't exactly very
demanding.

John.
