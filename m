Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270800AbTHAP0R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 11:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270801AbTHAP0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 11:26:17 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:2177 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S270800AbTHAP0Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 11:26:16 -0400
Date: Fri, 1 Aug 2003 16:25:07 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Timothy Miller <miller@techsource.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       James Simmons <jsimmons@infradead.org>, Charles Lepple <clepple@ghz.cc>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Turning off automatic screen clanking
Message-ID: <20030801151945.GA12501@mail.jlokier.co.uk>
References: <Pine.LNX.4.44.0307291750170.5874-100000@phoenix.infradead.org> <Pine.LNX.4.53.0307291338260.6166@chaos> <Pine.LNX.4.53.0307292015580.11053@montezuma.mastecende.com> <20030730012533.GA18663@mail.jlokier.co.uk> <Pine.LNX.4.53.0307292136050.11053@montezuma.mastecende.com> <3F2928AD.90501@techsource.com> <Pine.LNX.4.53.0307311056540.9348@montezuma.mastecende.com> <20030731152007.GA6658@mail.jlokier.co.uk> <Pine.LNX.4.53.0307311741090.3779@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0307311741090.3779@montezuma.mastecende.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> > > iirc the screen already unblanks. But it's been a while since i've looked 
> > > at a panic'ing box via the screen.
> > 
> > That's still not good enough if the boot-time crash is not a panic.
> 
> You mean oopses?

I mean if /sbin/init or /linuxrc crash early, for example.

-- Jamie
