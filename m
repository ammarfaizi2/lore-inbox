Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270833AbTHARXE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 13:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270845AbTHARXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 13:23:04 -0400
Received: from [66.212.224.118] ([66.212.224.118]:55568 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S270833AbTHARXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 13:23:02 -0400
Date: Fri, 1 Aug 2003 13:11:20 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Jamie Lokier <jamie@shareable.org>
Cc: Timothy Miller <miller@techsource.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       James Simmons <jsimmons@infradead.org>, Charles Lepple <clepple@ghz.cc>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Turning off automatic screen clanking
In-Reply-To: <20030801151945.GA12501@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.53.0308011310260.32396@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0307291750170.5874-100000@phoenix.infradead.org>
 <Pine.LNX.4.53.0307291338260.6166@chaos> <Pine.LNX.4.53.0307292015580.11053@montezuma.mastecende.com>
 <20030730012533.GA18663@mail.jlokier.co.uk> <Pine.LNX.4.53.0307292136050.11053@montezuma.mastecende.com>
 <3F2928AD.90501@techsource.com> <Pine.LNX.4.53.0307311056540.9348@montezuma.mastecende.com>
 <20030731152007.GA6658@mail.jlokier.co.uk> <Pine.LNX.4.53.0307311741090.3779@montezuma.mastecende.com>
 <20030801151945.GA12501@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Aug 2003, Jamie Lokier wrote:

> Zwane Mwaikambo wrote:
> > > > iirc the screen already unblanks. But it's been a while since i've looked 
> > > > at a panic'ing box via the screen.
> > > 
> > > That's still not good enough if the boot-time crash is not a panic.
> > 
> > You mean oopses?
> 
> I mean if /sbin/init or /linuxrc crash early, for example.

Boottime crashes are different, they are usually reproducible and you 
should just reboot and watch it.

-- 
function.linuxpower.ca
